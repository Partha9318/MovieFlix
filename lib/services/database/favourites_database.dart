import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FavouritesDB {
  static final FavouritesDB instance = FavouritesDB._internal();
  static Database? _database;

  FavouritesDB._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'favourites.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favourites (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            release_date TEXT,
            rating REAL,
            vote_count INTEGER,
            description TEXT,
            image TEXT
          )
        ''');
      },
    );
  }

  Future<void> addFavourite({
    required int id,
    required String name,
    String? releaseDate,
    double? rating,
    int? voteCount,
    String? description,
    String? image,
  }) async {
    final db = await database;

    await db.insert('favourites', {
      'id': id,
      'name': name,
      'release_date': releaseDate,
      'rating': rating,
      'vote_count': voteCount,
      'description': description,
      'image': image,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeFavourite(int id) async {
    final db = await database;
    await db.delete('favourites', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getFavourites() async {
    final db = await database;
    return await db.query('favourites', orderBy: 'name ASC');
  }

  Future<bool> isFavourite(int id) async {
    final db = await database;
    final result = await db.query(
      'favourites',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return result.isNotEmpty;
  }
}
