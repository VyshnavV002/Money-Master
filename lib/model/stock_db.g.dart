// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StockTrackerAdapter extends TypeAdapter<StockTracker> {
  @override
  final int typeId = 4;

  @override
  StockTracker read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StockTracker(
      stockname: fields[0] as String,
      currstock: fields[1] as int,
      totstock: fields[2] as int,
    )..id = fields[3] as String?;
  }

  @override
  void write(BinaryWriter writer, StockTracker obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.stockname)
      ..writeByte(1)
      ..write(obj.currstock)
      ..writeByte(2)
      ..write(obj.totstock)
      ..writeByte(3)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockTrackerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
