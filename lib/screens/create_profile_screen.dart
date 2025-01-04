import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:werewolves_of_thiercelieux/objects/game_configuration.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  List<String> players = <String>[];
  List<GameCardConfiguration> gameCards = <GameCardConfiguration>[];
  late TextEditingController playerNameController = TextEditingController();
  late TextEditingController gameCardNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuEntry<GameCard>> gameCardsDropdownMenuEntries = <DropdownMenuEntry<GameCard>>[];

    List<GameCard> possibleGameCards = <GameCard>[];
    possibleGameCards.addAll(GameCards.allCards);
    for (GameCard element in gameCards.map((e) => e.gameCard)) {
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
    return Scaffold(
        body: ListView(
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      children: <Widget>[
        const Center(
          child: Text('Create Profile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Profile Name',
          ),
        ),
        const SizedBox(height: 10),
        const Center(
          child: Text('Players', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: players.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: index.isOdd ? Colors.white : Colors.black12,
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  children: <Widget>[
                    Text(players[index]),
                    Spacer(),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0, backgroundColor: Colors.transparent, shape: LinearBorder()),
                        onPressed: () {
                          setState(() {
                            players.removeAt(index);
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
          controller: playerNameController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Name',
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              if (playerNameController.text.isNotEmpty) {
                players.add(playerNameController.text);
                playerNameController.clear();
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
            itemCount: gameCards.length,
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
                            Image.asset(gameCards[index].gameCard.image, width: 50, height: 50),
                            Spacer(),
                            Text(gameCards[index].gameCard.name),
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
                                controller: TextEditingController(text: gameCards[index].count.toString()),
                                onSubmitted: (value) {
                                  setState(() {
                                    try {
                                      gameCards[index].count = int.parse(value);
                                    } catch (e) {
                                      gameCards[index].count = 1;
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
                                  gameCards.removeAt(index);
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
            if (value != null) {
              gameCards.add(GameCardConfiguration(gameCard: value, count: value.requiredCount));
              gameCardNameController.clear();
            }
          }),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    ));
  }
}
