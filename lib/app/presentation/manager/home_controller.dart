// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, duplicate_ignore

import 'package:dio/dio.dart';
import 'package:employees_app/app/domain/entities/employee_entity.dart';
import 'package:employees_app/app/presentation/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/routes/remote_routes.dart';

class HomeController extends GetxController {
  final isUploadingPost = false.obs;
  final isDeletingPost = false.obs;
  final likeInProgress = false.obs;
  Dio dio = Dio();
  Rx<TextEditingController> nameTextEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> salaryTextEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> ageTextEditingController =
      TextEditingController().obs;
  final _employeeList = Future.value(<EmployeeEntity>[]).obs;
  Future<List<EmployeeEntity>> get postsList => _employeeList.value;

  @override
  void onInit() async {
    updateEmployees();
    super.onInit();
  }

  Future<void> updateEmployees() async {
    _employeeList.value = getEmployees();
  }

  Future<List<EmployeeEntity>> getEmployees() async {
    try {
      var dio = Dio();
      var response = await dio.get('${AppRemoteRoutes.baseUrl}employees');

      if (response.statusCode == 200) {
        List<EmployeeEntity> employees = [];

        var data = response.data['data'];

        for (var item in data) {
          var employee = EmployeeEntity(
            id: item['id'],
            name: item['employee_name'],
            salary: item['employee_salary'],
            age: item['employee_age'],
          );

          employees.add(employee);
        }

        return employees;
      } else {
        CustomWidgets.customSnackBar(content: 'Error getting employee');
        return [];
      }
    } catch (error) {
      CustomWidgets.customSnackBar(content: 'Error getting employee');
      return [];
    }
  }

  Future<void> addEmployee(EmployeeEntity employee) async {
    isUploadingPost.value = true;
    try {
      var dio = Dio();
      var response = await dio.post(
        '${AppRemoteRoutes.baseUrl}create',
        data: employee.toJson(),
      );
      if (response.statusCode == 200) {
        Get.back();
        isUploadingPost.value = false;
        updateEmployees();
        CustomWidgets.customSnackBar(content: 'Employee added successfully');
      } else {
        isUploadingPost.value = false;
        Get.back();
        CustomWidgets.customSnackBar(content: 'Error adding employee');
      }
    } catch (error) {
      isUploadingPost.value = false;
      Get.back();
      CustomWidgets.customSnackBar(content: 'Error adding employee');
    }
  }

  Future<void> updateEmployee(EmployeeEntity employee) async {
    isUploadingPost.value = true;
    try {
      var dio = Dio();
      var response = await dio.put(
        '${AppRemoteRoutes.baseUrl}update/${employee.id}',
        data: employee.toJson(),
      );

      if (response.statusCode == 200) {
        Get.back();
        isUploadingPost.value = false;
        updateEmployees();
        CustomWidgets.customSnackBar(content: 'Employee updated successfully');
      } else {
        Get.back();
        CustomWidgets.customSnackBar(content: 'Error updating employee');
        isUploadingPost.value = false;
      }
    } catch (error) {
      Get.back();
      CustomWidgets.customSnackBar(content: 'Error updating employee');
      isUploadingPost.value = false;
    }
  }

  Future<void> deleteEmployee(int id) async {
    try {
      isDeletingPost.value = true;
      var response = await dio.delete(
        "${AppRemoteRoutes.baseUrl}delete/$id",
      );

      if (response.statusCode == 200) {
        Get.back();
        updateEmployees();
        CustomWidgets.customSnackBar(content: 'Employee deleted successfully');
      } else {
        isDeletingPost.value = false;
        Get.back();
        CustomWidgets.customSnackBar(content: 'Error deleting employee');
      }
    } catch (e) {
      isDeletingPost.value = false;
      Get.back();
      CustomWidgets.customSnackBar(content: 'Error deleting employee');
    }
    CustomWidgets.customSnackBar(content: 'Employee deleted successfully');
  }
}
