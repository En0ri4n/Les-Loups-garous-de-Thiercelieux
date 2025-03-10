import 'package:werewolves_of_thiercelieux/objects/game_state.dart';
import 'package:werewolves_of_thiercelieux/objects/utils.dart';

enum GameVersion {
  classic('Classique', 'assets/textures/cards/icons/classique.png'),
  nouvelleLuneExtension('Nouvelle Lune', 'assets/textures/cards/icons/nouvelleLune.png'),
  leVillageExtension('Le Village', 'assets/textures/cards/icons/leVillage.png'),
  personnagesExtension('Les Personnages', 'assets/textures/cards/icons/lesPersonnages.png');

  final String name;
  final String icon;
  const GameVersion(this.name, this.icon);
}

enum RoleTeam { villager, werewolf, variable, independant }

enum PlayTiming { day, night, onDeath, never }

class GameCard {
  final int playOrder;
  final PlayTiming timing;
  final GameVersion version;
  final String roleId;
  final String name;
  final String description;
  final RoleTeam team;
  final int requiredCount;
  String get image => 'assets/textures/cards/$roleId.png';
  get icon => 'assets/textures/cards/$roleId.png';

  GameCard({this.timing = PlayTiming.night, required this.version, this.requiredCount = 1, required this.roleId, required this.team, this.name = '', this.description = ''})
      : playOrder = GameCards.cardIndex[roleId] ?? -1,
        assert(requiredCount > 0, 'requiredCount must be greater than 0');

}

class GameCards {
  static int cardsCount = 0;
  static final Map<String, int> cardIndex = {
    'cupidon': cardsCount++,
    'deuxSoeurs': cardsCount++,
    'troisFreres': cardsCount++,
    'joueurDeFlute': cardsCount++,
    'gitane': cardsCount++,
    'enfantSauvage': cardsCount++,
    'renard': cardsCount++,
    'voyante': cardsCount++,
    'montreurDOurs': cardsCount++,
    'comedien': cardsCount++,
    'voleur': cardsCount++,
    'chienLoup': cardsCount++,
    'petiteFille': cardsCount++,
    'ancien': cardsCount++,
    'boucEmissaire': cardsCount++,
    'salvateur': cardsCount++,
    'servanteDevouee': cardsCount++,
    'sorciere': cardsCount++,
    'chevalierALEpeeRouillee': cardsCount++,
    'loupGarou': cardsCount++,
    'grandMechantLoup': cardsCount++,
    'infectPereDesLoups': cardsCount++,
    'loupBlanc': cardsCount++,
    'idiotDuVillage': cardsCount++,
    'villageois': cardsCount++,
    'chasseur': cardsCount++,
    'corbeau': cardsCount++,
    'pyromane': cardsCount++,
    'jugeBegue': cardsCount++,
    'abominableSectaire': cardsCount++,
    'ange': cardsCount++,
  };

  // Classic cards
  static final GameCard loupGarouCard = GameCard(version: GameVersion.classic, roleId: 'loupGarou', team: RoleTeam.werewolf, name: 'Loup-Garou', description: 'Les Loups-Garous sont des créatures de la nuit qui se réveillent pour dévorer un villageois chaque nuit.');
  static final GameCard voyanteCard = GameCard(version: GameVersion.classic, roleId: 'voyante', team: RoleTeam.villager, name: 'Voyante', description: 'La Voyante peut espionner un joueur chaque nuit pour connaître sa véritable identité.');
  static final GameCard sorciereCard = GameCard(version: GameVersion.classic, roleId: 'sorciere', team: RoleTeam.villager, name: 'Sorcière', description: 'La Sorcière peut sauver un joueur condamné à mort et tuer un autre joueur chaque nuit.');
  static final GameCard chasseurCard = GameCard(version: GameVersion.classic, timing: PlayTiming.onDeath, roleId: 'chasseur', team: RoleTeam.villager, name: 'Chasseur', description: 'Le Chasseur peut tuer un joueur de son choix lorsqu\'il est éliminé.');
  static final GameCard cupidonCard = GameCard(version: GameVersion.classic, roleId: 'cupidon', team: RoleTeam.villager, name: 'Cupidon', description: 'Cupidon peut unir deux joueurs en amour, si l\'un meurt, l\'autre meurt de chagrin.');
  static final GameCard voleurCard = GameCard(version: GameVersion.classic, roleId: 'voleur', team: RoleTeam.villager, name: 'Voleur', description: 'Le Voleur peut échanger sa carte contre celle d\'un autre joueur.');
  static final GameCard villageoisCard = GameCard(version: GameVersion.classic, timing: PlayTiming.never, roleId: 'villageois', team: RoleTeam.villager, name: 'Villageois', description: 'Le Villageois n\'a pas de pouvoir particulier, mais il peut voter pour éliminer un joueur chaque jour.');
  static final GameCard petiteFilleCard = GameCard(version: GameVersion.classic, timing: PlayTiming.never, roleId: 'petiteFille', team: RoleTeam.villager, name: 'Petite Fille', description: 'La Petite Fille peut espionner les loups-garous pendant la nuit. Cependant, elle doit rester discrète, car si elle est découverte, elle risque d\'être éliminée.');

