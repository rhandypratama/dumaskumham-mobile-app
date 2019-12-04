import 'package:flutter/material.dart';
class Alert extends StatelessWidget {
  final String title;
  final String description;
  final String btnText;
  Alert({Key key, this.title, this.description, this.btnText}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    // return showDialog(
    //   context: context,
    //   builder: (context) {
    //     return AlertDialog(
    //       title: Text('Sukses buat laporan'),
    //       // content: Text('Sukses buat laporan'),
    //       actions: <Widget>[
    //         new FlatButton(
    //           child: new Text("TUTUP"),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //       ],
    //     );
    //   }
    // );
        
  }
}