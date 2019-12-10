import 'package:flutter/material.dart';

class CariTicket extends StatefulWidget {
  @override
  _CariTicketState createState() => _CariTicketState();
}

class _CariTicketState extends State<CariTicket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.teal,
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 50.0,
                  width: 260.0,
                  child: Theme(
                    data: ThemeData(
                      primaryColor: Colors.white,
                      primaryColorDark: Colors.white,
                    ),
                    child: TextFormField(
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(5),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          // borderSide: BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        ),
                          hintText: "Cari laporan pengaduan"),
                    ),
                  ),
                ),
                ButtonTheme(
                  // minWidth: MediaQuery.of(context).size.width,
                  height: 50,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(4.0),
                    // side: BorderSide(color: Colors.red)
                    ),
                    child: Text(
                      'Cari',
                      style: TextStyle(
                        // fontFamily: 'Montserrat',
                        color: Colors.white,
                        // fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                    ),
                    color: Color.fromRGBO(90, 186, 146, 1),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => CariTicket()));
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
          ]
        ), // )
      ), // )
    );
  }
}