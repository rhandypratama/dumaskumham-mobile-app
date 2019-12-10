import 'package:dumaskumham/ui/dataDiri.dart';
import 'package:dumaskumham/ui/start.dart';
import 'package:flutter/material.dart';

class TerimaKasih extends StatefulWidget {
  @override
  _TerimaKasihState createState() => _TerimaKasihState();
}

class _TerimaKasihState extends State<TerimaKasih> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.teal,
        padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: Image.asset(
                "assets/images/kumham.png",
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width - 300,
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: Text("TERIMA KASIH",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
            ),
            SizedBox(height: 30),
            Center(
              child: Text("Laporan anda akan segera kami proses. Tindak lanjut laporan akan kami kirimkan ke email anda. Mohon untuk periksa email anda secara berkala.",
              // child: Text("Laporan anda akan .",
                style: TextStyle(
                  color: Colors.white,
                  // fontWeight: FontWeight.bold,
                  fontSize: 14,
                )),
            ),
            SizedBox(height: 30,),
            // Wrap(
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              height: 40,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(4.0),
                    // side: BorderSide(color: Colors.red)
                  ),
                  // padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 14.0),
                  child: Text(
                    'Kembali',
                    style: TextStyle(
                        // fontFamily: 'Montserrat',
                        color: Colors.white,
                        // fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  color: Color.fromRGBO(90, 186, 146, 1),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute<Null>(
                        builder: (BuildContext context) {
                          return Start();
                        },
                      ),
                    );
                  }),
            ),
            // ),
          ],
        ),
      ),
    );
  }
}
