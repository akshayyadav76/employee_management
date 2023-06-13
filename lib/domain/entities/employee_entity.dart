import 'package:equatable/equatable.dart';

class EmployeeEntity extends Equatable {
  final int? id;
  final String name;
  final String designation;
  final DateTime joiningDate;
  final DateTime? leavingDate;

  const EmployeeEntity(
      {this.id,
      required this.name,
      required this.designation,
      required this.joiningDate,
      this.leavingDate});

  @override
  List<Object?> get props => [id];
}
