import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  // Construtor privado
  DB._();

  // Criar uma instância de DB
  static final DB instance = DB._();

  // Instância do SQLite
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'cripto.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(_conta);
    await db.execute(_carteira);
    await db.execute(_historico);
    await db.insert('conta', {'saldo': 0});
  }

  String get _conta => '''
    CREATE TABLE conta (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      saldo REAL
    )
  ''';

  String get _carteira => '''
    CREATE TABLE carteira (  -- Correção: Nome da tabela agora é "carteira"
      sigla TEXT PRIMARY KEY,
      moeda TEXT,
      quantidade TEXT
    )
  ''';

  String get _historico => '''
    CREATE TABLE historico (  -- Correção: Nome da tabela agora é "historico"
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      data_operacao INT,
      tipo_operacao TEXT,
      moeda TEXT,
      sigla TEXT,
      valor REAL,
      quantidade TEXT
    )
  ''';
}
