import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';
import 'package:werewolves_of_thiercelieux/objects/game_configuration.dart';
import 'package:werewolves_of_thiercelieux/objects/game_state.dart';


class GameDatabase {
  static final GameDatabase _instance = GameDatabase._internal();

  final String _settingsStoreName = 'settings';
  final String _profilesStoreName = 'profiles';
  final String _gamesStoreName = 'games';
  final String _currentGameStoreName = 'current_game';

  bool _initialized = false;
  late Database _database;

  factory GameDatabase() {
    return _instance;
  }

  GameDatabase._internal();

  Future<void> initialize() async {
    if (_initialized) {
      return;
    }

    _initialized = true;

    log("Initializing database");

    // Initialize the database
    final Directory dir = await getApplicationDocumentsDirectory();
    // make sure it exists
    await dir.create(recursive: true);
    // build the database path
    final dbPath = join(dir.path, 'main_database.db');
    // open the database
    _database = await databaseFactoryIo.openDatabase(dbPath);
  }

  Future<void> _ensureInitialized() async {
    if (!_initialized) {
      await initialize();
    }
  }

  Future<void> close() async {
    await _ensureInitialized();
    await _database.close();
  }

  Future<void> saveSettings(Map<String, dynamic> settings) async {
    await _ensureInitialized();
    final store = intMapStoreFactory.store(_settingsStoreName);
    await store.record(0).put(_database, settings);
  }

  Future<Map<String, dynamic>> loadSettings() async {
    await _ensureInitialized();
    final store = intMapStoreFactory.store(_settingsStoreName);
    return await store.record(0).get(_database) as Map<String, dynamic>;
  }

  Future<GameProfileConfiguration?> loadProfile(int id) async {
    await _ensureInitialized();
    final store = intMapStoreFactory.store(_profilesStoreName);
    final finder = Finder(filter: Filter.equals('id', id));
    final record = await store.findFirst(_database, finder: finder);
    if (record == null) {
      return null;
    }
    return GameProfileConfiguration.deserialize(record.value);
  }

  Future<void> saveProfile(GameProfileConfiguration profile) async {
    await _ensureInitialized();
    final store = intMapStoreFactory.store(_profilesStoreName);
    await store.add(_database, profile.serialize());
  }

  Future<void> removeProfile(int profileId) async {
    await _ensureInitialized();
    final store = intMapStoreFactory.store(_profilesStoreName);
    final finder = Finder(filter: Filter.equals('id', profileId));
    await store.delete(_database, finder: finder);
  }

  Future<void> updateProfile(GameProfileConfiguration profile) async {
    await _ensureInitialized();
    final store = intMapStoreFactory.store(_profilesStoreName);
    final finder = Finder(filter: Filter.equals('id', profile.id));
    await store.update(_database, profile.serialize(), finder: finder);
  }

  Future<List<GameProfileConfiguration>> loadProfiles() async {
    await _ensureInitialized();
    final store = intMapStoreFactory.store(_profilesStoreName);
    final records = await store.find(_database);
    return records.map((record) => GameProfileConfiguration.deserialize(record.value)).toList();
  }

  Future<void> saveGame(GameState game) async {
    await _ensureInitialized();
    final store = intMapStoreFactory.store(_gamesStoreName);
    await store.add(_database, game.serialize());
  }

  Future<void> removeGame(int gameId) async {
    await _ensureInitialized();
    final store = intMapStoreFactory.store(_gamesStoreName);
    final finder = Finder(filter: Filter.equals('true', 'true'));
    await store.delete(_database, finder: finder);
  }
}