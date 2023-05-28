import 'package:employees_app/app/domain/entities/employee_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../manager/home_controller.dart';
import '../widgets/custom_widgets.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 215, 35, 135),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            CustomWidgets().addEmployee(context: context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () => controller.updateEmployees(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Obx(() {
        return controller.likeInProgress.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.pink,
                ),
              )
            : RefreshIndicator(
                onRefresh: () => controller.updateEmployees(),
                child: FutureBuilder<List<EmployeeEntity>>(
                    future: controller.postsList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.pink,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text(
                          'No data found',
                          style: TextStyle(
                            fontSize: 40,
                          ),
                        ));
                      } else {
                        List<EmployeeEntity> dataList = snapshot.data!;
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: dataList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.w,
                                  //  vertical: 2.w,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(dataList[index].name),
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                CustomWidgets().editEmployee(
                                                  context: context,
                                                  dataList: dataList,
                                                  index: index,
                                                );
                                              },
                                              icon: const Icon(Icons.edit),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                CustomWidgets().deleteEmployee(
                                                  context: context,
                                                  dataList: dataList,
                                                  index: index,
                                                );
                                              },
                                              icon: const Icon(Icons.delete),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 0.6.h,
                                    ),
                                    Material(
                                      elevation: 20,
                                      child: Container(
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5.w,
                                            vertical: 2.h,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'ID: ${dataList[index].id}',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                'Age: ${dataList[index].age}',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                'Salary: ${dataList[index].salary}',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }),
              );
      }),
    );
  }
}
