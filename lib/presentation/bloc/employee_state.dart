part of 'employee_cubit.dart';



abstract class EmployeeState extends Equatable {
  const EmployeeState();
}

class EmployeeInitial extends EmployeeState {
  @override
  List<Object?> get props => [];
}

class EmployeeLoadedState extends EmployeeState {
  final List<EmployeeEntity> employees;

 const EmployeeLoadedState(this.employees);
  
  @override
  List<Object?> get props => [employees];
}

class EmployeeErrorState extends EmployeeState {
  final HiveConnectionError connectionError = HiveConnectionError();
  
  @override
  List<Object?> get props => [];
}



