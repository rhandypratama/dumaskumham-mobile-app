import 'dart:convert';
import 'dart:io';
// import 'dart:io';

// import 'package:dumaskumham/model/pengaduanModel.dart';
import 'package:dumaskumham/services/apiService.dart';
import 'package:dumaskumham/ui/terimaKasih.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';

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

  String _fileName;
  String _path;
  Map<String, String> _paths;
  String _extension;
  bool _loadingPath = false;
  bool _multiPick = false;
  bool _hasValidMime = false;
  FileType _pickingType;
  // TextEditingController _controller = new TextEditingController();

  void _openFileExplorer() async {
    if (_pickingType != FileType.CUSTOM || _hasValidMime) {
      setState(() => _loadingPath = true);
      try {
        if (_multiPick) {
          _path = null;
          _paths = await FilePicker.getMultiFilePath(
              type: _pickingType, fileExtension: _extension);
        } else {
          _paths = null;
          _path = await FilePicker.getFilePath(
              type: _pickingType, fileExtension: _extension);
        }
      } on PlatformException catch (e) {
        print("Unsupported operation" + e.toString());
      }
      if (!mounted) return;
      setState(() {
        _loadingPath = false;
        _fileName = _path != null
            ? _path.split('/').last
            : _paths != null ? _paths.keys.toString() : '...';
      });
    }
  }

  Future<void> _showAlert(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return AlertDialog(
            // backgroundColor: Colors.black87,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(new Radius.circular(8.0))),
            title: Text('Data Pelapor', style: TextStyle(color: Colors.black),),
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
                      fontSize: 20,
                    )),
              ),
              SizedBox(height: 10),
              TextField(
                controller: controllerUnit,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Unit yang dilaporkan",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.tealAccent.shade400, width: 2.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.teal.shade100, width: 4.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  labelStyle: TextStyle(color: Colors.black, fontSize: 13.0),
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
                  hint: Text('Jenis Pelanggaran', style: TextStyle(fontSize: 13.0)),
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
                                child: Text(e.value, style: TextStyle(fontSize: 13.0)),
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
                      borderSide: BorderSide(color: Colors.tealAccent.shade400, width: 2.0),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal.shade100, width: 4.0),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    labelStyle: TextStyle(color: Colors.black, fontSize: 13.0),
                    filled: true,
                    fillColor: Colors.white),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 0.0, bottom: 10.0),
                child: new RaisedButton(
                  onPressed: () => _openFileExplorer(),
                  child: new Text("File Lampiran", style: TextStyle(fontSize: 13.0),),
                ),
              ),
              Builder(
                builder: (BuildContext context) => _loadingPath
                    ? Center(
                        // padding: const EdgeInsets.only(left: 100.0, right: 100.0, bottom: ),
                        child: CircularProgressIndicator())
                    : _path != null || _paths != null
                        ? new Container(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            height: MediaQuery.of(context).size.height * 0.10,
                            child: new Scrollbar(
                                child: new ListView.separated(
                              itemCount: _paths != null && _paths.isNotEmpty
                                  ? _paths.length
                                  : 1,
                              itemBuilder: (BuildContext context, int index) {
                                final bool isMultiPath =
                                    _paths != null && _paths.isNotEmpty;
                                final String name = 'File ${index + 1} => ' +
                                    (isMultiPath
                                        ? _paths.keys.toList()[index]
                                        : _fileName ?? '...');
                                final path = 'Path ${index + 1} => ' +
                                    (isMultiPath
                                        ? _paths.values
                                            .toList()[index]
                                            .toString()
                                        : _path);
                                return new ListTile(
                                  title: new Text(
                                    name,
                                    style: TextStyle(color: Colors.white, fontSize: 12.0),
                                  ),
                                  subtitle: new Text(
                                    path,
                                    style: TextStyle(color: Colors.white, fontSize: 12.0),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      new Divider(),
                            )),
                          )
                        : new Container(),
              ),
              TextField(
                controller: controllerDescLampiran,
                keyboardType: TextInputType.text,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Deskripsi lampiran",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.tealAccent.shade400, width: 2.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal.shade100, width: 4.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  labelStyle: TextStyle(color: Colors.black, fontSize: 13.0),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 10),

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
                    child: _isLoading
                        ? SizedBox(
                            height: 30.0,
                            width: 30.0,
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            'Lapor',
                            style: TextStyle(
                                // fontFamily: 'Montserrat',
                                color: Colors.white,
                                // fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                    color: Color.fromRGBO(90, 186, 146, 1),
                    onPressed: () {
                      if (controllerUnit.text.trim().isEmpty) {
                        _showAlert('Unit dilaporkan harus diisi');
                      } else if (_btn2SelectedVal == null) {
                        _showAlert('Jenis pelanggaran harus dipilih');
                      } else if (controllerDescPelanggaran.text.trim().isEmpty) {
                        _showAlert('Deskripsi pelanggaran harus diisi');
                      } else if (_path == null) {
                        _showAlert('File lampiran harus ada');  
                      } else if (controllerDescLampiran.text.trim().isEmpty) {
                        _showAlert('Deskripsi lampiran harus diisi');
                      } else {
                        setState(() => _isLoading = true);
                        String unitDilaporkan = controllerUnit.text.trim();
                        String jenisPelanggaran = _btn2SelectedVal;
                        String deskripsiPelanggaran = controllerDescPelanggaran.text.trim();
                        File lampiran = File(_path);
                        String deskripsiLampiran = controllerDescLampiran.text.trim();
                        // PengaduanModel dataPengaduan = PengaduanModel(
                        //   namaPelapor: nama.toString(),
                        //   jenisLaporan: jenisLaporan.toString(),
                        //   nipNik: nip.toString(),
                        //   email: email.toString(),
                        //   noPonsel: noPonsel.toString(),
                        //   alamatRumah: alamat.toString(),
                        //   unitDilaporkan: unitDilaporkan.toString(),
                        //   jenisPelanggaran: jenisPelanggaran.toString(),
                        //   deskripsiPelanggaran: deskripsiPelanggaran.toString(),
                        //   deskripsiLampiran: deskripsiLampiran.toString(),
                        // );

                        // var map = new Map<String, dynamic>();
                        // map["nama_pelapor"] = nama.toString();
                        // map["jenis_laporan"] = jenisLaporan.toString();
                        // map["nip_nik"] = nip.toString();
                        // map["email"] = email.toString();
                        // map["no_ponsel"] = noPonsel.toString();
                        // map["alamat_rumah"] = alamat.toString();
                        // map["unit_dilaporkan"] = unitDilaporkan.toString();
                        // map["jenis_pelanggaran"] = jenisPelanggaran.toString();
                        // map["deskripsi_pelanggaran"] = deskripsiPelanggaran.toString();
                        // map["lampiran"] = lampiran;
                        // map["deskripsi_lampiran"] = deskripsiLampiran.toString();

                        // print(dataPengaduan);
                        // _api.kirimLaporan1(dataPengaduan).then((res) {
                        //   // print(res.toString());
                        // });

                        // _api.kirimLaporan(map).then((res) {
                        //   setState(() => _isLoading = false);
                        //   // print(dataPengaduan);
                        //   print(res.body);
                        //   print(json.decode(res.body));
                        //   if (res.statusCode == 200) {
                        //     Navigator.of(context).push(
                        //       MaterialPageRoute<Null>(
                        //         builder: (BuildContext context) {
                        //           return TerimaKasih();
                        //         },
                        //         fullscreenDialog: true,
                        //       ),
                        //     );
                        //   } else {
                        //     showDialog(
                        //       context: context,
                        //       builder: (context) {
                        //         return AlertDialog(
                        //           title: Text(json.decode(res.body)['message']),
                        //           content: Text('Terjadi kesalahan saat pengiriman laporan pengaduan. Silahkan coba kembali beberapa saat lagi.'),
                        //           // content: Text('Sukses buat laporan'),
                        //           actions: <Widget>[
                        //             new FlatButton(
                        //               child: new Text("TUTUP"),
                        //               onPressed: () {
                        //                 Navigator.of(context).pop();
                        //               },
                        //             ),
                        //           ],
                        //         );
                        //       }
                        //     );
                        //   }
                        // });

                        _api.kirimLaporan2(
                            nama.toString(),
                            jenisLaporan.toString(),
                            nip.toString(),
                            email.toString(),
                            noPonsel.toString(),
                            alamat.toString(),
                            unitDilaporkan.toString(),
                            jenisPelanggaran.toString(),
                            deskripsiPelanggaran.toString(),
                            lampiran,
                            deskripsiLampiran.toString())
                          .then((res) {
                            setState(() => _isLoading = false);
                            res.stream
                                .transform(utf8.decoder)
                                .listen((value) async {
                              // var b = await json.decode(value);
                              print(value);
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute<Null>(
                                  builder: (BuildContext context) {
                                    return TerimaKasih();
                                  },
                                  fullscreenDialog: true,
                                ),
                              );
                          });
                        });
                      }
                    }),
              ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
