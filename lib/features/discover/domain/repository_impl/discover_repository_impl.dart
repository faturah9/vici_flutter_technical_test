import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:vici_technical_test/features/cart/domain/datas/models/cart_item_model.dart';
import 'package:vici_technical_test/features/discover/domain/datas/models/item_model.dart';

import '../../../../injection_container.dart';
import '../datas/dao/discover_dao.dart';
import '../datas/dao_impl/discover_dao_impl.dart';
import '../repository/discover_repository.dart';

class DiscoverRepositoryImpl implements DiscoverRepository {
  final DiscoverDao discoverDao = sl<DiscoverDaoImpl>();

  @override
  Future<CartItemModel> addItem(ItemModel? itemModel, String? userId) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    CartItemModel cartItemModel = CartItemModel(
      namaProduct: itemModel!.name,
      fotoProduct: itemModel.imageUrl,
      hargaProduct: itemModel.price,
      quantity: 1,
      username: userId,
      createdAt: formattedDate,
      updatedAt: formattedDate,
    );

    int? cartItemModelId = await discoverDao.upsert(cartItemModel);
    cartItemModel.id = cartItemModelId;
    return cartItemModel;
  }

  @override
  Future<List<ItemModel>> fetchItems() async {
    final String response =
        await rootBundle.loadString('assets/jsons/item.json');
    List<dynamic> jsonData = json.decode(response);
    List<ItemModel> products =
        jsonData.map((item) => ItemModel.fromJson(item)).toList();
    return products;
  }

  @override
  Future<List<CartItemModel>> fetchBadgesItems(String? username) async {
    return await discoverDao.findCartItemModel(username!);
  }
}
