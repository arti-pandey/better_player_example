import 'package:better_player_example/countdown_page.dart';
import 'package:better_player_example/countdown_timer_page.dart';
import 'package:flutter/material.dart';

class CoustomTimer extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CoustomTimer> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildItem("countdown", CountdownPage()),
        ],
      ),
    );
  }

  Widget buildItem(String title, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return page;
        }));
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        color: Colors.blue,
        width: double.infinity,
        alignment: Alignment.center,
        height: 100,
        child: Text(title, style: TextStyle(fontSize: 36),),
      ),
    );
  }
}