  // Nouvelle Lune extension cards
  static final GameCard ancienCard = GameCard(version: GameVersion.nouvelleLuneExtension, roleId: 'ancien', team: RoleTeam.villager, name: 'Ancien', description: 'L\'Ancien est un villageois qui a vécu de nombreuses parties. Il est très difficile à éliminer, car il résiste à la première attaque des Loups-Garous.');
  static final GameCard boucEmissaireCard = GameCard(version: GameVersion.nouvelleLuneExtension, timing: PlayTiming.never, roleId: 'boucEmissaire', team: RoleTeam.villager, name: 'Bouc Émissaire', description: 'Si le vote du village amène une égalité, c\'est le Bouc émissaire qui est éliminé à la place des ex æquo. À lui de bien manœuvrer pour éviter cette triste conclusion.');
  static final GameCard idiotDuVillageCard = GameCard(version: GameVersion.nouvelleLuneExtension, timing: PlayTiming.onDeath, roleId: 'idiotDuVillage', team: RoleTeam.villager, name: 'Idiot du Village', description: 'S\'il est désigné par le vote du village, il ne meurt pas, et ce une seule fois dans la partie, mais perd seulement sa capacité à voter (Il peut participer aux débats).');
  static final GameCard joueurDeFluteCard = GameCard(version: GameVersion.nouvelleLuneExtension, roleId: 'joueurDeFlute', team: RoleTeam.independant, name: 'Joueur de Flûte', description: 'Le joueur de flûte se réveille en dernier. Il peut alors charmer un ou deux joueurs (en fonction du nombre de joueurs) qui deviendront les charmés. Il gagne lorsque tous les joueurs en vie sont charmés.');
  static final GameCard salvateurCard = GameCard(version: GameVersion.nouvelleLuneExtension, roleId: 'salvateur', team: RoleTeam.villager, name: 'Salvateur', description: 'Chaque nuit, le salvateur protège une personne. Cette personne sera protégée et ne pourra donc pas mourir durant la nuit. Le salvateur ne peut pas protéger la même personne deux nuits de suite.');

  // Le Village extension cards
  static final GameCard corbeauCard = GameCard(version: GameVersion.leVillageExtension, roleId: 'corbeau', team: RoleTeam.villager, name: 'Corbeau', description: 'Le corbeau fait partie du village, il sera appelé chaque nuit par le Meneur de jeu et désignera une personne qui recevra automatiquement deux votes de plus contre elle lors du vote de la journée suivante.');
  static final GameCard loupBlancCard = GameCard(version: GameVersion.leVillageExtension, roleId: 'loupBlanc', team: RoleTeam.werewolf, name: 'Loup Blanc', description: 'Le Loup Garou Blanc ou Loup Blanc, est un des rôles du jeu les plus difficiles à jouer, car il gagne seul, en ayant éliminé tout le village et les loups garous. Une nuit sur deux, il peut dévorer un loup garou juste après leur tour. Il se réveille et vote en même temps que les loups.');
  static final GameCard pyromaneCard = GameCard(version: GameVersion.leVillageExtension, roleId: 'pyromane', team: RoleTeam.villager, name: 'Pyromane', description: 'il peut chaque nuit, soit « mettre de l’huile » sur un joueur, soit « allumer l’huile » et tuer toute les joueurs en ayant eu dessus. Il a alors le même principe de base que le joueur de flûte, car tous ceux ayant de l\'huile sur eux le savent; et se reconnaissent entre eux chaque nuit.');

