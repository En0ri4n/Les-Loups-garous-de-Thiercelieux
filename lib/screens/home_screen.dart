import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:werewolves_of_thiercelieux/objects/database.dart';
import 'package:werewolves_of_thiercelieux/objects/game_configuration.dart';
import 'package:werewolves_of_thiercelieux/screens/create_profile_screen.dart';
import 'package:werewolves_of_thiercelieux/screens/setup_game_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPageIndex = 0;

  // Profile list
  late final List<GameProfileConfiguration> profiles = <GameProfileConfiguration>[];

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

    updateProfiles();
  }

  void updateProfiles() {
    GameDatabase().loadProfiles().then((profiles) {
      setState(() {
        this.profiles.clear();
        this.profiles.addAll(profiles);
        log("Loaded ${profiles.length} profiles");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              _selectedPageIndex = index;
            });
          },
          selectedIndex: _selectedPageIndex,
          indicatorColor: Colors.blue,
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), selectedIcon: Icon(Icons.home_outlined), label: 'Accueil'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profiles'),
            NavigationDestination(icon: Icon(Icons.settings), label: 'Paramètres'),
          ]),
      body: <Widget>[
        // Home page
        Scaffold(
          appBar: AppBar(
            title: Text('Home'),
          ),
          body: Column(
            children: <Widget>[
              const Text('Home', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SetupGameScreen()));
                },
                child: const Text('Start'),
              ),
            ],
          )
        ),

        // Profiles page
        Scaffold(
          appBar: AppBar(
            title: Text('Profiles'),
          ),
          body: ListView.separated(
            scrollDirection: Axis.vertical,
            separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.transparent, height: 10.0,),
              padding: const EdgeInsets.all(10),
              itemCount: profiles.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTileTheme(
                  tileColor: Color(0xFF71B3B3),
                  minVerticalPadding: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(profiles[index].name),
                    trailing: Text('${profiles[index].players.length} joueurs'),

                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (BuildContext context) => CreateProfileScreen.from(profiles[index].id)))
                          .then((value) { updateProfiles(); });
                    },
                  ),
                );
              },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) => CreateProfileScreen()))
                  .then((value) { updateProfiles(); });
            },
            child: const Icon(Icons.add),
          ),
        ),

        // Settings page
        Scaffold(
          appBar: AppBar(
            title: Text('Settings'),
          ),
          body: const Text('Settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
      ][_selectedPageIndex],
    );
  }
}
