import 'package:vici_technical_test/utils/model.dart';

/// create json
// {
//   "id": 1,
//   "nama": "admin",
//   "username": "admin",
//   "password": "admin",
//   "no_hp": "08123456789",
//   "created_at": "2021-09-28T07:59:59.000000Z",
//   "updated_at": "2021-09-28T07:59:59.000000Z"
// }

class UserModel implements BaseModel {
  int? id;
  String? nama;
  String? username;
  String? password;
  String? noHp;
  String? createdAt;
  String? updatedAt;

  UserModel({
    this.id,
    this.nama,
    this.username,
    this.password,
    this.noHp,
    this.createdAt,
    this.updatedAt,
  });

  static UserModel fromJson(Map<String, dynamic>? json) {
    return UserModel(
      id: json!['id'],
      nama: json['nama'],
      username: json['username'],
      password: json['password'],
      noHp: json['no_hp'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['username'] = username;
    data['password'] = password;
    data['no_hp'] = noHp;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  @override
  jsonToModel(Map<String, dynamic> json) {
    return fromJson(json);
  }

  UserModel copyWith({
    int? id,
    String? nama,
    String? username,
    String? password,
    String? noHp,
    String? createdAt,
    String? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      username: username ?? this.username,
      password: password ?? this.password,
      noHp: noHp ?? this.noHp,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
