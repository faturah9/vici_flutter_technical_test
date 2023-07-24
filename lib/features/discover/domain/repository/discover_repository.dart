import 'package:vici_technical_test/features/discover/domain/datas/models/item_model.dart';

import '../../../cart/domain/datas/models/cart_item_model.dart';

abstract class DiscoverRepository {
  Future<CartItemModel> addItem(
    ItemModel? itemModel, String? userId,
  );

  Future<List<ItemModel>>fetchItems();

  fetchBadgesItems(String? username);
}
