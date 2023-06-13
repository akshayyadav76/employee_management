
import 'package:employee_management/data/errors/hive_connection_error.dart';
import 'package:employee_management/domain/repositories/employee_repository.dart';

import '../../common/result.dart';
import '../../domain/entities/employee_entity.dart';
import '../data_sources/employee_local_data_source.dart';
import '../table/employee_table.dart';

class EmployeeRepositoryImpl extends EmployeeRepository {
  final EmployeeLocalDataSource _localDataSource;

  EmployeeRepositoryImpl(this._localDataSource);

  @override
  Future<Result<List<EmployeeEntity>>> getEmployees() async {
    try {
      return Result.success(await _localDataSource.getEmployees());
    } on Exception {
      return Result.failure(HiveConnectionError());
    }
  }

  @override
  Future<Result<void>> addEmployee(EmployeeEntity newEmployee) async {
    try {
      return Result.success(await _localDataSource
          .addEmployee(EmployeeTable.fromMovieEntity(newEmployee)));
    } on Exception {
      return Result.failure(HiveConnectionError());
    }
  }

  @override
  Future<Result<void>> deleteEmployee(int enployeeId) async {
    try {
      return Result.success(await _localDataSource.deleteEmployee(enployeeId));
    } on Exception {
      return Result.failure(HiveConnectionError());
    }
  }

  @override
  Future<Result<void>> editEmployee(EmployeeEntity newEmployee) async {
    try {
      return Result.success(await _localDataSource
          .updateEmployee(EmployeeTable.fromMovieEntity(newEmployee)));
    } on Exception {
      return Result.failure(HiveConnectionError());
    }
  }
  
  @override
  Future<int> getEmployeesCount()async {
  return await _localDataSource.getEmployeesCount();
  }
}
