

import '../../common/result.dart';
import '../entities/employee_entity.dart';

abstract class EmployeeRepository {
  Future<Result<List<EmployeeEntity>>> getEmployees();
  Future<Result<void>> addEmployee(EmployeeEntity newEmployee);
  Future<Result<void>> editEmployee(EmployeeEntity newEmployee);
  Future<Result<void>> deleteEmployee(int enployeeId);
  Future<int> getEmployeesCount();
}
