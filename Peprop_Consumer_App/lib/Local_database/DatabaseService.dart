
import 'package:path/path.dart';
import 'package:peprop_consumer_app/Local_database/Rec_city.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  // Singleton pattern
  static final DatabaseService _databaseService = DatabaseService._internal();

  factory DatabaseService() => _databaseService;

  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    final path = join(databasePath, 'Peprop_consumer.db');

    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  // When the database is first created, create a table to store breeds
  // and a table to store dogs.
  Future<void> _onCreate(Database db, int version) async {
    // Run the CREATE {breeds} TABLE statement on the database.
    await db.execute(
      'CREATE TABLE cities(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, city_name TEXT)',
    );
    // Run the CREATE {dogs} TABLE statement on the database.

  }

  // Define a function that inserts breeds into the database
  Future<void> insert_city(Rec_city breed) async {
    Rec_city rec_city=await check_exist(breed.city_name);
    if(rec_city==null){
      final db = await _databaseService.database;
      await db.insert(
        'cities',
        breed.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }else{
      await delete(breed.city_name);
      final db = await _databaseService.database;
      await db.insert(
        'cities',
        breed.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

  }
  Future<void> delete(String city_name) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Remove the Breed from the database.
    await db.delete(
      'cities',
      // Use a `where` clause to delete a specific breed.
      where: 'city_name = ?',
      // Pass the Breed's id as a whereArg to prevent SQL injection.
      whereArgs: [city_name],
    );
  }
  Future<Rec_city> check_exist(String name) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
    await db.query('cities', where: 'city_name = ?', whereArgs: [name]);
    return Rec_city.fromMap(maps[0]);
  }


  Future<List<Rec_city>> get_city() async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Query the table for all the Breeds.
    final List<Map<String, dynamic>> maps = await db.query('cities');

    // Convert the List<Map<String, dynamic> into a List<Breed>.
    return List.generate(maps.length, (index) => Rec_city.fromMap(maps[index]));
  }

}
