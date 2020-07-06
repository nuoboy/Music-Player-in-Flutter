import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_audio_query/flutter_audio_query.dart';

void main() {
//  var url =
//      'http://api.musixmatch.com/ws/1.1/track.search?apikey=2f65a8d6c583f9dba628add8ac137a12&q_artist=justin bieber&page_size=3&page=1&s_track_rating=desc';
//  var response = await http.get(url);
//  if (response.statusCode == 200) {
//    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
//    print(jsonResponse['message']['body']);
//    //Body body= new Body.fromJson(jsonResponse['message']);
//  } else {
//    print('Request failed with status: ${response.statusCode}.');
//  }
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Player()));
}

String path = "";
String lyrics = "";
var dropdownvalue = "1";
final FlutterAudioQuery audioQuery = FlutterAudioQuery();
List songs = [];
//the following list is for just for preview purpose because My phone didn't have good music files.
List preview=['History','Night Changes','See You Again','Tum Jab Pass','Water Melon Sugar','Dawn To Dusk','Perfect','Udd Gaye','What Makes You Beautiful','Song10','Song11','Song12'];

void music() async {
  List<SongInfo> amal = await audioQuery.getSongs();
  songs = amal;
  print("music");
  //print(songs[1]._display_name());
}

void option(var dropval, context) {
  print("amal");
  if (dropval == "1") {
    fileopen();
    lyrics = "";
  }
}

void fileopen() async {
  print('kkkk');
  String audio = await FilePicker.getFilePath();
  path = audio;
  print(path);
}

File image(String imagepath) {
  try {
    return File(imagepath);
  } catch (error) {
    return File('images/album.png');
  }
}

AudioPlayer audioPlayer = AudioPlayer();
playLocal() async {
  int result = await audioPlayer.play("$path", isLocal: true);
}

pauseLocal() async {
  int result = await audioPlayer.pause();
}

stopLocal() async {
  int result = await audioPlayer.stop();
}

class Player extends StatefulWidget {
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  void initState() {
    super.initState();
    music();
  }

  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20.0,
                    ),
                    Container(
                        child: Center(
                          child: Text(
                            "    Drop The Tune",
                            style: GoogleFonts.pacifico(
                                textStyle: TextStyle(
                                    fontSize: 35.0, color: Colors.black)),
                          ),
                        ),
                        width: 310.0),
                    PopupMenuButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.black,
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: '1',
                          child: Text("Upload Lyrics"),
                        ),
                        PopupMenuItem(
                          value: '2',
                          child: Text("Search Lyrics"),
                        ),
                      ],
                      onSelected: (value) {
                        if (value == "1") {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return MaterialApp(
                                    debugShowCheckedModeBanner: false,
                                    home: Displaybox(
                                      onSubmit: () {
                                        Navigator.pop(context);
                                        setState(() {});
                                      },
                                    ));
                              });
                        }
                        option(value, context);
                        setState(() {
                          dropdownvalue = value;
                        });
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  //decoration: BoxDecoration(border: Border.all()),
                  width: double.infinity,
                  height: 600.0,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                          itemCount: songs.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                  trailing: Container(
                                      width: 50.0,
                                      height: 50.0,
                                      child:Image.asset('images/album.jpg')), //Image.file(image(songs[index].albumArtwork))),
                                  onTap: () {
                                    path = songs[index].filePath;
                                    playLocal();
                                    setState(() {});
                                  },
                                  title: Text(
                                    //preview[index],
                                    songs[index].title,
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle()),
                                  )),
                            );
                          },
                        ),
                      )

//                      Expanded(
//                        child: SingleChildScrollView(
//                          child: Text(
//                            lyrics,
//                            style: GoogleFonts.pacifico(
//                                textStyle: TextStyle(
//                                    fontSize: 20.0, color: Colors.black)),
//                          ),
//                        ),
//                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(width: 30.0),
                      RawMaterialButton(
                        child: Icon(
                          Icons.stop,
                          size: 35.0,
                          color: Colors.black,
                        ),
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(10.0),
                        elevation: 3.0,
                        fillColor: Colors.pinkAccent,
                        onPressed: () {
                          stopLocal();
                        },
                      ),
                      RawMaterialButton(
                        child: Icon(
                          Icons.play_arrow,
                          size: 35.0,
                          color: Colors.black,
                        ),
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20.0),
                        elevation: 3.0,
                        fillColor: Colors.pinkAccent,
                        onPressed: () {
                          playLocal();
                        },
                      ),
                      RawMaterialButton(
                        child: Icon(
                          Icons.pause,
                          size: 35.0,
                          color: Colors.black,
                        ),
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(10.0),
                        elevation: 3.0,
                        fillColor: Colors.pinkAccent,
                        onPressed: () {
                          pauseLocal();
                        },
                      ),
                      SizedBox(
                        width: 30.0,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 5.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
