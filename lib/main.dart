// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
//    final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Name Generator',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Name Generator'),
        ),
        body: const Center(
          child: RandomWords()
        ),
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text("About: ", textScaleFactor: 1.5, textAlign: TextAlign.center,),
              const Text("Learned from Codelabs by google and Book Flutter for Dummies by Barry Burd", textScaleFactor: 1.5,),
              const Text("\n", textScaleFactor: 0.2,),
              Image.asset('assets/img.png'),
              const Text("\n", textScaleFactor: 0.2,),
              Image.asset('assets/img_1.png'),
              const Text("This app geneates random two word names that you can add to favorites, work is still going on for permanently saving\n Thanks: Adit", textScaleFactor: 1.1,)
        ]
        ),
        ),
      ),
    );
  }
}


class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};     // NEW
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
    Widget build(BuildContext context) {
//      final wordPair = WordPair.random();
      return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return const Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }

          final alreadySaved = _saved.contains(_suggestions[index]); // NEW
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }


          return ListTile(
            title: Text(
              _suggestions[index].asPascalCase,
              style: _biggerFont,
            ),
            trailing: Icon(
              alreadySaved ? Icons.favorite : Icons.favorite_border,
              color: alreadySaved ? Colors.red : null,
              semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
            ),
            onTap: () {          // NEW from here ...
              setState(() {
                if (alreadySaved) {
                  _saved.remove(_suggestions[index]);
                } else {
                  _saved.add(_suggestions[index]);
                }
              });                // to here.
            },
          );
          // to here.

        },
      );
    }

  }
