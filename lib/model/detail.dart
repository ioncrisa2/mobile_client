class Detail {
  int id;
  int userId;
  String namaLengkap;
  int nim;
  String tanggalLahir;
  String tempatLahir;
  String jenisKelamin;
  String alamat;
  String createdAt;
  String updatedAt;

  Detail({
    this.id,
    this.userId,
    this.namaLengkap,
    this.nim,
    this.tanggalLahir,
    this.tempatLahir,
    this.jenisKelamin,
    this.alamat,
    this.createdAt,
    this.updatedAt,
  });

  Detail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    namaLengkap = json['nama_lengkap'];
    nim = json['nim'];
    tanggalLahir = json['tanggal_lahir'];
    tempatLahir = json['tempat_lahir'];
    jenisKelamin = json['jenis_kelamin'];
    alamat = json['alamat'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['nama_lengkap'] = this.namaLengkap;
    data['nim'] = this.nim;
    data['tanggal_lahir'] = this.tanggalLahir;
    data['tempat_lahir'] = this.tempatLahir;
    data['jenis_kelamin'] = this.jenisKelamin;
    data['alamat'] = this.alamat;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
