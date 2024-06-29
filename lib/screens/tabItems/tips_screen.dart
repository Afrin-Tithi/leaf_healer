import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TipsScreenController extends GetxController {
  String card2Text = "Provide well-draining soil for your cheese plant.\n"
      "Water your cheese plant regularly; let the soil dry out and then moisten thoroughly.\n"
      "Add a stake or moss pole to the center of the pot to give your Swiss cheese plant a structure to climb on\n"
      "Fertilize your cheese plant with a balanced houseplant fertilizer, after it is well-established.\n"
      "Prune your cheese plant lightly and regularly as needed.";

  List<Color> cardColor = [
    const Color(0xFF619D57),
    const Color(0xFF3F99E0), // Not used
    const Color(0xFFF0E6E6),
    const Color(0xFFC64E4E),
  ];

  List<Color> cardColor2 = [
    const Color(0xFFFE8413),
    const Color(0xFF3F99E0),
    const Color(0xFFA47848),
    const Color(0xFFC64E4E),
  ];

  List<Icon> icon = [
    const Icon(
      Icons.wb_sunny,
      color: Colors.white,
      size: 34,
    ),
    const Icon(
      Icons.water_drop_outlined,
      color: Colors.black,
      size: 34,
    ),
    const Icon(
      Icons.grain,
      color: Colors.white,
      size: 34,
    ),
    const Icon(
      Icons.local_fire_department_outlined,
      color: Colors.black,
      size: 34,
    )
  ];

  List<String> title = [
    "60°F to 85°F",
    "Water every 1-2 weeks",
    "Soil pH is 5.5 and 7",
    "N-P-K of 5-2-3",
  ];
}

class TipsScreen extends StatelessWidget {
  const TipsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TipsScreenController>(
      init: TipsScreenController(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListView(
                children: [
                  tipsCard(
                    "Tips for Caring Siss Cheese Plant",
                    controller.cardColor[0],
                    context,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Image.asset('assets/images/tips-card2.png',
                        fit: BoxFit.cover),
                  ),
                  tipsCard2(
                    controller.card2Text,
                    controller.cardColor[2],
                    context,
                  ),
                  const SizedBox(height: 12.0),
                  SizedBox(
                    height: 140,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return tipsCard3(
                          controller.title[index],
                          controller.cardColor2[index],
                          controller.icon[index],
                          context,
                        );
                      },
                    ),
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

Widget tipsCard(String title, Color color, BuildContext context) {
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

Widget tipsCard3(String title, Color color, Icon icon, BuildContext context) {
  return Card(
    color: color,
    elevation: 8.0,
    margin: const EdgeInsets.all(4.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  const SizedBox(height: 10.0),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget tipsCard2(String title, Color color, BuildContext context) {
  String formattedTitle = "⚫ ${title.replaceAll('\n', '\n⚫')}";

  return Card(
    color: color,
    elevation: 8.0,
    margin: const EdgeInsets.all(4.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            textAlign: TextAlign.left,
            textDirection: TextDirection.ltr,
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                    text: formattedTitle,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    )),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
