import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:leaf_healer/routes/pages.dart';
import 'package:leaf_healer/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Leaf Healer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(96, 3, 208, 82)),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.intro,
      getPages: AppPages.list,
    );
  }
}
