import 'package:hive/hive.dart';
part 'locationmodel.g.dart';

@HiveType(typeId: 3)
class Locationsofuser extends HiveObject {
  Locationsofuser(
      {required this.nameoflocation,
      required this.poslat,
      required this.poslang});

  @HiveField(0)
  String nameoflocation;

  @HiveField(1)
  double poslat;
  @HiveField(2)
  double poslang;
}
