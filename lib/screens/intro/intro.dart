import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leaf_healer/components/button.dart';
import 'package:leaf_healer/routes/routes.dart';

const intros = [
  {
    'title': 'Welcome to Leaf Healer',
    'description':
        'Make your day better with Leaf Healer. We are here to help you to heal your plant.',
    'image': 'assets/images/intro1.png',
    'imageBg': 'assets/images/Intro-bg-1.png',
  },
  {
    'title': 'Expertise en Intelligence Artificielle',
    'description':
        'Detect plant disease with machine learning and AI. We are here to help you to heal your plant.',
    'image': 'assets/images/intro2.png',
    'imageBg': 'assets/images/Intro-bg-2.png',
  },
  {
    'title': 'Learn with Leaf Healer',
    'description': 'We are here to help you to heal your plant.',
    'image': 'assets/images/intro1.png',
    'imageBg': 'assets/images/Intro-bg-1.png',
  }
];

class IntroController extends GetxController {
  int index = 0;
}

class IntroView extends StatelessWidget {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IntroController>(
      init: IntroController(),
      builder: (controller) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  intros[controller.index]
                      ['imageBg']!, 
                  fit: BoxFit
                      .cover, 
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 40,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image(
                        image: AssetImage(intros[controller.index]['image']!),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      intros[controller.index]['title']!,
                      overflow: TextOverflow.visible,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      intros[controller.index]['description']!,
                      overflow: TextOverflow.fade,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 45),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (int i = 0; i < intros.length; i++)
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: i == controller.index
                                  ? const Color(0xFF21262E)
                                  : const Color(0xFF21262E).withAlpha(128),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 85, right: 85, top: 20, bottom: 20),
                      child: PButton(
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Next",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          if (controller.index < intros.length - 1) {
                            controller.index++;
                            controller.update();
                          } else {
                            Get.offNamed(AppRoutes.home);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
