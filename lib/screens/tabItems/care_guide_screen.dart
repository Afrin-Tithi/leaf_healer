import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CareGuideController extends GetxController {
  List<String> title = [
    "Monstera adansonii needs bright but indirect light to grow. The foliage can burn if it's exposed to too much direct sun. If direct sunlight is unavoidable, limit its exposure to just two or three hours of morning sun.",
    "Water your Swiss cheese plant when the top inch of soil is dry. Soil should be be kept moist, but not soaked. A well-draining terracotta container will help to regulate moisture.",
    "Swiss cheese plants grow best in peat-based potting mix, which will help to trap moisture in the soil without causing it to become waterlogged. For strong growth, aim for a soil pH between 5.5 and 7.",
    "A balanced fertilizer made for houseplants with an N-P-K of 5-2-3 should be applied monthly during the growing season (May to September). However, wait until the plant is well established after potting it, as potting mix typically already has slow-release fertilizer in it, and the sensitive roots need time to settle after the stress of being moved."
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

  List<Color> cardColor = [
    const Color(0xFFFE8413),
    const Color(0xFF3F99E0),
    const Color(0xFFA47848),
    const Color(0xFFC64E4E),
  ];

  late YoutubePlayerController _youtubeController;

  @override
  void onInit() {
    super.onInit();
    _initializeYoutubePlayer();
  }

  void _initializeYoutubePlayer() {
    _youtubeController = YoutubePlayerController(
      initialVideoId: '9xZ5J__Xl_4',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void onClose() {
    _youtubeController.dispose();
    super.onClose();
  }
}

class CareGuideScreen extends StatelessWidget {
  const CareGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CareGuideController>(
      init: CareGuideController(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListView.builder(
                itemCount:
                    controller.title.length + 1, // Add one for the video player
                itemBuilder: (BuildContext context, int index) {
                  if (index == controller.title.length) {
                    // Position for the video player
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 12, left: 5, right: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: YoutubePlayer(
                          controller: controller._youtubeController,
                          showVideoProgressIndicator: true,
                        ),
                      ),
                    );
                  } else {
                    return index % 2 == 0
                        ? careCard(
                            controller.title[index],
                            controller.icon[index],
                            controller.cardColor[index],
                            context)
                        : careCard2(
                            controller.title[index],
                            controller.icon[index],
                            controller.cardColor[index],
                            context);
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget careCard(String title, Icon icon, Color color, BuildContext context) {
  return Card(
    color: color,
    elevation: 8.0,
    margin: const EdgeInsets.all(4.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              icon,
              const SizedBox(height: 50.0),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                // Removed maxLines to allow unlimited lines
                overflow: TextOverflow
                    .visible, // Changed to visible since we're allowing multiple lines
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget careCard2(String title, Icon icon, Color color, BuildContext context) {
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
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                // Removed maxLines to allow unlimited lines
                overflow: TextOverflow
                    .visible, // Changed to visible since we're allowing multiple lines
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              icon,
              const SizedBox(height: 50.0),
            ],
          )
        ],
      ),
    ),
  );
}
