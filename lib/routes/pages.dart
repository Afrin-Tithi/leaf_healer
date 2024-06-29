import 'package:get/get.dart';
import 'package:leaf_healer/screens/homepage.dart';
import 'package:leaf_healer/screens/intro/intro.dart';
import 'package:leaf_healer/screens/tabItems/tab_bar_screen.dart';

import './routes.dart';

class AppPages {
  static var list = [
    GetPage(name: AppRoutes.home, page: () => const TabBarScreen()),
    GetPage(name: AppRoutes.homePage, page: () => const HomePage()),
    GetPage(name: AppRoutes.intro, page: () => const IntroView()),
  ];
}
