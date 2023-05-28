import 'package:employees_app/app/presentation/pages/home.dart';
import 'package:get/get.dart';
import 'app_pages.dart';

class AppRoutes {

  static final routes = [

    GetPage(
        name: AppPages.home,
        page: () => HomePage(),
        ),

  ];
}
