import 'package:dumaskumham/ui/dataDiri.dart';
import 'package:flutter/material.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.teal,
//        height: MediaQuery.of(context).size.height,
//        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(vertical: 200.0, horizontal: 40.0),
        child: ListView(
          children: <Widget>[
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              height: 40,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(4.0),
                // side: BorderSide(color: Colors.red)
                ),
                child: Text(
                  'Cari ticket laporan pengaduan',
                  style: TextStyle(
                    // fontFamily: 'Montserrat',
                    color: Colors.white,
                    // fontWeight: FontWeight.bold,
                    fontSize: 18.0),
                ),
                color: Color.fromRGBO(90, 186, 146, 1),
                onPressed: () {},
              ),
            ),
            SizedBox(height: 10.0,),
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              height: 40,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(4.0),
                  // side: BorderSide(color: Colors.red)
                ),
                child: Text(
                  'Buat laporan pengaduan',
                  style: TextStyle(
                    // fontFamily: 'Montserrat',
                      color: Colors.white,
                      // fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
                color: Color.fromRGBO(90, 186, 146, 1),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => DataDiri()));
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
