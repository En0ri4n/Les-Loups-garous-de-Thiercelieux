import 'package:flutter/material.dart';
import 'package:werewolves_of_thiercelieux/objects/game_state.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key}) : gameState = null;

  const GameScreen.fromGameState(this.gameState, {super.key});

  final GameState? gameState;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(12)),
          Center(
            child: Text(
              'Game Screen',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
