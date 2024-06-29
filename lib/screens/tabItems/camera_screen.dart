import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leaf_healer/constants/constants.dart';
import 'package:leaf_healer/models/enums/scan_mode.dart';
import 'package:leaf_healer/services/api_service.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() {
    return _CameraExampleHomeState();
  }
}

class _CameraExampleHomeState extends State<CameraScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  final String invalidImageDetectedText = 'Please pick another image';
  final String invalidImageDetectedText2 = 'I don\'t know.';
  bool get isImageFailedToDetect {
    return diseaseName == invalidImageDetectedText ||
        diseaseName == invalidImageDetectedText2 ||
        diseaseName == '';
  }

  ScanMode _scanMode = ScanMode.camera;
  List<CameraDescription> cameras = [];
  CameraController? controller;
  XFile? imageFile;

  File? _selectedImage;
  final apiService = ApiService();
  String diseaseName = '';
  String diseasePrecautions = '';
  bool detecting = false;
  bool precautionLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadBackCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller?.dispose();
    super.dispose();
  }

  // #docregion AppLifecycle
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

  // #enddocregion AppLifecycle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: switch (_scanMode) {
        ScanMode.camera => Stack(
            fit: StackFit.expand, // Make the stack fill the entire screen
            children: [
              // Camera Preview
              Positioned.fill(
                child: cameraPreviewWidget(controller),
              ),
              // Overlay Text
              // Overlay Text
              const Positioned(
                top:
                    50.0, // Adjust this value to move the text closer or further from the top edge
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    '', // Your overlay text
                    style: TextStyle(
                      color: Color.fromARGB(255, 235, 3, 92),
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Capture Button
              Positioned(
                bottom:
                    20.0, // Adjust this value to move the button closer or further from the bottom edge
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      const Spacer(),
                      Container(
                          child: galleryControlRowWidget(controller,
                              () => _pickImage(ImageSource.gallery))),
                      const SizedBox(width: 12),
                      Container(
                          child: captureControlRowWidget(
                              controller, onTakePictureButtonPressed)),
                      const SizedBox(width: 12),
                      Container(
                          child: tipsControlRowWidget(
                              controller, onTakePictureButtonPressed)),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              // Camera Toggle Buttons
              Positioned(
                bottom: 80.0, // Adjust position as needed
                left: 20.0, // Adjust position as needed
                child: cameraTogglesRowWidget(
                    controller, cameras, onNewCameraSelected),
              ),
              // Thumbnail Widget
              Positioned(
                bottom: 130.0, // Adjust position as needed
                right: 20.0, // Adjust position as needed
                child: thumbnailWidget(imageFile),
              ),
              Positioned.fill(
                child: Center(
                  child: Image.asset(
                    'assets/images/cameraOverlay.png',
                    fit: BoxFit.contain, // Adjust the fit property as needed
                  ),
                ),
              )
            ],
          ),
        ScanMode.gallery => SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                _selectedImage == null
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Image.asset('assets/images/pick1.png'),
                      )
                    : Container(
                        height: 280,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.all(20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            _selectedImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                if (_selectedImage != null)
                  detecting
                      ? SpinKitWave(
                          color: themeColor,
                          size: 30,
                        )
                      : Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 20),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: themeColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              // Set some horizontal and vertical padding
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    15), // Rounded corners
                              ),
                            ),
                            onPressed: () {
                              detectDisease();
                            },
                            child: const Text(
                              'DETECT',
                              style: TextStyle(
                                color:
                                    Colors.white, // Set the text color to white
                                fontSize: 16, // Set the font size
                                fontWeight: FontWeight
                                    .bold, // Set the font weight to bold
                              ),
                            ),
                          ),
                        ),
                if (diseaseName != '')
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        // ignore: prefer_const_constructors
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DefaultTextStyle(
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                              child: AnimatedTextKit(
                                  isRepeatingAnimation: false,
                                  repeatForever: false,
                                  displayFullTextOnTap: true,
                                  totalRepeatCount: 1,
                                  animatedTexts: [
                                    TyperAnimatedText(
                                      diseaseName.trim(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ]),
                            )
                          ],
                        ),
                      ),
                      if (isImageFailedToDetect == false)
                        precautionLoading
                            ? const SpinKitWave(
                                color: AppColors.primary300Color,
                                size: 30,
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: themeColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 15),
                                ),
                                onPressed: () {
                                  showPrecautions();
                                },
                                child: Text(
                                  'PRECAUTION',
                                  style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                    ],
                  ),
                const SizedBox(height: 100),
              ],
            ),
          ),
      },
      floatingActionButton: _scanMode == ScanMode.gallery
          ? FloatingActionButton.extended(
              // foregroundColor: Colors.white,
              // backgroundColor: Colors.amber,
              elevation: 3,
              shape: const StadiumBorder(),
              extendedPadding: const EdgeInsets.symmetric(horizontal: 15),
              onPressed: _onSwitchModeTap,
              icon: const Icon(Icons.replay_circle_filled_rounded),
              label: const Text(
                'Try another image',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ))
          : null,
    );
  }

  Future<void> _loadBackCamera() async {
    try {
      cameras = await availableCameras();

      setState(() {});
    } catch (e) {
      print("Error loading cameras: $e");
    }
  }

  Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
    final CameraController? oldController = controller;

    if (oldController != null) {
      // `controller` needs to be set to null before getting disposed,
      // to avoid a race condition when we use the controller that is being
      // disposed. This happens when camera permission dialog shows up,
      // which triggers `didChangeAppLifecycleState`, which disposes and
      // re-creates the controller.
      controller = null;
      await oldController.dispose();
    }

    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    controller = cameraController;

    // If the controller is updated then update the UI.
    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (cameraController.value.hasError) {
        print('Camera error ${cameraController.value.errorDescription}');
      }
    });

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          print('You have denied camera access.');
          break;
        case 'CameraAccessDeniedWithoutPrompt':
          // iOS only
          print('Please go to Settings app to enable camera access.');
          break;
        case 'CameraAccessRestricted':
          // iOS only
          print('Camera access is restricted.');
          break;
        default:
          break;
      }
    }
  }

  Future onTakePictureButtonPressed() async {
    print("+++++1");
    final picture = await takePicture();
    print("PICTURE!!!!!: " + picture.toString());
    if (picture != null) {
      _selectedImage = File(picture.path);
      _scanMode = ScanMode.gallery;
      diseaseName = '';
      setState(() {});
      print('🎃🎃🎃🎃🎃🎃🎃 Picture saved to ${picture.path}');
    }
  }

  Future _pickImage(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 50);
    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      _scanMode = ScanMode.gallery;
      diseaseName = '';
      setState(() {});
    }
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      print('!!!!!!!!!!!! Error: select a camera first.');
      return null;
    }
    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      print("CAMERA ERROR: " + e.toString());
      return null;
    }
  }

