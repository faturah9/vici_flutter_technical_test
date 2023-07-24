import '../../../../../core/database/dao.dart';
import '../../../../../core/database/db_provider.dart';
import '../models/cart_item_model.dart';
import '../models/process_item_model.dart';

abstract class CartDao extends BaseDao<CartItemModel> {
  CartDao() : super(cartTABLE);

  Future<List<CartItemModel>> findCartItemModel(String username);

  Future<List<ProcessItemModel>> findProcessCardItems(String username);
}
