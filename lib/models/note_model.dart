import 'package:hive/hive.dart';
part 'note_model.g.dart';

@HiveType(typeId: 2)
class Notes extends HiveObject {
  Notes(
      {required this.title, required this.contant, required this.datacreated});

  @HiveField(0)
  String title;

  @HiveField(1)
  String contant;

  @HiveField(2)
  String datacreated;
}
