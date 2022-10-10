class DB {
  static final DB _instance = DB._internal();

  DB._internal();
  static DB get i => _instance;
}
