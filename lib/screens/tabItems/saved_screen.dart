import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageThreeController extends GetxController {
  List<Color> cardColor = [
    const Color(0xFF619D57),
    const Color(0xFF3F99E0), // Not used
    const Color(0xFFF0E6E6),
    const Color(0xFFC64E4E),
  ];

  String monsteraInfo = '''
Botanical Name: Monstera adansonii
Family: Araceae
Plant Type: Perennial
Mature Size: 10–13 ft. tall (outdoors), 3–8 ft. tall (indoors), 1–3 ft. wide
Sun Exposure: Partial
Soil Type: Moist, well-drained
Bloom Time: Spring (does not bloom indoors)
Flower Color: White
'''
      .trimRight();
}

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PageThreeController>(
      init: PageThreeController(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Image.asset('assets/images/saved_image1.png',
                                fit: BoxFit.cover),
                            const SizedBox(
                              height: 10,
                            ),
                            Image.asset('assets/images/saved_image3.png',
                                fit: BoxFit.cover),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Image.asset('assets/images/saved_image2.png',
                                  fit: BoxFit.cover),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: savedCard(
                                  "Tips for Caring Siss Cheese Plant",
                                  controller.cardColor[0],
                                  context,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  savedCard2(
                    "Monstera deliciosa",
                    "The native range of this species is Mexico (Veracruz, Oaxaca, Chiapas) to Guatemala. It is a liana and grows primarily in the wet tropical biome. It is has environmental uses and social uses, as a poison and a medicine and for food.",
                    controller.cardColor[0],
                    context,
                  ),
                  const SizedBox(height: 5.0),
                  savedCard3(
                    controller.monsteraInfo,
                    controller.cardColor[2],
                    context,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget savedCard(String title, Color color, BuildContext context) {
  return Card(
    color: color,
    elevation: 8.0,
    margin: const EdgeInsets.all(4.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.visible,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget savedCard2(
    String title, String body, Color color, BuildContext context) {
  return Card(
    color: color,
    elevation: 8.0,
    margin: const EdgeInsets.all(4.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    body,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget savedCard3(String title, Color color, BuildContext context) {
  return Card(
    color: color,
    elevation: 8.0,
    margin: const EdgeInsets.all(4.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.visible,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
