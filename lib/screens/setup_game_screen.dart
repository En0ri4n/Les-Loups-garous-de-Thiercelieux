import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:werewolves_of_thiercelieux/objects/database.dart';
import 'package:werewolves_of_thiercelieux/objects/game_configuration.dart';

import 'game_screen.dart';

class SetupGameScreen extends StatefulWidget {
  const SetupGameScreen({super.key});

  @override
  State<SetupGameScreen> createState() => _SetupGameScreenState();
}

class _SetupGameScreenState extends State<SetupGameScreen> {
  bool _switchValue = false;
  GameProfileConfiguration? _profile;
  bool _canStart = false;

  late List<DropdownMenuEntry<GameProfileConfiguration>> _profileEntries = [];

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

    _canStart = false;

    GameDatabase().loadProfiles().then((profiles) {
      setState(() {
        _profileEntries = profiles.map((profile) => DropdownMenuEntry(value: profile, label: profile.name)).toList();
      });
    });
  }

  void checkCanStart() {
    _canStart = _profile != null;
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
          Text('Profile'),
          Padding(
              padding: EdgeInsets.all(12),
              child: DropdownMenu(
                expandedInsets: EdgeInsets.all(12),
                dropdownMenuEntries: _profileEntries,
                onSelected: (value) {
                  setState(() {
                    if (value != null) {
                      _profile = value;
                      checkCanStart();
                    }
                  });
                },
              )
          ),
          Padding(
              padding: EdgeInsets.all(12),
              child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: _canStart
                        ? WidgetStateProperty.all(Color(0xFF56B6B2))
                        : WidgetStateProperty.all(Colors.grey),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                  ),
                  onPressed: !_canStart ? null : () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => GameScreen.fromProfile(_profile!)));
                  },
                  child: Row(
                    children: [
                      Spacer(),
                      Icon(
                        Icons.play_arrow,
                        color: Color(0xFF3E801F),
                      ),
                      Text('Démarrer la partie'),
                      Spacer(),
                    ],
                  ))
          ),
        ],
      ),
    );
  }
}
