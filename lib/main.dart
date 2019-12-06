import 'package:dumaskumham/ui/dataDiri.dart';
import 'package:dumaskumham/ui/pengaduan.dart';
// import 'package:dumaskumham/ui/file_picker_demo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: true,
    // debugShowCheckedModeBanner: false,
    // theme: ThemeData.dark(),
    // initialRoute: '/start',
    routes: {
      // '/start': (BuildContext context) => new Start(),
      '/data-diri': (BuildContext context) => new DataDiri(),
      '/pengaduan': (BuildContext context) => new Pengaduan(),
    },
    // home: new FilePickerDemo(),
    home: new DataDiri(),
  ));
}
