import 'package:sqflite/sqflite.dart';
import 'package:vici_technical_test/features/cart/domain/datas/dao/cart_dao.dart';
import 'package:vici_technical_test/features/cart/domain/datas/models/cart_item_model.dart';
import 'package:vici_technical_test/features/cart/domain/datas/models/process_item_model.dart';

import '../../../../../core/database/db_provider.dart';
import '../../../../../injection_container.dart';

class CartDaoImpl extends CartDao {
  final Database db = sl<Database>();

  @override
  Future<List<CartItemModel>> findCartItemModel(String username) async {
    List<Map<String, Object?>> a = await db
        .rawQuery("select * from $cartTABLE WHERE username = '$username'");

    return a.isNotEmpty ? a.map((e) => CartItemModel.fromJson(e)).toList() : [];
  }

  @override
  Future<List<ProcessItemModel>> findProcessCardItems(String username) async {
    List<Map<String, Object?>> a = await db.rawQuery(
        "SELECT nama_product, COUNT(quantity) AS quantity_count, SUM(harga_product) AS price_count, foto_product FROM $cartTABLE WHERE username = '$username' GROUP BY nama_product");

    return a.isNotEmpty
        ? a.map((e) => ProcessItemModel.fromJson(e)).toList()
        : [];
  }
}
