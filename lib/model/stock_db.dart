import 'package:hive/hive.dart';

part 'stock_db.g.dart';

@HiveType(typeId: 4)
class StockTracker {
  @HiveField(0)
  final String stockname;
  @HiveField(1)
  final int currstock;
  @HiveField(2)
  final int totstock;
  @HiveField(3)
  String? id;

  StockTracker({
    required this.stockname,
    required this.currstock,
    required this.totstock,
  }){
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}