  // Personnages extension cards
  static final GameCard abominableSectaireCard = GameCard(version: GameVersion.personnagesExtension, roleId: 'abominableSectaire', team: RoleTeam.independant, name: 'Abominable Sectaire', description: 'L\'Abominable Sectaire est un rôle indépendant. Pour gagner, il doit réussir à éliminer tous les joueurs du groupe opposé à lui, tout en restant en vie. C\'est le meneur de jeu qui décide quels sont les deux groupes opposés dans le village, par exemple les joueurs avec et sans lunettes (barbus et imperbes, blonds et bruns etc ...).');
  static final GameCard angeCard = GameCard(version: GameVersion.personnagesExtension, roleId: 'ange', team: RoleTeam.independant, name: 'Ange', description: 'L`\'ange est un personnage de l\'Extension "Personnages" dont le but est de se faire tuer le premier jour, au vote du village.[1] Le but de ce rôle est d\'obliger les joueurs à jouer fair play, car dans beaucoup de parties le premier tour est constellé de morts des plus mauvais joueurs ou des nouveaux joueurs... Le village doit faire attention et utilise son pouvoir de vote avec parcimonie.');
  static final GameCard chevalierALEpeeRouilleeCard = GameCard(version: GameVersion.personnagesExtension, roleId: 'chevalierALEpeeRouillee', team: RoleTeam.villager, name: 'Chevalier à l\'Épée Rouillée', description: 'Le chevalier à l\'épée rouillée donne le tétanos au premier loup-garou à sa gauche (qui était présent lors du vote des loups) s\'il est mangé par les loups durant la nuit. Ce loup-garou mourra la nuit d\'après, sans manger, innocentant au passage toutes les personnes entre lui et le chevalier.');
  static final GameCard chienLoupCard = GameCard(version: GameVersion.personnagesExtension, roleId: 'chienLoup', team: RoleTeam.variable, name: 'Chien-Loup', description: 'La première nuit, le chien-loup choisit d’être un Simple Villageois ou un Loup-garou. Il endosse alors ce rôle et doit gagner avec son camp choisi jusqu\'à la fin de la partie. Du fait qu\'il ne change pas de carte, les autres joueurs ne sauront qu\'en fin de partie si le chien-loup qui venait de mourir était Simple Villageois ou Loup-garou.');
  // static final GameCard comedienCard = GameCard(version: GameVersion.personnagesExtension, roleId: 'comedien', team: RoleTeam.villager, name: 'Comédien', description: 'Avant la partie, le meneur choisit trois cartes personnage non-loup ayant des capacités spéciales. Après la distribution des rôles, ces cartes sont placées face visible au centre de la table. Chaque nuit, à l’appel du meneur, le comédien peut désigner une des cartes et utiliser le pouvoir correspondant jusqu’à la nuit suivante. Quand le Comédien choisit une carte, le meneur l’ôte de la table, elle ne pourra plus être utilisée.');
  static final GameCard deuxSoeursCard = GameCard(version: GameVersion.personnagesExtension, requiredCount: 2, roleId: 'deuxSoeurs', team: RoleTeam.villager, name: 'Deux Soeurs', description: 'Au début de la partie, le meneur appelle les deux sœurs à se réveiller. Elles connaissent donc leur identité, et peuvent donc avoir confiance en eux. Elles peuvent sous l’autorisation du meneur se concerter en silence (bien sur).');
  static final GameCard enfantSauvageCard = GameCard(version: GameVersion.personnagesExtension, roleId: 'enfantSauvage', team: RoleTeam.variable, name: 'Enfant Sauvage', description: 'Au début de la partie, l\'enfant sauvage choisit un mentor. Ce joueur ignore qu\'il est le mentor de l\'enfant sauvage. Si, au cours de la partie, le mentor vient à mourir, alors l\'enfant sauvage devient un loup-garou.');
  static final GameCard grandMechantLoupCard = GameCard(version: GameVersion.personnagesExtension, roleId: 'grandMechantLoup', team: RoleTeam.werewolf, name: 'Grand Méchant Loup', description: 'Chaque nuit, le grand méchant loup se réunit avec ses compères Loups pour décider d\'une victime à éliminer... Tant qu\'aucun autre loup n\'est mort, il peut, chaque nuit, dévorer une victime supplémentaire. Son objectif est d\'éliminer tous les Villageois (ceux qui ne sont pas Loups-Garous).');
  // static final GameCard gitaneCard = GameCard(version: GameVersion.personnagesExtension, roleId: 'gitane', team: RoleTeam.villager, name: 'Gitane', description: 'Au début du jeu le meneur prend les 5 cartes spiritisme de Nouvelle Lune, les mélange et les garde en main. Chaque nuit, il appelle la Gitane, et lui demande si elle souhaite utiliser son pouvoir. Si oui, le meneur lit à haute voix les quatre questions d\'une carte spiritisme. D\'un geste, la Gitane valide une des questions. Puis, elle désigne au meneur l\'habitant qui devra la poser. Le matin, le joueur désigné devient le Spirite, et pose cette question à voix haute. Le premier joueur éliminé répond par « OUIII » ou par « NOOON », d\'une voix sépulcrale, sans mentir. La carte est ensuite défaussée.');
  static final GameCard infectPereDesLoupsCard = GameCard(version: GameVersion.personnagesExtension, roleId: 'infectPereDesLoups', team: RoleTeam.werewolf, name: 'Infect Père des Loups', description: 'Dans l\'équipe des loups-garous, l\'Infect Père des Loups joue un rôle crucial. En plus de participer aux décisions nocturnes pour éliminer les villageois, il possède un pouvoir particulier : celui de choisir un villageois à infecter. Ce villageois infecté se transformera en loup-garou lors de la prochaine nuit, sans le savoir. Cette capacité peut être utilisée avec subtilité pour manipuler les événements à venir.');
  static final GameCard jugeBegueCard = GameCard(version: GameVersion.personnagesExtension, roleId: 'jugeBegue', team: RoleTeam.villager, name: 'Juge Bègue', description: 'En début de partie, le juge bègue définit un signe avec le meneur de jeu. A tout moment et une fois dans la partie, le juge bègue peut refaire ce signe à l\'intention du meneur. Dans ce cas, un nouveau vote à lieu, immédiatement et sans débat.');
  static final GameCard montreurDOursCard = GameCard(version: GameVersion.personnagesExtension, roleId: 'montreurDOurs', team: RoleTeam.villager, name: 'Montreur d\'Ours', description: 'Chaque matin, si le montreur d\'ours se trouve à droite ou à gauche d\'un loup-garou, l\'ours grogne (le MJ). Si le montreur est infecté par l\'infect père des loups, l\'ours grognera jusqu\'à la fin de la partie.');
  static final GameCard renardCard = GameCard(version: GameVersion.personnagesExtension, roleId: 'renard', team: RoleTeam.variable, name: 'Renard', description: 'La première nuit, le renard flaire 3 personnes. Le Meneur lui dit si un loup garou est dans ce groupe. Si oui, il pourra réutiliser son pouvoir la nuit suivante. Sinon, il perd son flair et devient simple villageois.');
  // static final GameCard servanteDevoueeCard = GameCard(version: GameVersion.personnagesExtension, roleId: 'servanteDevouee', team: RoleTeam.villager, name: 'Servante Dévouée', description: 'Chaque nuit dans la partie la servante dévouée est réveillée à la fin de la nuit , le meneur de jeu lui montre la ou les victime(s) de la nuit elle doit choisir si oui ou non elle décide de se sacrifier à la place de cette personne.');
  static final GameCard troisFreresCard = GameCard(version: GameVersion.personnagesExtension, requiredCount: 3, roleId: 'troisFreres', team: RoleTeam.villager, name: 'Trois Frères', description: 'La première nuit, à l\'appel du meneur, les Trois Frères se réveillent ensemble et se reconnaissent, et peuvent donc avoir confiance entre eux.');
  static final GameCard villageoisVillageoisCard = GameCard(version: GameVersion.personnagesExtension, roleId: 'villageoisVillageois', team: RoleTeam.villager, name: 'Villageois/Villageoise', description: 'Le villageois-villageois est un villageois. Il n’a aucun pouvoir mais sa carte est un simple villageois des 2 cotés. Tous les joueurs connaissent donc son identité. Il possède en revanche un vote journalier, comme tout autre joueur, et fait également partie du camp du village.');

