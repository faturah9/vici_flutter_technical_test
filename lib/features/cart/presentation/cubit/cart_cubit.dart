import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:vici_technical_test/features/cart/domain/datas/models/process_item_model.dart';

import '../../../../injection_container.dart';
import '../../../../utils/session_manager.dart';
import '../../../discover/domain/datas/models/item_model.dart';
import '../../domain/datas/models/cart_item_model.dart';
import '../../domain/repository/cart_repository.dart';
import '../../domain/repository_impl/cart_repository_impl.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository cartRepository = sl<CartRepositoryImpl>();

  final AppSharedPreferences _prefs = sl<AppSharedPreferencesImpl>();

  CartCubit() : super(CartInitial());

  Future<void> fetchCardListEvent() async {
    emit(CartLoading());

    try {
      final userId = _prefs.getUserId();

      List<ProcessItemModel>? getData =
      await cartRepository.fetchProcessCardItems(userId);

      await Future.delayed(const Duration(seconds: 2));

      if (getData != null) {
        emit(
          state.copyWith(
            listProcessCartModel: getData,
            showCardBadge: true,
          ),
        );
      } else {
        emit(
          state.copyWith(
            showCardBadge: false,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          submitStatus: FormzStatus.submissionFailure,
          errorMessage: "Gagal menambahkan item",
        ),
      );
    }
  }

}
