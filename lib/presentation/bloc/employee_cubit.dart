import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/errors/hive_connection_error.dart';
import '../../domain/entities/employee_entity.dart';
import '../../domain/repositories/employee_repository.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  final EmployeeRepository _employeeRepository;

  EmployeeCubit(this._employeeRepository) : super(EmployeeInitial());

  void loadEmployees() async {
    var result = await _employeeRepository.getEmployees();

    if (result.isSuccess) {
      emit(EmployeeLoadedState(result.value!));
    } else {
      emit(EmployeeErrorState());
    }
  }

  Future<void> addEmployees(
     {required String name,required String role, required DateTime startdate, DateTime? endDate}) async {
    var id = await _employeeRepository.getEmployeesCount() +1;
    var result = await _employeeRepository.addEmployee(
      EmployeeEntity(id: id, name: name, designation: role, joiningDate: startdate,leavingDate: endDate)
    );

    if (result.isSuccess) {
      loadEmployees();
    } else {
      emit(EmployeeErrorState());
    }
  }

}
