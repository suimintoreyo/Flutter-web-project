import 'package:serverpod/serverpod.dart';

class User extends TableRow {
  @override
  String get tableName => 'users';

  @override
  int? id;
  late String email;
  late String hashedPassword;
  late DateTime createdAt;

  User({this.id, required this.email, required this.hashedPassword, required this.createdAt});

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        email = json['email'] as String,
        hashedPassword = json['hashedPassword'] as String,
        createdAt = DateTime.parse(json['createdAt'] as String);

  @override
  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'email': email,
        'hashedPassword': hashedPassword,
        'createdAt': createdAt.toIso8601String(),
      };

  static final t = UserTable();

  static Future<List<User>> find(
    Session session, {
    UserExpressionBuilder? where,
    int? limit,
    int? offset,
    Column? orderBy,
    bool orderDescending = false,
  }) async {
    return session.db.find<User>(
      where: where?.call(t),
      limit: limit,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
    );
  }

  static Future<User?> findSingleRow(
    Session session, {
    UserExpressionBuilder? where,
  }) async {
    return session.db.findSingleRow<User>(
      where: where?.call(t),
    );
  }

  static Future<int> count(
    Session session, {
    UserExpressionBuilder? where,
    int? limit,
    bool? useCache,
  }) async {
    return session.db.count<User>(
      where: where?.call(t),
      limit: limit,
      useCache: useCache,
    );
  }

  static Future<void> insert(Session session, User row) async {
    await session.db.insert<User>(row);
  }
}

typedef UserExpressionBuilder = Expression Function(UserTable);

class UserTable extends Table {
  UserTable() : super(tableName: 'users');

  late final ColumnInt id = ColumnInt('id', this);
  late final ColumnString email = ColumnString('email', this);
  late final ColumnString hashedPassword = ColumnString('hashedPassword', this);
  late final ColumnDateTime createdAt = ColumnDateTime('createdAt', this);

  @override
  List<Column> get columns => [id, email, hashedPassword, createdAt];
}
