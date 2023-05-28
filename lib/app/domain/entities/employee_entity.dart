import 'package:equatable/equatable.dart';

class EmployeeEntity extends Equatable {
  final int id;
  final String name;
  final int salary;
  final int age;

  // ignore: prefer_const_constructors_in_immutables
  EmployeeEntity({required this.name,required this.id, required this.salary, required this.age});

  Map<String, dynamic> toJson() {
    return {
      'employee_name': name,
      'employee_salary': salary,
      'employee_age': age,
    };
  }

  @override
  List<Object?> get props => [id, name, salary ,age ];

  @override
  bool get stringify => true;


}
