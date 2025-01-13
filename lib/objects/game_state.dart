import 'package:werewolves_of_thiercelieux/objects/game_configuration.dart';

enum GameAction {
  kill,
  revive,
  nothing,
  chooseSomeone,
  chooseTwoPeople,
}

class Player {
  final String name;
  final GameCard role;
  final bool isAlive;

  Player(this.name, this.role, this.isAlive);
}

class GameActionInstance {
  static final Player village = Player('Le village', GameCards.village, true);

  final GameAction action;
  final Player target;
  final Player source;

  GameActionInstance(this.action, this.target, this.source);
}

class GameState {
  final int id;
  final List<Player> players;
  final List<GameActionInstance> actionsHistory;

  int nightCount;
  bool isDay;

  GameState(this.id, this.players, this.actionsHistory, {this.nightCount = 0, this.isDay = true});

  GameState.create(this.players) : id = DateTime.now().millisecondsSinceEpoch, actionsHistory = [], nightCount = 0, isDay = true;

  Map<String, dynamic> serialize() {
    return {
      'id': id,
      'players': players.map((player) => {
        'name': player.name,
        'role': player.role.name,
        'isAlive': player.isAlive,
      }).toList(),
      'actionsHistory': actionsHistory.map((action) => {
        'action': action.action.index,
        'target': action.target.name,
        'source': action.source.name,
      }).toList(),
      'nightCount': nightCount,
      'isDay': isDay,
    };
  }

  static GameState deserialize(Map<String, dynamic> data) {
    final id = data['id'];

    final players = data['players'].map<Player>((playerData) {
      return Player(playerData['name'], GameCards.getCard(playerData['role']), playerData['isAlive']);
    }).toList();

    final actionsHistory = data['actionsHistory'].map<GameActionInstance>((actionData) {
      return GameActionInstance(
        GameAction.values[actionData['action']],
        players.firstWhere((player) => player.name == actionData['target']),
        players.firstWhere((player) => player.name == actionData['source']),
      );
    }).toList();

    final nightCount = data['nightCount'];
    final isDay = data['isDay'];

    return GameState(id, players, actionsHistory, nightCount: nightCount, isDay: isDay);
  }
}