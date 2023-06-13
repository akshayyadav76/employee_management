// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmployeeTableAdapter extends TypeAdapter<EmployeeTable> {
  @override
  final int typeId = 0;

  @override
  EmployeeTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmployeeTable(
      id: fields[0] as int?,
      name: fields[1] as String,
      designation: fields[2] as String,
      joiningDate: fields[3] as DateTime,
      leavingDate: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, EmployeeTable obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.designation)
      ..writeByte(3)
      ..write(obj.joiningDate)
      ..writeByte(4)
      ..write(obj.leavingDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
