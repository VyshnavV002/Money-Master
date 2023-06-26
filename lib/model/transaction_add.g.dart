// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_add.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddTransactionAdapter extends TypeAdapter<AddTransaction> {
  @override
  final int typeId = 3;

  @override
  AddTransaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddTransaction(
      purpose: fields[0] as String,
      amount: fields[1] as double,
      date: fields[2] as DateTime,
      ctype: fields[3] as CategoryType,
      modal: fields[4] as CategoryModal,
    )..id = fields[5] as String?;
  }

  @override
  void write(BinaryWriter writer, AddTransaction obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.purpose)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.ctype)
      ..writeByte(4)
      ..write(obj.modal)
      ..writeByte(5)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddTransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
