import 'package:flutter/material.dart';
import 'package:werewolves_of_thiercelieux/objects/game_configuration.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  List<String> players = <String>[];
  List<GameCard> gameCards = <GameCard>[];
  late TextEditingController playerNameController = TextEditingController();
  late TextEditingController gameCardNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuEntry<GameCard>> gameCardsDropdownMenuEntries = <DropdownMenuEntry<GameCard>>[];
    for (GameCard gameCard in GameCards.allCards) {
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
              players.add(playerNameController.text);
              playerNameController.clear();
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
                    children: <Widget>[
                      Image.asset(gameCards[index].image, width: 50, height: 50),
                      Spacer(flex: 2,),
                      Text(gameCards[index].name),
                      Spacer(flex: 1,),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0, backgroundColor: Colors.transparent, shape: LinearBorder()),
                          onPressed: () {
                            setState(() {
                              gameCards.removeAt(index);
                            });
                          },
                          child: const Text('Remove'))
                    ],
                  ),
                ),
              );
            }),
        DropdownMenu(
          dropdownMenuEntries: gameCardsDropdownMenuEntries,
          controller: gameCardNameController,
          onSelected: (value) => setState(() {
              if (value != null)
              {
                gameCards.add(value);
                gameCardNameController.clear();
              }
            }),
        ),
      ],
    ));
  }
}
