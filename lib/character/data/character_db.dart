import 'package:path/path.dart';
import 'package:rick_and_morty_flutter/character/model/character_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class CharacterDatabase {
  Future<Database> initDB();

  Future<List<CharacterModel>> getFavouriteCharacters();

  Future<CharacterModel?> getFavouriteCharacterByName(String name);

  Future<void> addCharacterToFavourites(CharacterModel character);

  Future<void> removeCharacterFromFavourites(CharacterModel character);
}

class SQLiteCharacterDatabase implements CharacterDatabase {
  final charactersTableName = 'Character';

  SQLiteCharacterDatabase();

  @override
  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'characters.db');

    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute('CREATE TABLE Character(id INTEGER PRIMARY KEY, name TEXT, status TEXT, imageUrl TEXT, isFavourite INTEGER)');
      },
      version: 1,
    );
  }

  @override
  Future<List<CharacterModel>> getFavouriteCharacters() async {
    Database database = await initDB();
    final List<Map<String, dynamic>> maps = await database.query(charactersTableName);

    return List.generate(maps.length, (i) {
      return CharacterModel.fromMap(maps[i]);
    });
  }

  @override
  Future<CharacterModel?> getFavouriteCharacterByName(String name) async {
    Database database = await initDB();
    final List<Map<String, dynamic>> maps = await database.query(
      charactersTableName,
      where: 'name = ?',
      whereArgs: [name],
    );

    if (maps.isNotEmpty) {
      return CharacterModel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<void> addCharacterToFavourites(CharacterModel character) async {
    Database database = await initDB();

    await database.insert(
      charactersTableName,
      character.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  @override
  Future<void> removeCharacterFromFavourites(CharacterModel character) async {
    Database database = await initDB();
    await database.delete(
      charactersTableName,
      where: 'id = ?',
      whereArgs: [character.id],
    );
  }
}