/*   Future<void> _pickImage(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 50);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  } */

  detectDisease() async {
    setState(() {
      detecting = true;
    });
    try {
      diseaseName =
          await apiService.sendImageToGPT4Vision(image: _selectedImage!);
    } catch (error) {
      _showErrorSnackBar(error);
    } finally {
      setState(() {
        detecting = false;
      });
    }
  }

  showPrecautions() async {
    setState(() {
      precautionLoading = true;
    });
    try {
      if (diseasePrecautions == '') {
        diseasePrecautions =
            await apiService.sendMessageGPT(diseaseName: diseaseName);
      }
      _showSuccessDialog(diseaseName, diseasePrecautions);
    } catch (error) {
      _showErrorSnackBar(error);
    } finally {
      setState(() {
        precautionLoading = false;
      });
    }
  }

  void _showErrorSnackBar(Object error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(error.toString()),
      backgroundColor: Colors.red,
    ));
  }

  void _showSuccessDialog(String title, String content) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: title,
      desc: content,
      btnOkText: 'Got it',
      btnOkColor: themeColor,
      btnOkOnPress: () {},
    ).show();
  }

  void _onSwitchModeTap() {
    _scanMode = switch (_scanMode) {
      ScanMode.camera => ScanMode.gallery,
      ScanMode.gallery => ScanMode.camera,
    };
    switch (_scanMode) {
      case ScanMode.camera:
        diseaseName = '';
        diseasePrecautions = '';
        imageFile = null;
        break;
      case ScanMode.gallery:
        break;
    }
    setState(() {});
  }
}

