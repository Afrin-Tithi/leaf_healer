import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class HomePageController extends GetxController {
  final plantDetails = [
    {
      "name": "Zamioculcas",
      "species": "zamiifolia",
      "description":
          "The Zamioculcas, commonly known as the ZZ Plant, is a nearly indestructible houseplant with its reputation for tolerating neglect. Its waxy, dark green leaves grow from rhizomes beneath the soil surface, creating a lush, upright display. Ideal for low-light environments, the ZZ Plant requires minimal watering and is perfect for those new to plant care or with limited time for maintenance."
    },
    {
      "name": "Spider plant",
      "species": "Chlorophytum comosum",
      "description":
          "The Spider Plant, Chlorophytum comosum, is a versatile and easy-to-grow houseplant known for its long, arching leaves and baby plantlets that dangle from the ends like spiders on a web. It thrives in bright, indirect light and prefers well-drained soil. An excellent air purifier, the Spider Plant is also pet-friendly, making it a great addition to any home."
    },
    {
      "name": "Swiss cheese plant",
      "species": "Monstera deliciosa",
      "description":
          "The Swiss Cheese Plant, or Monstera deliciosa, is a tropical plant recognized by its large, heart-shaped leaves with natural holes and slits. As it matures, the plant can climb and trail, adding a dramatic touch to indoor spaces. It prefers bright, indirect light and high humidity, though it can adapt to lower humidity levels. Regular pruning helps maintain its shape and encourages bushier growth."
    },
    {
      "name": "Plantain lilies",
      "species": "Hosta",
      "description":
          "Plantain Lilies, or Hostas, are a genus of perennial plants known for their attractive foliage ranging from deep green to variegated patterns of white, yellow, and blue-green. They thrive in shaded areas and are valued for their ability to fill in gaps in gardens with minimal care. Hostas come in a wide range of sizes and leaf shapes, offering versatility in landscape design."
    },
    {
      "name": "Zanzibar Gem",
      "species": "Zamioculcas",
      "description":
          "The Zanzibar Gem is a cultivar of the ZZ Plant, distinguished by its glossy, dark green leaves that form a dense, upright cluster. Like its parent plant, it is incredibly resilient, requiring very little water and able to withstand low light conditions. The Zanzibar Gem is an excellent choice for offices, bedrooms, or any space where a touch of greenery is desired without much effort."
    },
    {
      "name": "Wild Mint",
      "species": "Mentha arvensis",
      "description":
          "Wild Mint, Mentha arvensis, is a fast-spreading perennial herb native to North America. Known for its refreshing aroma when crushed, Wild Mint attracts pollinators and makes a delightful addition to herb gardens. It prefers moist soils and partial shade but can tolerate full sun in cooler climates. The leaves are edible and can be used fresh or dried in teas, salads, and sauces."
    },
    {
      "name": "Succulent",
      "species": "Succulents",
      "description":
          "Succulents are a diverse group of plants known for their thick, fleshy leaves and stems that store water, allowing them to survive in dry conditions. These drought-tolerant plants come in various shapes, sizes, and colors, including rosettes, cacti, and jointed forms. Succulents require minimal care, making them ideal for beginners and low-maintenance gardens."
    },
    {
      "name": "Violka zahradní",
      "species": "Viola tricolor",
      "description":
          "Garden Violets, or Viola tricolor, are vibrant, flowering plants that add a splash of color to gardens with their cheerful faces of purple, yellow, and white. They prefer well-drained soil and partial shade, thriving in cooler temperatures. Garden Violets are not only beautiful but also edible, often used in salads or as garnishes due to their sweet taste."
    },
    {
      "name": "Ageratum",
      "species": "Ageratum conyzoides",
      "description":
          "Ageratum is prized for its blue flowers and is one of best blue-flowered annuals available. Ageratum performs best in the late spring and early summer and in the early fall. Some varieties have more heat tolerance especially the vegetatively propagated types."
    },
    {
      "name": "Black-eyed Susan",
      "species": "Rudbeckia hirta",
      "description":
          "Rudbeckia hirta, commonly called black-eyed Susan, is a North American flowering plant in the family Asteraceae, native to Eastern and Central North America and naturalized in the Western part of the continent as well as in China."
    },
  ];
}

class HomePage2 extends StatelessWidget {
  const HomePage2({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
      init: HomePageController(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: SearchAnchor(builder:
                      (BuildContext context, SearchController controller) {
                    return SearchBar(
                      controller: controller,
                      padding: const MaterialStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 16.0)),
                      onTap: () {
                        controller.openView();
                      },
                      onChanged: (_) {
                        controller.openView();
                      },
                      leading: const Icon(Icons.search),
                    );
                  }, suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                    return List<ListTile>.generate(5, (int index) {
                      final List<String> item = [
                        'Zamioculcas',
                        'Spider plant',
                        'Monstera',
                        'Hosta',
                        'Mentha',
                        'Succulents',
                      ];
                      return ListTile(
                        title: Text(item[index]),
                        onTap: () {
                          controller.closeView(item[index]);
                        },
                      );
                    });
                  }),
                ),
                const SizedBox(height: 12),
                Expanded(
                    child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 162,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          clipBehavior: Clip.antiAlias,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12.0),
                            ),
                          ),
                          builder: (BuildContext context) {
                            return GiffyBottomSheet.image(
                              Image.asset(
                                'assets/images/home/plant-$index.png',
                                height: 200,
                                fit: BoxFit.contain,
                              ),
                              title: Text(
                                controller.plantDetails[index]['name']!,
                                textAlign: TextAlign.center,
                              ),
                              content: Text(
                                controller.plantDetails[index]['description']!,
                                textAlign: TextAlign.left,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'CANCEL'),
                                  child: const Text('OK'),
                                )
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.asset(
                                  'assets/images/home/plant-$index.png',
                                ).image)),
                        child: SizedBox(
                            height: 56,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(12)),
                              child: Container(
                                  alignment: Alignment.topLeft,
                                  decoration: const BoxDecoration(),
                                  child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 8, sigmaY: 8),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Text(
                                                  controller.plantDetails[index]
                                                      ['name']!,
                                                  style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 20, 27, 19),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                            ),
                                            Text(
                                              controller.plantDetails[index]
                                                  ['species']!,
                                              style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.889),
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))),
                            )),
                      ),
                    );
                  },
                  itemCount: controller.plantDetails.length,
                )),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
        useMaterial3: true,
        brightness: isDark ? Brightness.dark : Brightness.light);

    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        appBar: AppBar(title: const Text('Search Bar Sample')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              controller: controller,
              padding: const MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0)),
              onTap: () {
                controller.openView();
              },
              onChanged: (_) {
                controller.openView();
              },
              leading: const Icon(Icons.search),
              trailing: <Widget>[
                Tooltip(
                  message: 'Change brightness mode',
                  child: IconButton(
                    isSelected: isDark,
                    onPressed: () {
                      setState(() {
                        isDark = !isDark;
                      });
                    },
                    icon: const Icon(Icons.wb_sunny_outlined),
                    selectedIcon: const Icon(Icons.brightness_2_outlined),
                  ),
                )
              ],
            );
          }, suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
            return List<ListTile>.generate(5, (int index) {
              final String item = 'item $index';
              return ListTile(
                title: Text(item),
                onTap: () {
                  setState(() {
                    controller.closeView(item);
                  });
                },
              );
            });
          }),
        ),
      ),
    );
  }
}
