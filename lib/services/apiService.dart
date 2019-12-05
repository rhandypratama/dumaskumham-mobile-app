import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';
// import 'dart:io';
import 'package:dumaskumham/model/pengaduanModel.dart';
import 'package:http/http.dart' as http;

class ApiService {

  final String apiUrl = "http://dumas.docotel.net";
  final String apiKey = "SWYgd2UgY2FuIGRvIGl0IHRvbW9ycm93ID8ga2VuYXBhIGhhcnVzIHNla2FyYW5nID8=";
  
  // Future<http.Response> doLogin(Profile data) async {
  //   // try {
  //     var response = await http.post(
  //       "$apiUrl/guest/login",
  //       headers: {"content-type": "application/json"},
  //       body: profileToJson(data),
  //     );
  //     return response;
  //   // } on SocketException catch(_) {
  //   //   print('internet');
  //   // } catch(e) {
  //   //   print('error');
  //   // }
  // }

  Future<http.Response> kirimLaporan(data) async {
    // var map = new Map<String, dynamic>();
    
    // map["nama_pelapor"] = namaPelapor; 
    // map["jenis_laporan"] = jenisLaporan; 
    // map["nip_nik"] = nipNik; 
    // map["email"] = email;
    // map["no_ponsel"] = noPonsel;
    // map["alamat_rumah"] = alamatRumah;
    // map["unit_dilaporkan"] = unitDilaporkan;
    // map["jenis_pelanggaran"] = jenisPelanggaran;
    // map["deskripsi_pelanggaran"] = deskripsiPelanggaran;
    // map["lampiran"] = lampiran;
    // map["deskripsi_lampiran"] = deskripsiLampiran;
    var response = await http.post(
      "$apiUrl/api/laporan/create",
      headers: {"x-api-key": apiKey},
      // body: json.encode(data),
      body: data,
    );
    return response;
  }

  Future<http.Response> getAllPembelajaran(String code) async {
    var response = await http.get(
      "$apiUrl/api/laporan/check?ticket_code=$code",
      // headers: {HttpHeaders.authorizationHeader: token, HttpHeaders.acceptHeader: "application/json"}
      headers: {"x-api-key": apiKey},
    );
    return response;
  }

  Future kirimLaporan1(PengaduanModel data) async {
    // Map<String, dynamic> dataq = json.encode(data);
    // print(data["score"]);
    // Map<PengaduanModel> a = json.encode(data);
    // print(json.encode(data.namaPelapor));

    // var uri = Uri.parse("http://pub.dartlang.org/packages/create");
    // var request = new http.MultipartRequest("POST", uri);
    // request.fields['user'] = 'nweiz@google.com';
    // request.files.add(new http.MultipartFile.fromPath(
    // 'package',
    // 'build/package.tar.gz',
    // contentType: new MediaType('application', 'x-tar'));
    // var response = await request.send();
    // if (response.statusCode == 200) print('Uploaded!');

    // File second = File('analysis_options.yaml');
    File first = File('/storage/emulated/0/DCIM/Camera/IMG_20191129_073320.jpg');
    Uri uri = Uri.parse('$apiUrl/api/laporan/create');
    http.MultipartRequest request = new http.MultipartRequest('POST', uri);
    request.headers['x-api-key'] = apiKey;
    request.fields['nama_pelapor'] = json.encode(data.namaPelapor);
    request.fields['jenis_laporan'] = json.encode(data.jenisLaporan);
    request.fields['nip_nik'] = json.encode(data.nipNik);
    request.fields['no_ponsel'] = json.encode(data.noPonsel);
    request.fields['email'] = json.encode(data.email);
    request.fields['alamat_rumah'] = json.encode(data.alamatRumah);
    request.fields['unit_dilaporkan'] = json.encode(data.unitDilaporkan);
    request.fields['jenis_pelanggaran'] = json.encode(data.jenisPelanggaran);
    request.fields['deskripsi_pelanggaran'] = json.encode(data.deskripsiPelanggaran);
    request.fields['deskripsi_lampiran'] = json.encode(data.deskripsiLampiran);
    request.files.add(await http.MultipartFile.fromPath('lampiran', first.path));

    // request.files.add(await http.MultipartFile.fromPath(
    //     'image_file2', second.path,
    //     contentType: new MediaType('image', 'x-tar')));
    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    print(response.request);
    return response;
  }

  kirimLaporan2(
    String namaPelapor,
    String jenisLaporan,
    String nipNik,
    String email,
    String noPonsel,
    String alamatRumah,
    String unitDilaporkan,
    String jenisPelanggaran,
    String deskripsiPelanggaran,
    File lampiran,
    String deskripsiLampiran
  ) async {    
    var stream = new http.ByteStream(DelegatingStream.typed(lampiran.openRead()));
    var length = await lampiran.length();
    var uri = Uri.parse("$apiUrl/api/laporan/create");

    var request = new http.MultipartRequest("POST", uri);
    request.headers['x-api-key'] = apiKey;

    var multipartFile = new http.MultipartFile('lampiran', stream, length, filename: basename(lampiran.path));
    request.files.add(multipartFile);
    request.fields['nama_pelapor'] = namaPelapor;
    request.fields['jenis_laporan'] = jenisLaporan;
    request.fields['nip_nik'] = nipNik;
    request.fields['no_ponsel'] = noPonsel;
    request.fields['email'] = email;
    request.fields['alamat_rumah'] = alamatRumah;
    request.fields['unit_dilaporkan'] = unitDilaporkan;
    request.fields['jenis_pelanggaran'] = jenisPelanggaran;
    request.fields['deskripsi_pelanggaran'] = deskripsiPelanggaran;
    request.fields['deskripsi_lampiran'] = deskripsiLampiran;

    var response = await request.send();
    return response;
    // response.stream.transform(utf8.decoder).listen((value) {
    //   // print(json.decode(value));
    //   print(value);
    // });
  }
}