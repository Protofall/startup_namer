// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:startup_namer/state/mobxstate.dart';

import 'themes.dart' as myThemes;

// This is the same as below, but its a javascript way of making
// a 1-line function

// void main() => runApp(MyApp());
final MobxState state = MobxState();

void main(){
  runApp(MyApp());
}

// Material is a visual design language that is standard on
// mobile and the web. Flutter offers a rich set of Material widgets.

// In Flutter, pretty much everything is a widget (including padding
// and the app itself)
// Scaffold widget gives us the app bar and body.

// Appbar will create the blue banner at the top
// body is the body and we use the center and text widgets to render
// it in the middle of the screen
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Observer(
        builder: (_) => new MaterialApp(
      title: 'Startup Name Generator',
      theme: state.isDarkValue ? myThemes.themeLight : myThemes.themeDark,
      darkTheme: myThemes.themeDark,
      home: RandomWords(),
      debugShowCheckedModeBanner: false,
    ));
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() {
    return _RandomWordsState();
  }
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = TextStyle(fontSize: 18.0);

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(thickness:1); /*2*/

          final index = i ~/ 2; //Divide by 2 and round down
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final tiles = _saved.map(
                (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          Center(child: Text(
            'Light/Dark Mode',
            textAlign: TextAlign.center,
          )),
          Switch(
              value: isSwitched,
              onChanged: (value){
                setState(() {
                  isSwitched = value;
                  state.toggleDarkMode();
                  print(isSwitched);
                });
              },
              // activeTrackColor: Colors.white,
              activeColor: Colors.white,
          ),
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}
