import 'package:vici_technical_test/core/database/dao.dart';
import 'package:vici_technical_test/features/cart/domain/datas/models/cart_item_model.dart';

import '../../../../../core/database/db_provider.dart';

abstract class DiscoverDao extends BaseDao<CartItemModel> {
  DiscoverDao() : super(cartTABLE);

Future<List<CartItemModel>> findCartItemModel(String username);
}
