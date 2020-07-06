import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';


void main(){
  runApp(FileServer());
}

class FileServer extends StatefulWidget {
  @override
  _FileServerState createState() => _FileServerState();
}

class _FileServerState extends State<FileServer> {
  File htmlFile=File("assets/index.html");

  Future server_function() async{
    Stream<HttpRequest> server;
    var htmlword= await rootBundle.load("assets/index.html");
    String sentence="<html><body><h1>An img src demo</h1> "+ "<img src=" + "amal.JPG"+" title=" + "A banana image" + " alt=" + "Banana is good in taste!" + "/></body> </html>";
    print(sentence);


    try{
      server= await HttpServer.bind(InternetAddress.anyIPv4, 8080);
    }catch(e){
      print("error $e");
    }
    await for(HttpRequest req in server){

      if(true){
        print(1);
        req.response.headers.contentType=ContentType.html;
        try{
          //await req.response.write(sentence);
          await req.response.addStream(htmlFile.openRead());
        }catch(e){
          print("error in html");
        }
      }
      else{
        req.response.headers.contentType=ContentType.text;
        req.response.write("Failed as usual");

      }
      await req.response.close();
    }

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Center(
                child: RaisedButton(child: Text("File Server"),onPressed: (){
                  htmlFile=File("assets/index.html");
                  server_function();
                },),
              ),
              Container(width: 100,height:100,child: Image.asset("assets/amal.JPG"))
            ],
          ),
        ),
      ),
    );
  }
}



