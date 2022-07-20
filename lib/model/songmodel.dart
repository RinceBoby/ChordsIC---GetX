import 'package:chordsic/main.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'songmodel.g.dart';

@HiveType(typeId: 15)
class Songs extends HiveObject {
  @HiveField(0)
  String? artist;
  @HiveField(1)
  String? songname;
  @HiveField(2)
  int? duration;
  @HiveField(3)
  String? songurl;
  @HiveField(4)
  int? id;
  Songs({
    required this.id,
    required this.artist,
    required this.duration,
    required this.songname,
    required this.songurl,
  });
}


class Boxes{
  static Box<List>getInstance(){
    return Hive.box<List>(boxname);
  }
}