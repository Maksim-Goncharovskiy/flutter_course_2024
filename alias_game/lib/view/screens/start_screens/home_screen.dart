import 'package:flutter/material.dart';

import 'package:alias_game/screens/start_screens/game_settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ALIAS"),
      ),
      body: Container(
        child: Center(
          child: SizedBox(
            width: 250,
            height: 150,
            child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => GameSettingsScreen()));
            }, 
            child: const Text("Играть", style: TextStyle(fontSize: 45),)),
          )
        ),
      ),
    );
  }
}
