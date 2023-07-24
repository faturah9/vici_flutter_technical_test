import 'package:vici_technical_test/features/cart/domain/datas/models/process_item_model.dart';

import '../../../../injection_container.dart';
import '../datas/dao/cart_dao.dart';
import '../datas/dao_impl/cart_dao_impl.dart';
import '../datas/models/cart_item_model.dart';
import '../repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartDao cartDao = sl<CartDaoImpl>();

  @override
  Future<List<CartItemModel>> fetchCardItems(String? username) async {
    return await cartDao.findCartItemModel(username!);
  }

  @override
  Future<List<ProcessItemModel>> fetchProcessCardItems(String? username) async {
    return await cartDao.findProcessCardItems(username!);
  }
}
