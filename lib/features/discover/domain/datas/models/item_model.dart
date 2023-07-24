class ItemModel {
  String? name;
  int? price;
  String? description;
  String? imageUrl;

  ItemModel({this.name, this.price, this.description, this.imageUrl});

  ItemModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    description = json['description'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    data['description'] = description;
    data['image_url'] = imageUrl;
    return data;
  }
}
