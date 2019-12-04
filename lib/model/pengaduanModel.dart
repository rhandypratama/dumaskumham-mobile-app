import 'dart:convert';

import 'dart:io';
class PengaduanModel {
  String namaPelapor;
  String jenisLaporan;
  String nipNik;
  String email;
  String noPonsel;
  String alamatRumah;
  String unitDilaporkan;
  String jenisPelanggaran;
  String deskripsiPelanggaran;
  File lampiran;
  String deskripsiLampiran;

  PengaduanModel({
    this.namaPelapor, 
    this.jenisLaporan, 
    this.nipNik, 
    this.email, 
    this.noPonsel,
    this.alamatRumah,
    this.unitDilaporkan,
    this.jenisPelanggaran,
    this.deskripsiPelanggaran,
    this.lampiran,
    this.deskripsiLampiran
  });

  factory PengaduanModel.fromJson(Map<String, dynamic> map) {
    return PengaduanModel(
      namaPelapor: map["nama_pelapor"], 
      jenisLaporan: map["jenis_laporan"], 
      nipNik: map["nip_nik"], 
      email: map["email"],
      noPonsel: map["no_ponsel"],
      alamatRumah: map["alamat_rumah"],
      unitDilaporkan: map["unit_dilaporkan"],
      jenisPelanggaran: map["jenis_pelanggaran"],
      deskripsiPelanggaran: map["deskripsi_pelanggaran"],
      lampiran: map["lampiran"],
      deskripsiLampiran: map["deskripsi_lampiran"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "nama_pelapor": namaPelapor, 
      "jenis_laporan": jenisLaporan, 
      "nip_nik": nipNik, 
      "email": email,
      "no_ponsel": noPonsel,
      "alamat_rumah": alamatRumah,
      "unit_dilaporkan": unitDilaporkan,
      "jenis_pelanggaran": jenisPelanggaran,
      "deskripsi_pelanggaran": deskripsiPelanggaran,
      "lampiran": lampiran,
      "deskripsi_lampiran": deskripsiLampiran,
    };
  }

  @override
  String toString() {
    return 'PengaduanModel : {nama_pelapor: $namaPelapor, jenis_laporan: $jenisLaporan, nip_nik: $nipNik, email: $email, no_ponsel: $noPonsel, alamat_rumah: $alamatRumah, unit_dilaporkan: $unitDilaporkan, jenis_pelanggaran: $jenisPelanggaran, deskripsi_pelanggaran: $deskripsiPelanggaran, lampiran: $lampiran, deskripsi_lampiran: $deskripsiLampiran}';
  }

}

List<PengaduanModel> pengaduanFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<PengaduanModel>.from(data.map((item) => PengaduanModel.fromJson(item)));
}
