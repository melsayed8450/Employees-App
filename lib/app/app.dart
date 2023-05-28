import 'package:employees_app/app/presentation/routes/app_pages.dart';
import 'package:employees_app/app/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class EmployeesApp extends StatelessWidget {
  const EmployeesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        smartManagement: SmartManagement.keepFactory,
        getPages: AppRoutes.routes,
        initialRoute: AppPages.home,
      );
    });
  }
}
