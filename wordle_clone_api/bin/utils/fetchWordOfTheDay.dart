import 'dart:convert';
import 'dart:math';

import 'package:firebase_dart/core.dart';
import 'package:firebase_dart/standalone_database.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../configurations.dart';
import 'fetchWords.dart';

class FetchWordOfTheDay {

  Future initFirebase() async{
    late FirebaseApp app;
    try{
      app = Firebase.apps[0];
    } catch(e) {
      app = await Firebase.initializeApp(
        options: FirebaseOptions.fromMap(Config.firebaseConfig),
      );
    }

    return app;
  }

  Future addWordOfTheDay(DatabaseReference dbRef) async{
    var words = FetchWords.getWords();
    words.removeWhere((element) =>  element.trim().length!=5);

    var word = words[Random().nextInt(words.length)];
    words.shuffle();
    var randomWords = words.take(29).toList();
    randomWords.add(word);

    var characters = word.split('');

    var randomWordOfTheDay = {
      'word': word,
      'words': randomWords,
      'characters': characters,
      'date': '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}'
    };

    await dbRef.child('wordOfTheDay').set(randomWordOfTheDay);

    return randomWordOfTheDay;
  }

  Handler get handler {
    var router = Router();

    router.get('/wotd', (request) async {
        var app = await initFirebase();
        var fdb = FirebaseDatabase(app: app, databaseURL: Config.databaseUrl);
        var dbRef = fdb.reference();
        var data = await dbRef.child('wordOfTheDay').once();

        var date = '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';

        var value = data.value;

        if(value == null) {
          value = await addWordOfTheDay(dbRef);
        } else if(date != data.value['date']) {
          value = await addWordOfTheDay(dbRef);
        }

        return Response.ok(
          jsonEncode(value),
          headers: {'content-type': 'application/json'}
        );
    });

    return router;
  }
}