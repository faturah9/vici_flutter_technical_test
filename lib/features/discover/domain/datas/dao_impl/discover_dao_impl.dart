import 'package:sqflite/sqflite.dart';
import 'package:vici_technical_test/features/cart/domain/datas/models/cart_item_model.dart';

import '../../../../../core/database/db_provider.dart';
import '../../../../../injection_container.dart';
import '../dao/discover_dao.dart';

class DiscoverDaoImpl extends DiscoverDao {
  final Database db = sl<Database>();

  @override
  Future<List<CartItemModel>> findCartItemModel(String username) async {
    List<Map<String, Object?>> a = await db
        .rawQuery("select * from $cartTABLE WHERE username = '$username'");

    return a.isNotEmpty ? a.map((e) => CartItemModel.fromJson(e)).toList() : [];
  }
}
