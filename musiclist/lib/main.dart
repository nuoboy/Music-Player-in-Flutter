import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

void main() {
  runApp(MyApp());
}

final FlutterAudioQuery audioQuery = FlutterAudioQuery();


void music() async {
  List<SongInfo> amal = await audioQuery.getSongs();
  songs = amal;
  //print(songs[1]._display_name());

}

List songs = [];

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            child: Column(
              children: <Widget>[
                FlatButton(
                  child: Text("Amal"),
                  onPressed:(){
                    music();
                    setState(() {

                    });

                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: songs.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(title:Text(songs[index].displayName)),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
