import 'dart:convert';

import 'package:dumaskumham/services/apiService.dart';
import 'package:flutter/material.dart';

class CariTicket extends StatefulWidget {
  @override
  _CariTicketState createState() => _CariTicketState();
}

class _CariTicketState extends State<CariTicket> {
  bool isLoading = false;
  ApiService _api = ApiService();
  TextEditingController _controller = TextEditingController();

  Future<void> _showAlert1(
    String title, 
    String namaPelapor,
    String email,
    String jenisLaporan,
    String unitDilaporkan,
    String jenisPelanggaran,
    String status,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return AlertDialog(
            // backgroundColor: Colors.black87,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(new Radius.circular(8.0))),
            title: Text(title, style: TextStyle(color: Colors.black),),
            // title: Text('Data Pelapor', style: TextStyle(color: Colors.white),),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('NAMA PELAPOR', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, right: 8.0),
                    child: Text(namaPelapor, style: TextStyle(color: Colors.black),),
                  ),
                  Text('EMAIL', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, right: 8.0),
                    child: Text(email, style: TextStyle(color: Colors.black),),
                  ),
                  Text('JENIS LAPORAN', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, right: 8.0),
                    child: Text(jenisLaporan, style: TextStyle(color: Colors.black),),
                  ),
                  Text('UNIT DILAPORKAN', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, right: 8.0),
                    child: Text(unitDilaporkan, style: TextStyle(color: Colors.black),),
                  ),
                  Text('JENIS PELANGGARAN', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, right: 8.0),
                    child: Text(jenisPelanggaran, style: TextStyle(color: Colors.black),),
                  ),
                  Text('STATUS', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, right: 8.0),
                    child: Text(status, style: TextStyle(color: Colors.black),),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('TUTUP', style: TextStyle(color: Colors.teal),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          
        );
      },
    );
  }

  Future<void> _showAlert2(String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return AlertDialog(
            // backgroundColor: Colors.black87,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(new Radius.circular(8.0))),
            title: Text(title, style: TextStyle(color: Colors.black),),
            // title: Text('Data Pelapor', style: TextStyle(color: Colors.white),),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(message, style: TextStyle(color: Colors.black),),
                  // Text(message, style: TextStyle(color: Colors.white),),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('TUTUP', style: TextStyle(color: Colors.teal),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.teal,
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            SizedBox(height: 25),
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
                    child: TextField(
                      controller: _controller,
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
                          hintText: "Kode Tiket"),
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
                    child: (isLoading) ? new CircularProgressIndicator() : 
                    Text(
                      'Cari',
                      style: TextStyle(
                        // fontFamily: 'Montserrat',
                        color: Colors.white,
                        // fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                    ),
                    color: Color.fromRGBO(90, 186, 146, 1),
                    onPressed: () {
                      var txtKode = _controller.text.toString();
                      if (txtKode != '') {
                        setState(() => isLoading = true);
                        _api.getDetailTicket(txtKode).then((res) {
                          setState(() => isLoading = false);
                          var resData = json.decode(res.body);
                          if (res.statusCode == 200) {
                            _showAlert1(
                              'Pengaduan #${_controller.text.toString()}', 
                              resData['data']['nama_pelapor'],
                              resData['data']['email'],
                              resData['data']['jenis_laporan'],
                              resData['data']['unit_dilaporkan'],
                              resData['data']['jenis_pelanggaran'],
                              resData['data']['status'],
                            );
                          } else {
                            _showAlert2('Oops!', 'Laporan pengaduan dengan kode tiket #${_controller.text.toString()} tidak ditemukan');
                          }
                          print(resData);
                          // _showAlert(title, message)
                        });
                        // print(_controller.text.toString());

                      }
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