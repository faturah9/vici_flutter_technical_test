import 'package:vici_technical_test/utils/model.dart';

class ProcessItemModel implements BaseModel {
  String? namaProduct;
  int? quantityCount;
  int? priceCount;
  String? fotoProduct;

  ProcessItemModel(
      {this.namaProduct,
      this.quantityCount,
      this.priceCount,
      this.fotoProduct});

  static ProcessItemModel fromJson(Map<String, dynamic> json) {
    return ProcessItemModel(
      namaProduct: json['nama_product'],
      quantityCount: json['quantity_count'],
      priceCount: json['price_count'],
      fotoProduct: json['foto_product'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nama_product'] = namaProduct;
    data['quantity_count'] = quantityCount;
    data['price_count'] = priceCount;
    data['foto_product'] = fotoProduct;
    return data;
  }

  @override
  jsonToModel(Map<String, dynamic> json) {
    return fromJson(json);
  }

  ProcessItemModel copyWith({
    String? namaProduct,
    int? quantityCount,
    int? priceCount,
    String? fotoProduct,
  }) {
    return ProcessItemModel(
      namaProduct: namaProduct ?? this.namaProduct,
      quantityCount: quantityCount ?? this.quantityCount,
      priceCount: priceCount ?? this.priceCount,
      fotoProduct: fotoProduct ?? this.fotoProduct,
    );
  }
}
