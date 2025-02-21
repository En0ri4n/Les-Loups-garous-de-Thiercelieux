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

enum GameState {
  villageFallsAsleep,
  night,
  villageWakesUp,
  villageMeeting,
  villageVote,
  villageVoteResult,
}

class GameStep {
  int step;
  int maxStep;
  int playerCount;

  GameStep(List<Player> players) : step = 0, maxStep = calculateStepCount(players), playerCount = players.length;
  GameStep.load(this.step, List<Player> players) : maxStep = calculateStepCount(players), playerCount = players.length;

  GameState getCurrentState() {
    if (step == 0) {
      return GameState.villageFallsAsleep;
    } else if (step >= 1 && step <= playerCount) {
      return GameState.night;
    } else if (step == 1 + playerCount) {
      return GameState.villageWakesUp;
    } else if (step == 2 + playerCount) {
      return GameState.villageMeeting;
    } else if (step == 3 + playerCount) {
      return GameState.villageVote;
    } else {
      return GameState.villageVoteResult;
    }
  }

  void next() {
    step++;
    if (step >= maxStep) {
      step = 0;
    }
  }

  static int calculateStepCount(List<Player> players) {
    return
        1   // Village falls asleep
        + WerewolfGame.getCardsWith(players, PlayTiming.night).length // Night
        + 1   // Village wakes up
        + 1   // Village discussion
        + 1   // Village vote
        + 1;  // Village vote result
  }
}

class WerewolfGame {
  final int id;
  final List<Player> players;
  final List<GameActionInstance> actionsHistory;
  final int time;

  int nightCount;
  GameStep gameStep;

  WerewolfGame(this.id, this.players, this.actionsHistory, this.time, {required this.nightCount, required this.gameStep});

  WerewolfGame.fromProfile(GameProfileConfiguration profile) :
        id = DateTime.now().millisecondsSinceEpoch,
        players = profile.generatePlayers(),
        actionsHistory = [],
        time = 0,
        nightCount = 0,
        gameStep = GameStep([]) {
    gameStep = GameStep(players);
  }

  void nextStep() {
    gameStep.next();
  }

  GameCard getCardForStep() {
    return getCardsWith(players, PlayTiming.night)[gameStep.step - 1];
  }

  static List<GameCard> getCardsWith(List<Player> players, PlayTiming timing) {
    return players.where((p) => p.role.timing == timing).map((p) => p.role).toList();
  }

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
      'time': time,
      'nightCount': nightCount,
      'gameStep': gameStep.step,
    };
  }

  static WerewolfGame deserialize(Map<String, dynamic> data) {
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

    final time = data['time'];

    final nightCount = data['nightCount'];
    final gameStep = GameStep.load(data['gameStep'], players);

    return WerewolfGame(id, players, actionsHistory, time, nightCount: nightCount, gameStep: gameStep);
  }
}
