import 'package:hive/hive.dart';

class DB {
  static final DB _instance = DB._internal();

  DB._internal();
  static DB get i => _instance;

  late Box<dynamic> box;

  DB() {
    box = Hive.box('myBox');
  }

  Future<void> add() async {
    box.put('name', 'David');
  }

  Future<void> get() async {
    var name = box.get('name');
  }
}
