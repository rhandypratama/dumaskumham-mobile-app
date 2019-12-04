import 'dart:convert';
import 'dart:io';
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

  Future<http.Response> kirimLaporan(PengaduanModel data) async {
    var response = await http.post(
      "$apiUrl/api/laporan/create",
      headers: {"x-api-key": apiKey},
      body: json.encode(data),
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
}