  static final GameCard village = GameCard(version: GameVersion.classic, roleId: 'village', team: RoleTeam.villager, name: 'Village', description: 'Le village est composé de villageois et de loups-garous. Les villageois doivent se débarrasser des loups-garous pour gagner, tandis que les loups-garous doivent se débarrasser des villageois pour gagner.');

  static final List<GameCard> classicCards = <GameCard>[
    loupGarouCard,
    voyanteCard,
    sorciereCard,
    chasseurCard,
    cupidonCard,
    voleurCard,
    villageoisCard,
    petiteFilleCard,
  ];

  static final List<GameCard> nouvelleLuneExtensionCards = <GameCard>[
    ancienCard,
    boucEmissaireCard,
    idiotDuVillageCard,
    joueurDeFluteCard,
    salvateurCard,
  ];

  static final List<GameCard> leVillageExtensionCards = <GameCard>[
    corbeauCard,
    loupBlancCard,
    pyromaneCard,
  ];

  static final List<GameCard> personnagesExtensionCards = <GameCard>[
    abominableSectaireCard,
    angeCard,
    chevalierALEpeeRouilleeCard,
    chienLoupCard,
    // comedienCard,
    deuxSoeursCard,
    enfantSauvageCard,
    grandMechantLoupCard,
    // gitaneCard,
    infectPereDesLoupsCard,
    jugeBegueCard,
    montreurDOursCard,
    renardCard,
    // servanteDevoueeCard,
    troisFreresCard,
    villageoisVillageoisCard,
  ];

