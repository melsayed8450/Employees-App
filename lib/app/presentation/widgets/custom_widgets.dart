import 'dart:math';
import 'package:employees_app/app/domain/entities/employee_entity.dart';
import 'package:employees_app/app/presentation/manager/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CustomWidgets {
  final controller = Get.put(HomeController());
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      duration: const Duration(milliseconds: 1250),
      backgroundColor: Colors.black,
      behavior: SnackBarBehavior.floating,
      content: Text(
        content,
        style: const TextStyle(color: Colors.white, letterSpacing: 0.5),
      ),
    );
  }

  void deleteEmployee({
    required context,
    required dataList,
    required index,
  }) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Alert'),
        content: const Text('Are you sure you want to delete this Employee?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Cancel',
            ),
          ),
          TextButton(
            onPressed: () async {
              await controller.deleteEmployee(
                dataList[index].id,
              );
            },
            child: Obx(() {
              return controller.isDeletingPost.value
                  ? const CircularProgressIndicator(
                      color: Colors.pink,
                    )
                  : const Text(
                      'Yes, Delete',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                      ),
                    );
            }),
          ),
        ],
      ),
    );
  }

  void editEmployee({required context, required dataList, required index}) {
    controller.nameTextEditingController.value.clear();
    controller.salaryTextEditingController.value.clear();
    controller.ageTextEditingController.value.clear();
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return ScaffoldMessenger(
            key: scaffoldMessengerKey,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Obx(() {
                return Stack(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller:
                                  controller.nameTextEditingController.value,
                              decoration: InputDecoration(
                                labelText: 'Name',
                                labelStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 215, 35, 135),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white,
                              ),
                              child: TextField(
                                controller: controller
                                    .salaryTextEditingController.value,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Salary',
                                  labelStyle: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 215, 35, 135),
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 5.h),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white,
                              ),
                              child: TextField(
                                controller:
                                    controller.ageTextEditingController.value,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Age',
                                  labelStyle: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 215, 35, 135),
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                              onPressed: () async {
                                if (controller.nameTextEditingController.value
                                        .text.isEmpty ||
                                    controller.salaryTextEditingController.value
                                        .text.isEmpty ||
                                    controller.ageTextEditingController.value
                                        .text.isEmpty) {
                                  scaffoldMessengerKey.currentState
                                      ?.showSnackBar(
                                    CustomWidgets.customSnackBar(
                                      content: 'Please fill all the data',
                                    ),
                                  );
                                } else {
                                  await controller.updateEmployee(
                                      EmployeeEntity(
                                          name: controller
                                              .nameTextEditingController
                                              .value
                                              .text,
                                          id: Random().nextInt(100),
                                          salary: int.parse(
                                              controller
                                                  .salaryTextEditingController
                                                  .value
                                                  .text),
                                          age: int.parse(controller
                                              .ageTextEditingController
                                              .value
                                              .text)));
                                }
                              },
                              child: Container(
                                width: 40.w,
                                height: 5.h,
                                decoration: BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: controller.isUploadingPost.value
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Center(
                                        child: Text(
                                          'Edit Post',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                              )),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          );
        });
  }

  void addEmployee({required context}) {
    controller.nameTextEditingController.value.clear();
    controller.salaryTextEditingController.value.clear();
    controller.ageTextEditingController.value.clear();
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return ScaffoldMessenger(
            key: scaffoldMessengerKey,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Obx(() {
                return Stack(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller:
                                  controller.nameTextEditingController.value,
                              decoration: InputDecoration(
                                labelText: 'Name',
                                labelStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 215, 35, 135),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white,
                              ),
                              child: TextField(
                                controller: controller
                                    .salaryTextEditingController.value,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Salary',
                                  labelStyle: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 215, 35, 135),
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 5.h),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white,
                              ),
                              child: TextField(
                                controller:
                                    controller.ageTextEditingController.value,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Age',
                                  labelStyle: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 215, 35, 135),
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                              onPressed: () async {
                                if (controller.nameTextEditingController.value
                                        .text.isEmpty ||
                                    controller.salaryTextEditingController.value
                                        .text.isEmpty ||
                                    controller.ageTextEditingController.value
                                        .text.isEmpty) {
                                  scaffoldMessengerKey.currentState
                                      ?.showSnackBar(
                                    CustomWidgets.customSnackBar(
                                      content: 'Please fill all the data',
                                    ),
                                  );
                                } else {
                                  await controller.addEmployee(EmployeeEntity(
                                      name: controller
                                          .nameTextEditingController.value.text,
                                      id: Random().nextInt(100),
                                      salary: int.parse(controller
                                          .salaryTextEditingController
                                          .value
                                          .text),
                                      age: int.parse(controller
                                          .ageTextEditingController
                                          .value
                                          .text)));
                                }
                              },
                              child: Container(
                                width: 40.w,
                                height: 5.h,
                                decoration: BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: controller.isUploadingPost.value
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Center(
                                        child: Text(
                                          'Add Post',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                              )),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          );
        });
  }
}
