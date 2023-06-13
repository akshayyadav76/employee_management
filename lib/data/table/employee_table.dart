import 'package:hive/hive.dart';

import '../../domain/entities/employee_entity.dart';
part 'employee_table.g.dart';

@HiveType(typeId: 0)
class EmployeeTable extends EmployeeEntity {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String designation;

  @HiveField(3)
  final DateTime joiningDate;

  @HiveField(4)
  final DateTime? leavingDate;

  EmployeeTable(
      {required this.id,
      required this.name,
      required this.designation,
      required this.joiningDate,
      required this.leavingDate})
      : super(
          id: id,
          name: name,
          designation: designation,
          joiningDate: joiningDate,
          leavingDate: leavingDate,
        );

  factory EmployeeTable.fromMovieEntity(EmployeeEntity employeeEntity) {
    return EmployeeTable(
        id: employeeEntity.id,
        name: employeeEntity.name,
        designation: employeeEntity.designation,
        joiningDate: employeeEntity.joiningDate,
        leavingDate: employeeEntity.leavingDate);
  }
}
