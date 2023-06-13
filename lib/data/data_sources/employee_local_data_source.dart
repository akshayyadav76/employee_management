
import 'package:hive/hive.dart';

import '../table/employee_table.dart';

abstract class EmployeeLocalDataSource {
  Future<List<EmployeeTable>> getEmployees();
  Future<void> addEmployee(EmployeeTable newEmployee);
  Future<void> updateEmployee(EmployeeTable newEmployee);
  Future<void> deleteEmployee(int employeeId);
  Future<int> getEmployeesCount();
}

class EmployeeLocalDataSourceImpl extends EmployeeLocalDataSource {
  @override
  Future<List<EmployeeTable>> getEmployees() async {
    final box = await Hive.openBox('employeeBox');
    final ids = box.keys;
    List<EmployeeTable> employees = [];
    for (var id in ids) {
      employees.add(box.get(id));
    }
    return employees;
  }

  @override
  Future<void> addEmployee(EmployeeTable newEmployee) async {
    final box = await Hive.openBox('employeeBox');
    await box.add(newEmployee);
  }

  @override
  Future<void> updateEmployee(EmployeeTable newEmployee) async {
    final box = await Hive.openBox('employeeBox');
    await box.put(newEmployee.id, newEmployee);
  }

  @override
  Future<void> deleteEmployee(int employeeId) async {
    final box = await Hive.openBox('employeeBox');
    await box.delete(employeeId);
  }

  @override
  Future<int> getEmployeesCount() async {
    final box = await Hive.openBox('employeeBox');
    return box.length;
  }
}
