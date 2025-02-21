import 'dart:async';

import 'package:flutter/material.dart';
import 'package:werewolves_of_thiercelieux/objects/game_configuration.dart';
import 'package:werewolves_of_thiercelieux/objects/game_state.dart';
import 'package:werewolves_of_thiercelieux/objects/translator.dart';
import 'package:werewolves_of_thiercelieux/objects/ui_utils.dart';
import 'package:werewolves_of_thiercelieux/objects/utils.dart';

class GameScreen extends StatefulWidget {
  const GameScreen.fromGameState(this.werewolfGame, {super.key});

  GameScreen.fromProfile(GameProfileConfiguration profile, {super.key})
      : werewolfGame = WerewolfGame.fromProfile(profile);

  final WerewolfGame werewolfGame;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Timer? timer;
  int currentTime = 0;

  @override
  void initState() {
    currentTime = widget.werewolfGame.time;

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        currentTime++;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  Column constructScreen(
      String title, String image, String description, List<Widget> children) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.all(12)),
        Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(padding: EdgeInsets.all(12)),
        Padding(
            padding: EdgeInsets.all(12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                image,
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
            )
        ),
        Padding(padding: EdgeInsets.all(12)),
        Padding(
          padding: EdgeInsets.only(left: 24, right: 24),
          child: Center(
            child: Text(
              description,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.all(12)),
        ...children,
      ],
    );
  }

  List<Widget> getWidgetsForRole(GameCard card) {
    return [];
  }

  Column getCurrentScreen() {
    switch (widget.werewolfGame.gameStep.getCurrentState()) {
      case GameState.villageFallsAsleep:
        return constructScreen(Translator().translate('state.villageFallsAsleep.title'), UIUtils.sunsetImage,
            Translator().translate('state.villageFallsAsleep.description'), []);
      case GameState.night:
        GameCard card = widget.werewolfGame.getCardForStep();
        return constructScreen(card.name, card.image, card.description, getWidgetsForRole(card));
      case GameState.villageWakesUp:
        return constructScreen(Translator().translate('state.villageWakesUp.title'), UIUtils.sunriseImage,
            Translator().translate('state.villageWakesUp.description'), []);
      case GameState.villageMeeting:
        return constructScreen(Translator().translate('state.villageMeeting.title'), UIUtils.meetingImage,
            Translator().translate('state.villageMeeting.description'), []);
      case GameState.villageVote:
        return constructScreen(Translator().translate('state.villageVote.title'), UIUtils.sunriseImage,
            Translator().translate('state.villageVote.description'), []
        );
      case GameState.villageVoteResult:
        return constructScreen(Translator().translate('state.villageVoteResult.title'), UIUtils.sunriseImage,
            Translator().translate('state.villageVoteResult.description'), []);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(Utils.getFormmatedTime(currentTime)),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blue.shade100,
            actions: [
              PopupMenuButton(itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text('Quitter la partie'),
                    value: 'quit',
                  ),
                ];
              }, onSelected: (value) {
                if (value == 'quit') {
                  UIUtils.createConfirmationDialog(
                      context, 'Voulez-vous vraiment quitter la partie ?', () {
                    Navigator.of(context).pop();
                  });
                }
              })
            ]),
        body: getCurrentScreen(),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(left: 30),
          child: Row(
            children: [
              FloatingActionButton(
                heroTag: 'back',
                backgroundColor: Colors.blue.shade100,
                onPressed: () {},
                child: Icon(Icons.arrow_back),
              ),
              Spacer(),
              FloatingActionButton(
                heroTag: 'forward',
                backgroundColor: Colors.blue.shade100,
                onPressed: () {
                  widget.werewolfGame.nextStep();
                },
                child: Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ));
  }
}
