import 'dart:convert';
import 'dart:io';
// import 'dart:io';

import 'package:dumaskumham/model/pengaduanModel.dart';
import 'package:dumaskumham/services/apiService.dart';
import 'package:dumaskumham/ui/terimaKasih.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pengaduan extends StatefulWidget {
  @override
  _PengaduanState createState() => _PengaduanState();
}

class _PengaduanState extends State<Pengaduan> {
  ApiService _api = ApiService();
  bool _isLoading = false;
  
  String nama = '';
  String jenisLaporan = '';
  String nip = '';
  String email = '';
  String noPonsel = '';
  String alamat = '';

  final controllerUnit = TextEditingController();
  final controllerJenisPelanggaran = TextEditingController();
  final controllerDescPelanggaran = TextEditingController();
  final controllerDescLampiran = TextEditingController();
  
  String _btn2SelectedVal;
  final items = {
    '1': 'Pelanggaran Disiplin Pegawai',
    '2': 'Penyalahgunaan Wewenang, Mal Administrasi dan Kekerasan Dalam Rumah Tangga',
    '3': 'Perilaku Amoral / Perselingkuhan dan Kekerasan Dalam Rumah Tangga',
    '4': 'Korupsi',
    '5': 'Pengadaan Barang dan Jasa / BAMA',
    '6': 'Pungutan Liar, Percaloan dan Pengurusan Dokumen',
    '7': 'Narkoba',
    '8': 'Pelayanan Publik',
  };

  _getDataDiri() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nama = prefs.getString('nama-pelapor');
      jenisLaporan = prefs.getString('jenis-laporan');
      nip = prefs.getString('nip-nik');
      email = prefs.getString('email');
      noPonsel = prefs.getString('no-ponsel');
      alamat = prefs.getString('alamat');
    });
    // print(nama);
    // Navigator.of(context).push(
    //   MaterialPageRoute<Null>(
    //     builder: (BuildContext context) {
    //       return Pengaduan();
    //     },
    //     fullscreenDialog: true,
    //   ),
    // );
  }

  @override
  void initState() {
    super.initState();
    _getDataDiri();
  }

  @override
  void dispose() {
    controllerUnit.dispose();
    controllerJenisPelanggaran.dispose();
    controllerDescPelanggaran.dispose();
    controllerDescLampiran.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.teal,
        padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              Center(
                child: Image.asset(
                  "assets/images/kumham.png",
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width - 300,
                ),
              ),
              SizedBox(height: 8.0),
              Center(
                child: Text("FORM PENGADUAN",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    )),
              ),
              SizedBox(height: 20),
              TextField(
                controller: controllerUnit,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Unit yang dilaporkan",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.tealAccent.shade400, width: 4.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal.shade100, width: 4.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(
                      color: Colors.white,
                      style: BorderStyle.solid,
                      width: 0.80),
                ),
                child: DropdownButton(
                  value: _btn2SelectedVal,
                  hint: Text('Jenis Pelanggaran'),
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
                controller: controllerDescPelanggaran,
                keyboardType: TextInputType.text,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Deskripsi pelanggaran",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.tealAccent.shade400, width: 4.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal.shade100, width: 4.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: controllerDescLampiran,
                keyboardType: TextInputType.text,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Deskripsi lampiran",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.tealAccent.shade400, width: 4.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal.shade100, width: 4.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,

                ),
              ),
              SizedBox(height: 10),

              // Wrap(
              ButtonTheme(
                minWidth: MediaQuery.of(context).size.width,
                height: 50,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(4.0),
                      // side: BorderSide(color: Colors.red)
                    ),
                    // padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 14.0),
                    child: _isLoading ? 
                      SizedBox(
                        height: 30.0,
                        width: 30.0,
                        child: CircularProgressIndicator(
                          value: null,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ) 
                      : Text(
                      'Lapor',
                      style: TextStyle(
                          // fontFamily: 'Montserrat',
                          color: Colors.white,
                          // fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                    color: Color.fromRGBO(90, 186, 146, 1),
                    onPressed: () {
                      if (controllerUnit.text.trim().isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text('Unit dilaporkan harus diisi'),
                            );
                          }
                        );
                      } else if (_btn2SelectedVal == null) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text('Jenis pelanggaran harus dipilih'),
                            );
                          }
                        );
                      } else if (controllerDescPelanggaran.text.trim().isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text('Deskripsi pelanggaran harus diisi'),
                            );
                          }
                        );
                      } else if (controllerDescLampiran.text.trim().isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text('Deskripsi lampiran harus diisi'),
                            );
                          }
                        );
                      } else {
                        
                        // setState(() => _isLoading = true);
                        String unitDilaporkan = controllerUnit.text.trim();
                        String jenisPelanggaran = _btn2SelectedVal;
                        String deskripsiPelanggaran = controllerDescPelanggaran.text.trim();
                        File lampiran;
                        String deskripsiLampiran = controllerDescLampiran.text.trim();
                        PengaduanModel dataPengaduan = PengaduanModel(
                          namaPelapor: nama.toString(), 
                          jenisLaporan: jenisLaporan.toString(),
                          nipNik: nip.toString(),
                          email: email.toString(),
                          noPonsel: noPonsel.toString(),
                          alamatRumah: alamat.toString(),
                          unitDilaporkan: unitDilaporkan.toString(),
                          jenisPelanggaran: jenisPelanggaran.toString(),
                          deskripsiPelanggaran: deskripsiPelanggaran.toString(),
                          // lampiran: lampiran.path.split('/').last,
                          deskripsiLampiran: deskripsiLampiran.toString(),
                        );

                        // print(dataPengaduan);
                        // _api.kirimLaporan1(dataPengaduan).then((res) {
                        //   // print(res.toString());
                        // });
                        
                        _api.kirimLaporan(dataPengaduan).then((res) {
                          setState(() => _isLoading = false);
                          // print(dataPengaduan);
                          print(res.body);
                          print(json.decode(res.body));
                          if (res.statusCode == 200) {
                            Navigator.of(context).push(
                              MaterialPageRoute<Null>(
                                builder: (BuildContext context) {
                                  return TerimaKasih();
                                },
                                fullscreenDialog: true,
                              ),
                            );
                          } else { 
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(json.decode(res.body)['message']),
                                  content: Text('Terjadi kesalahan saat pengiriman laporan pengaduan. Silahkan coba kembali beberapa saat lagi.'),
                                  // content: Text('Sukses buat laporan'),
                                  actions: <Widget>[
                                    new FlatButton(
                                      child: new Text("TUTUP"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              }
                            );
                          }
                        });

                      }
                    }

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
