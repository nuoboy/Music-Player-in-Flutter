import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/platform_interface.dart';
import 'package:flutter/material.dart';
import 'dart:io';

File file = File('assets/hand.jpeg');
FileImage image = FileImage(file);
bool value = false;
String play = "";
void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String statusText = "Start Server";
  startServer() async {
    setState(() {
      statusText = "Starting server on Port : 8080";
    });
    var server = await HttpServer.bind(InternetAddress.anyIPv4, 8080);
    print("Server running on IP : " +
        server.address.toString() +
        " On Port : " +
        server.port.toString());
    value=true;
    setState(() {

    });
    await for (var request in server) {
      request.response
        ..headers.contentType =
            new ContentType("text", "plain", charset: "utf-8")
        ..write("$play")
        ..close();
    }
    setState(() {
      statusText = "Server running on IP : " +
          server.address.toString() +
          " On Port : " +
          server.port.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              startServer();
            },
            child: Text(statusText),
          ),
          (value)
              ? Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        child: Text("Play"),
                        onPressed: () {
                          play = "Play";
                          setState(() {});
                        },
                      ),
                      RaisedButton(
                        child: Text("Stop"),
                        onPressed: () {
                          play = "Stop";
                          setState(() {});
                        },
                      )
                    ],
                  ),
              )
              : Container()
        ],
      ),
    ));
  }
}