  static final List<GameCard> allCards = <GameCard>[
    ...classicCards,
    ...nouvelleLuneExtensionCards,
    ...leVillageExtensionCards,
    ...personnagesExtensionCards,
  ];

  static GameCard getCard(String roleId) {
    return allCards.firstWhere((element) => element.roleId == roleId);
  }
}

class GameCardInstance {
  final GameCard gameCard;
  int count;

  GameCardInstance({required this.gameCard, required this.count});
}

class GameProfileConfiguration {
  final int id;
  final String name;
  final List<GameCardInstance> cards;
  final List<String> players;

  // Constructor with id
  GameProfileConfiguration({required this.id, required this.name, required this.cards, required this.players});

  // Constructor without id, generates a new id
  GameProfileConfiguration.builder({required this.name, required this.cards, required this.players})
      : id = DateTime.now().millisecondsSinceEpoch;
  
  List<Player> generatePlayers() {
    List<GameCardInstance> allCards = [...cards];
    List<Player> players = [];

    for (var playerName in this.players) {
      GameCardInstance gameCardInstance = Utils.getRandom(allCards);
      players.add(Player(playerName, gameCardInstance.gameCard, true));

      if (gameCardInstance.count > 1) {
        gameCardInstance.count--;
      } else {
        allCards.remove(gameCardInstance);
      }
    }

    // Order players by play order
    players.sort((a, b) => a.role.playOrder.compareTo(b.role.playOrder));

    return players;
  }

  Map<String, dynamic> serialize() {
    return {
      'id': id,
      'name': name,
      'cards': cards.map((e) => {'gameCardId': e.gameCard.roleId, 'count': e.count}).toList(),
      'players': players,
    };
  }

  static GameProfileConfiguration deserialize(Map<String, dynamic> serializedData) {
    return GameProfileConfiguration(
      id: serializedData['id'],
      name: serializedData['name'],
      cards: (serializedData['cards'] as List).map((e) => GameCardInstance(gameCard: GameCards.getCard(e['gameCardId']), count: e['count'])).toList(),
      players: (serializedData['players'] as List).map((e) => e.toString()).toList(),
    );
  }
}
