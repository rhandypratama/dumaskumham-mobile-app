import 'package:flutter/material.dart';
// import 'dart:async';
import 'package:dumaskumham/ui/pengaduan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataDiri extends StatefulWidget {
  @override
  _DataDiriState createState() => _DataDiriState();
}

class _DataDiriState extends State<DataDiri> {
  final controllerNama = TextEditingController();
  final controllerJenisLaporan = TextEditingController();
  final controllerNip = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerNoPonsel = TextEditingController();
  final controllerAlamat = TextEditingController();

  String _btn2SelectedVal;
  final items = {
    '1': 'Intern / WBS',
    '2': 'Umum / Masyarakat'
  };

  // _goToLogin(String txtToken) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('access_token', txtToken);
  //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => App()));
  //   // Navigator.of(context).push(MaterialPageRoute(builder: (context) => App()));
  //   // setState(() {token = txtToken;});
  // }

  // _masukData(String nama, String jenisLaporan, String nip, String email, String noPonsel, String alamat) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('nama-pelapor', nama);
  //   prefs.setString('jenis-laporan', jenisLaporan);
  //   prefs.setString('nip-nik', nip);
  //   prefs.setString('email', email);
  //   prefs.setString('no-ponsel', noPonsel);
  //   prefs.setString('alamat', alamat);
  //   Navigator.of(context).push(
  //     MaterialPageRoute<Null>(
  //       builder: (BuildContext context) {
  //         return Pengaduan();
  //       },
  //       fullscreenDialog: true,
  //     ),
  //   );
  //   // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => App()));
  //   // Navigator.of(context).push(MaterialPageRoute(builder: (context) => App()));
  //   // setState(() {token = txtToken;});
  // }

