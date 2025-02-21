import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:werewolves_of_thiercelieux/objects/database.dart';
import 'package:werewolves_of_thiercelieux/objects/game_configuration.dart';
import 'package:werewolves_of_thiercelieux/objects/ui_utils.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key}) : _profileId = -1;

  const CreateProfileScreen.from(int profileId, {super.key}) : _profileId = profileId;

  final int _profileId;

  @override
  State<StatefulWidget> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  List<String> _players = <String>[];
  List<GameCardInstance> _gameCards = <GameCardInstance>[];

  late TextEditingController _profileNameController;
  late TextEditingController _playerNameController;
  late TextEditingController gameCardNameController;

  late List<DropdownMenuEntry<GameCard>> gameCardsDropdownMenuEntries = <DropdownMenuEntry<GameCard>>[];

  @override
  void initState() {
    super.initState();

    log(widget._profileId == -1 ? "Loading new profile" : "Loading profile with id: ${widget._profileId}");

    _profileNameController = TextEditingController();
    _playerNameController = TextEditingController();
    gameCardNameController = TextEditingController();

    loadProfile();
    createGameCardsDropdownMenuEntries();
  }

  void createGameCardsDropdownMenuEntries() {
    gameCardsDropdownMenuEntries.clear();

    List<GameCard> possibleGameCards = <GameCard>[];
    possibleGameCards.addAll(GameCards.allCards);
    for (GameCard element in _gameCards.map((e) => e.gameCard)) {
      possibleGameCards.remove(element);
    }

    for (GameCard gameCard in possibleGameCards) {
      gameCardsDropdownMenuEntries.add(DropdownMenuEntry(
        value: gameCard,
        label: gameCard.name,
        labelWidget: Text(gameCard.name),
        trailingIcon: Image.asset(gameCard.version.icon, width: 50, height: 50),
        leadingIcon: Image.asset(gameCard.image, width: 50, height: 50),
      ));
    }
  }

  void loadProfile() {
    if(widget._profileId == -1) {
      return;
    }

    GameDatabase().loadProfile(widget._profileId).then((profile) {
      if (profile == null) {
        return;
      }

      setState(() {
        _profileNameController.text = profile.name;
        _players = profile.players;
        _gameCards = profile.cards;
      });
    });
  }

  void saveProfile() {
    log("Saving profile with id: ${widget._profileId}");
    if(_profileNameController.text.isEmpty) {
      UIUtils.createErrorDialog(context, "Le nom du profile ne peut pas être vide");
      return;
    }

    if(_players.isEmpty) {
      UIUtils.createErrorDialog(context, "Il doit y avoir au moins un joueur");
      return;
    }

    if(_gameCards.isEmpty) {
      UIUtils.createErrorDialog(context, "Il doit y avoir au moins une carte");
      return;
    }

    if(_players.length != _gameCards.fold(0, (previousValue, element) => previousValue + element.count)) {
      UIUtils.createErrorDialog(context, "Le nombre de joueurs doit correspondre au nombre de cartes");
      return;
    }

    if (widget._profileId != -1) {
      GameDatabase().updateProfile(GameProfileConfiguration(
        id: widget._profileId,
        name: _profileNameController.text,
        players: _players,
        cards: _gameCards,
      )).then((v) { if(context.mounted) Navigator.of(context).pop(); });
    }
    else {
      GameDatabase().saveProfile(GameProfileConfiguration.builder(
        name: _profileNameController.text,
        players: _players,
        cards: _gameCards,
      )).then((v) { if(context.mounted) Navigator.of(context).pop(); });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      children: <Widget>[
        const Center(
          child: Text('Nom du profile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        TextField(
          controller: _profileNameController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Profile Name',
          ),
        ),
        const SizedBox(height: 10),
        const Center(
          child: Text('Players', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        ListView.separated(
          padding: const EdgeInsets.all(10),
          separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.transparent, height: 10.0),
          shrinkWrap: true,
          itemCount: _players.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                color: index.isOdd ? Color(0xFF98C8E4) : Color(0xFF71B3B3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(10.0), child: Text(_players[index])),
                    Spacer(),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0, backgroundColor: Colors.transparent, shape: LinearBorder()),
                        onPressed: () {
                          setState(() {
                            _players.removeAt(index);
                          });
                        },
                        child: const Text('Remove'))
                  ],
                ),
              ),
            );
          },
        ),
        TextField(
          controller: _playerNameController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Name',
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              if (_playerNameController.text.isNotEmpty) {
                _players.add(_playerNameController.text);
                _playerNameController.clear();
              }
            });
          },
          child: const Text('Add player'),
        ),
        const SizedBox(height: 10),
        const Center(
          child: Text('Game Cards', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: _gameCards.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: index.isOdd ? Colors.white : Colors.black12,
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Image.asset(_gameCards[index].gameCard.image, width: 50, height: 50),
                            Spacer(),
                            Text(_gameCards[index].gameCard.name),
                            SizedBox(width: 10), // Add some spacing between input and button
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Text('x'),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: TextEditingController(text: _gameCards[index].count.toString()),
                                onSubmitted: (value) {
                                  setState(() {
                                    try {
                                      _gameCards[index].count = int.parse(value);
                                    } catch (e) {
                                      _gameCards[index].count = 1;
                                    }
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 10), // Add some spacing between input and button
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0, backgroundColor: Colors.transparent, shape: LinearBorder()),
                              onPressed: () {
                                setState(() {
                                  _gameCards.removeAt(index);
                                });
                              },
                              child: const Text('Remove'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
        DropdownMenu(
          dropdownMenuEntries: gameCardsDropdownMenuEntries,
          controller: gameCardNameController,
          onSelected: (value) => setState(() {
            if (value != null && !_gameCards.any((element) => element.gameCard == value)) {
              _gameCards.add(GameCardInstance(gameCard: value, count: value.requiredCount));
            }
            gameCardNameController.clear();
          }),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFC32323),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
              UIUtils.createConfirmationDialog(context, "Voulez-vous vraiment supprimer le profile?", () {
                if(widget._profileId != -1) {
                  GameDatabase().removeProfile(widget._profileId).then((v) { if(context.mounted) Navigator.of(context).pop(); });
                }
                else {
                  Navigator.of(context).pop();
                }
              });
          },
          child: const Text('Supprimer le profile'),
        ),
      ],
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: saveProfile,
        child: const Icon(Icons.save),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
