import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'game_screen.dart';

class SetupGameScreen extends StatefulWidget {
  const SetupGameScreen({super.key});

  @override
  State<SetupGameScreen> createState() => _SetupGameScreenState();
}

class _SetupGameScreenState extends State<SetupGameScreen> {
  bool _switchValue = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(12)),
          Center(
            child: Text(
              'Configuration de la partie',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(12)),
          Padding(
            padding: EdgeInsets.only(left: 12, right: 12),
            child: Row(
              children: [
                Text('Activer le mode nuit'),
                Spacer(),
                Switch(
                    value: _switchValue,
                    onChanged: (value) {
                      setState(() {
                        _switchValue = value;
                      });
                    }),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(12), child: TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Color(0xFF56B6B2)),
              foregroundColor: WidgetStateProperty.all(Colors.white),
            ),
              child: Row(
                children: [
                  Spacer(),
                  Icon(Icons.play_arrow, color: Color(0xFF3E801F),),
                  Text('Démarrer la partie'),
                  Spacer(),
                ],
              ),
              onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => GameScreen()));
          })
          ),
        ],
      ),
    );
  }
}