  _masuk() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // setState(() {
      prefs.setString('nama-pelapor', controllerNama.text.trim());
      prefs.setString('jenis-laporan', _btn2SelectedVal);
      prefs.setString('nip-nik', controllerNip.text.trim());
      prefs.setString('email', controllerEmail.text.trim());
      prefs.setString('no-ponsel', controllerNoPonsel.text.trim());
      prefs.setString('alamat', controllerAlamat.text.trim());
    // });
    Navigator.of(context).push(
      MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return Pengaduan();
        },
        fullscreenDialog: true,
      ),
    );
  }

  @override
  void dispose() {
    controllerNama.dispose();
    controllerJenisLaporan.dispose();
    controllerNip.dispose();
    controllerEmail.dispose();
    controllerNoPonsel.dispose();
    controllerAlamat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.teal,
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20.0),
              Center(
                child: Image.asset(
                  "assets/images/kumham.png",
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width - 300,
                ),
              ),
              SizedBox(height: 8.0),
              Center(
                child: Text("DATA DIRI",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    )),
              ),
              SizedBox(height: 20),
              TextField(
                controller: controllerNama,
                keyboardType: TextInputType.text,
                
                decoration: InputDecoration(
                  labelText: "Nama",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.tealAccent.shade400, width: 4.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal.shade100, width: 4.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  // hintText: "",
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.white,
                      style: BorderStyle.solid,
                      width: 0.80),
                ),
                child: DropdownButton(
                  value: _btn2SelectedVal,
                  hint: Text('Klasifikasi Pelapor'),
                  onChanged: ((String newValue) {
                    setState(() {
                      _btn2SelectedVal = newValue;
                    });
                    // print(newValue);
                  }),
                  items: items.entries
                      .map<DropdownMenuItem<String>>(
                          (MapEntry<String, String> e) =>
                              DropdownMenuItem<String>(
                                value: e.key,
                                child: Text(e.value),
                              ))
                      .toList(),
                  // style: TextStyle(color: Colors.white),
                  isExpanded: true,
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 16,
                  ),
                  underline: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: controllerNip,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "NIP / NIK",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.tealAccent.shade400, width: 4.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal.shade100, width: 4.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  // hintText: "",
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: controllerEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.tealAccent.shade400, width: 4.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal.shade100, width: 4.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  // hintText: "",
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: controllerNoPonsel,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Nomor Ponsel",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.tealAccent.shade400, width: 4.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal.shade100, width: 4.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  // hintText: "",
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: controllerAlamat,
                keyboardType: TextInputType.text,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Alamat Rumah",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.tealAccent.shade400, width: 4.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal.shade100, width: 4.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  // hintText: "",
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  
                ),
              ),
              SizedBox(height: 20),

              // Wrap(
              ButtonTheme(
                minWidth: MediaQuery.of(context).size.width,
                height: 50,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(4.0),
                      // side: BorderSide(color: Colors.red)
                    ),
                    child: Text(
                      'Masuk',
                      style: TextStyle(
                          // fontFamily: 'Montserrat',
                          color: Colors.white,
                          // fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                    color: Color.fromRGBO(90, 186, 146, 1),
                    onPressed: () async {
                      // return showDialog(
                      //   context: context,
                      //   builder: (context) {
                      //     return AlertDialog(
                      //       // Retrieve the text the that user has entered by using the
                      //       // TextEditingController.
                      //       content: Text('${controllerNama.text} $_btn2SelectedVal ${controllerNip.text}' + controllerEmail.text.trim() + controllerNoPonsel.text.trim() + controllerAlamat.text.trim()),
                      //     );
                      //   },
                      // );

                      if (controllerNama.text.trim().isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text('Nama tidak boleh kosong'),
                            );
                          }
                        );
                      } else if (_btn2SelectedVal == null) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text('Jenis laporan harus dipilih'),
                            );
                          }
                        );
                      } else if (controllerNip.text.trim().isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text('NIP / NIK harus diisi'),
                            );
                          }
                        );
                      } else if (controllerEmail.text.trim().isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text('Email harus diisi'),
                            );
                          }
                        );
                      } else if (controllerNoPonsel.text.trim().isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text('Nomor ponsel harus diisi'),
                            );
                          }
                        );
                      } else if (controllerAlamat.text.trim().isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text('Alamat rumah harus diisi'),
                            );
                          }
                        );
                      } else {
                        // print(_btn2SelectedVal);
                        // _masuk(
                        //   controllerNama.text.trim(), 
                        //   _btn2SelectedVal, 
                        //   controllerNip.text.trim(), 
                        //   controllerEmail.text.trim(), 
                        //   controllerNoPonsel.text.trim(),
                        //   controllerAlamat.text.trim() 
                        // );
                        _masuk();
                        // final SharedPreferences prefs = await SharedPreferences.getInstance();
                        // prefs.setString('nama-pelapor', controllerNama.text.trim());

                      }
                    } 
                    // .catchError((e){
                    //   print("Got error: ${e.error}");
                    // });

                    ),
              ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget _buildTextField(String label) {
//   return TextField(
//     // controller: myController,
//     keyboardType: TextInputType.text,
//     decoration: InputDecoration(
//       labelText: label,
//       // errorText: _isNamaValid == null || _isNamaValid ? null : "Nama dibutuhkan",
//       focusedBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.yellow, width: 0.8),
//         borderRadius: BorderRadius.circular(4.0),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.white, width: 1.0),
//         borderRadius: BorderRadius.circular(4.0),
//       ),
//       // hintText: "",
//       labelStyle: TextStyle(color: Colors.white),
//       // prefixIcon: Icon(
//       //   Icons.person_outline,
//       //   size: 27,
//       //   color: Color(0xFFF032f41),
//       // ),
//       // errorBorder: OutlineInputBorder(
//       //   borderSide: BorderSide(color: Colors.grey, width: 1.0),
//       //   borderRadius: BorderRadius.circular(10.0),
//       // ),
//       // focusedErrorBorder: OutlineInputBorder(
//       //   borderSide: BorderSide(color: Colors.grey, width: 1.0),
//       //   borderRadius: BorderRadius.circular(10.0),
//       // ),
//       // errorStyle: TextStyle(color: Colors.redAccent),
//     ),
//     onChanged: (value) {
//       // bool isFieldValid = value.trim().isNotEmpty;
//       // if (isFieldValid != _isNamaValid) {
//       //   setState(() => _isNamaValid = isFieldValid);
//       // }
//     },
//   );
// }

// Widget _buildTextFieldNumber(String label) {
//   return TextField(
//     keyboardType: TextInputType.number,
//     decoration: InputDecoration(
//       labelText: label,
//       focusedBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.yellow, width: 0.8),
//         borderRadius: BorderRadius.circular(4.0),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.white, width: 1.0),
//         borderRadius: BorderRadius.circular(4.0),
//       ),
//       labelStyle: TextStyle(color: Colors.white),
//     ),
//     onChanged: (value) {
//       // bool isFieldValid = value.trim().isNotEmpty;
//       // if (isFieldValid != _isNamaValid) {
//       //   setState(() => _isNamaValid = isFieldValid);
//       // }
//     },
//   );
// }

// Widget _buildTextFieldEmail(String label) {
//   return TextField(
//     keyboardType: TextInputType.emailAddress,
//     decoration: InputDecoration(
//       labelText: label,
//       focusedBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.yellow, width: 0.8),
//         borderRadius: BorderRadius.circular(4.0),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.white, width: 1.0),
//         borderRadius: BorderRadius.circular(4.0),
//       ),
//       labelStyle: TextStyle(color: Colors.white),
//     ),
//     onChanged: (value) {
//       // bool isFieldValid = value.trim().isNotEmpty;
//       // if (isFieldValid != _isNamaValid) {
//       //   setState(() => _isNamaValid = isFieldValid);
//       // }
//     },
//   );
// }

// Widget _buildTextArea(String label) {
//   return TextField(
//     // controller: _controllerNama,
//     keyboardType: TextInputType.text,
//     maxLines: 3,
//     decoration: InputDecoration(
//       labelText: label,
//       // errorText: _isNamaValid == null || _isNamaValid ? null : "Nama dibutuhkan",
//       focusedBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.yellow, width: 0.8),
//         borderRadius: BorderRadius.circular(4.0),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.white, width: 1.0),
//         borderRadius: BorderRadius.circular(4.0),
//       ),
//       // hintText: "",
//       labelStyle: TextStyle(color: Colors.white),
//       // errorBorder: OutlineInputBorder(
//       //   borderSide: BorderSide(color: Colors.grey, width: 1.0),
//       //   borderRadius: BorderRadius.circular(10.0),
//       // ),
//       // focusedErrorBorder: OutlineInputBorder(
//       //   borderSide: BorderSide(color: Colors.grey, width: 1.0),
//       //   borderRadius: BorderRadius.circular(10.0),
//       // ),
//       // errorStyle: TextStyle(color: Colors.redAccent),
//     ),
//     onChanged: (value) {
//       // bool isFieldValid = value.trim().isNotEmpty;
//       // if (isFieldValid != _isNamaValid) {
//       //   setState(() => _isNamaValid = isFieldValid);
//       // }
//     },
//   );
// }
