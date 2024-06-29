import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leaf_healer/screens/tabItems/camera_screen.dart';
import 'package:leaf_healer/screens/tabItems/care_guide_screen.dart';
import 'package:leaf_healer/screens/tabItems/home_screen.dart';
import 'package:leaf_healer/screens/tabItems/saved_screen.dart';
import 'package:leaf_healer/screens/tabItems/tips_screen.dart';

class TabBarScreenController extends GetxController {
  int index = 0;
  final navBarcontroller = NotchBottomBarController();

  @override
  void onInit() {
    super.onInit();
    navBarcontroller.index = 2;
  }
}

class TabBarScreen extends StatelessWidget {
  const TabBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize PageController
    return GetBuilder<TabBarScreenController>(
      init: TabBarScreenController(),
      builder: (controller) {
        return Scaffold(
          body: IndexedStack(
              index: controller.navBarcontroller.index,
              children: const [
                HomePage2(),
                TipsScreen(),
                CameraScreen(),
                CareGuideScreen(),
                SavedScreen(),
              ]),
          bottomNavigationBar: AnimatedNotchBottomBar(
            bottomBarItems: const [
              BottomBarItem(
                inActiveItem: Icon(
                  Icons.home_filled,
                  color: Color.fromARGB(255, 121, 159, 124),
                ),
                activeItem: Icon(
                  Icons.home_filled,
                  color: Colors.green,
                ),
                itemLabel: 'Home',
              ),
              BottomBarItem(
                inActiveItem: Icon(
                  Icons.spa,
                  color: Color.fromARGB(255, 121, 159, 124),
                ),
                activeItem: Icon(
                  Icons.spa,
                  color: Colors.green,
                ),
                itemLabel: 'Tips',
              ),
              BottomBarItem(
                inActiveItem: Icon(
                  Icons.crop_free,
                  color: Color.fromARGB(255, 121, 159, 124),
                ),
                activeItem: Icon(
                  Icons.crop_free,
                  color: Colors.green,
                ),
                itemLabel: 'Scan',
              ),
              BottomBarItem(
                inActiveItem: Icon(
                  Icons.subject,
                  color: Color.fromARGB(255, 121, 159, 124),
                ),
                activeItem: Icon(
                  Icons.subject,
                  color: Colors.green,
                ),
                itemLabel: 'Guide',
              ),
              BottomBarItem(
                inActiveItem: Icon(
                  Icons.bookmark,
                  color: Color.fromARGB(255, 121, 159, 124),
                ),
                activeItem: Icon(
                  Icons.bookmark,
                  color: Colors.green,
                ),
                itemLabel: 'Saved',
              ),
              // Add more items as needed
            ],
            notchBottomBarController: controller.navBarcontroller,
            onTap: (int value) {
              controller.update();
            },
            kIconSize: 24,
            kBottomRadius: 20,
          ),
        );
      },
    );
  }
}
