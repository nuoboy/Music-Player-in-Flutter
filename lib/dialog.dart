import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'main.dart';

class Displaybox extends StatelessWidget {
  final VoidCallback onSubmit;
  Displaybox({this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2.0),
          color: Colors.white,

          borderRadius: BorderRadius.circular(12.0),
        ),
        height: 360.0,
        child: Column(
          children: <Widget>[
            Text(
              "Lyrics",
              style: GoogleFonts.pacifico(
                  textStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                child: TextField(
                  decoration: InputDecoration(border: OutlineInputBorder(),hintText:"Enter the lyrics"),

              maxLines: 10,
              onChanged: (text) {
                lyrics = text;
              },
            )),
            Center(
                child: RaisedButton(
              color: Colors.pinkAccent,
              onPressed: () {

                onSubmit();

              },
              child: Text(
                "Submit",
                style:
                    GoogleFonts.pacifico(textStyle: TextStyle(fontSize: 20.0)),
              ),
            ))
          ],
        ),
      ),
    );
    ;
  }
}