Widget captureControlRowWidget(
  CameraController? controller,
  void Function() onTakePictureButtonPressed,
) {
  // Replace this with the actual path to your image asset
  const String imagePath = 'assets/images/camera_button.png';

  return InkWell(
    onTap: controller != null && controller.value.isInitialized
        ? onTakePictureButtonPressed
        : null,
    child: Image.asset(
      imagePath,
      width: 88,
      height: 88, // This will tint the image blue
    ),
  );
}

Widget galleryControlRowWidget(
  CameraController? controller,
  void Function() onTakePictureButtonPressed,
) {
  // Replace this with the actual path to your image asset
  const String imagePath = 'assets/images/photo_gallery.png';

  return InkWell(
    onTap: onTakePictureButtonPressed,
    child: Image.asset(
      imagePath,
      width: 88,
      height: 88, // This will tint the image blue
    ),
  );
}

Widget tipsControlRowWidget(
  CameraController? controller,
  void Function() onTakePictureButtonPressed,
) {
  // Replace this with the actual path to your image asset
  const String imagePath = 'assets/images/snap_tips.png';

  return InkWell(
    onTap: controller != null && controller.value.isInitialized
        ? onTakePictureButtonPressed
        : null,
    child: Image.asset(
      imagePath,
      width: 88,
      height: 88, // This will tint the image blue
    ),
  );
}

Widget cameraPreviewWidget(CameraController? controller) {
  if (controller == null || !controller.value.isInitialized) {
    return const Text(
      'Tap a camera',
      style: TextStyle(
        color: Colors.white,
        fontSize: 24.0,
        fontWeight: FontWeight.w900,
      ),
    );
  } else {
    return CameraPreview(controller);
  }
}

Widget cameraTogglesRowWidget(
  CameraController? controller,
  List<CameraDescription> cameras,
  Future<void> Function(CameraDescription cameraDescription)
      onNewCameraSelected,
) {
  final List<Widget> toggles = [];

  void onChanged(CameraDescription? description) {
    print(description);
    if (description == null) {
      return;
    }

    onNewCameraSelected(description);
  }

  if (cameras.isEmpty) {
    print("Cameras empty");
    return const Text('');
  } else {
    for (final CameraDescription cameraDescription in cameras) {
      toggles.add(
        SizedBox(
          width: 90.0,
          child: RadioListTile<CameraDescription>(
            title: Icon(cameraLensIcon(cameraDescription.lensDirection)),
            groupValue: controller?.description,
            value: cameraDescription,
            onChanged: onChanged,
          ),
        ),
      );
    }
  }
  return Row(children: toggles);
}

IconData cameraLensIcon(CameraLensDirection direction) {
  if (direction == CameraLensDirection.back) {
    return Icons.camera_rear;
  } else if (direction == CameraLensDirection.front) {
    return Icons.camera_front;
  }
  throw Exception("unknown direction error: $direction");
}

Widget thumbnailWidget(XFile? imageFile) {
  return Expanded(
    child: Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (imageFile == null)
            Container()
          else
            SizedBox(
                width: 64.0,
                height: 64.0,
                child: Image.file(File(imageFile.path)))
        ],
      ),
    ),
  );
}
