import '../../../../../utils/model.dart';

///create jsons

// {
//   "id": 1,
// "username": "admin",
// "nama_product": "jagung",
// "foto_product": "asdasdwaeasdwaDWA"
// "harga_product": 10000,
// "quantity": 1,
// "created_at": "2021-09-28T07:59:59.000000Z",
// "updated_at": "2021-09-28T07:59:59.000000Z"
// }

class CartItemModel implements BaseModel {
  int? id;
  String? username;
  String? namaProduct;
  String? fotoProduct;
  int? hargaProduct;
  int? quantity;
  String? createdAt;
  String? updatedAt;

  CartItemModel(
      {this.id,
      this.username,
      this.namaProduct,
      this.fotoProduct,
      this.hargaProduct,
      this.quantity,
      this.createdAt,
      this.updatedAt});

  static CartItemModel fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      username: json['username'],
      namaProduct: json['nama_product'],
      fotoProduct: json['foto_product'],
      hargaProduct: json['harga_product'],
      quantity: json['quantity'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['nama_product'] = namaProduct;
    data['foto_product'] = fotoProduct;
    data['harga_product'] = hargaProduct;
    data['quantity'] = quantity;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  @override
  jsonToModel(Map<String, dynamic> json) {
    return fromJson(json);
  }

  CartItemModel copyWith({
    int? id,
    String? username,
    String? namaProduct,
    String? fotoProduct,
    int? hargaProduct,
    int? quantity,
    String? createdAt,
    String? updatedAt,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      username: username ?? this.username,
      namaProduct: namaProduct ?? this.namaProduct,
      fotoProduct: fotoProduct ?? this.fotoProduct,
      hargaProduct: hargaProduct ?? this.hargaProduct,
      quantity: quantity ?? this.quantity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
