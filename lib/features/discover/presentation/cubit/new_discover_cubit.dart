import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:vici_technical_test/features/cart/domain/datas/models/cart_item_model.dart';

import '../../../../injection_container.dart';
import '../../../../utils/session_manager.dart';
import '../../domain/datas/models/item_model.dart';
import '../../domain/repository/discover_repository.dart';
import '../../domain/repository_impl/discover_repository_impl.dart';

part 'new_discover_state.dart';

class NewDiscoverCubit extends Cubit<NewDiscoverState> {
  final DiscoverRepository discoverRepository = sl<DiscoverRepositoryImpl>();
  final AppSharedPreferences _prefs = sl<AppSharedPreferencesImpl>();

  NewDiscoverCubit() : super(NewDiscoverInitial());

  Future<void> fetchDiscoverItems() async {
    emit(NewDiscoverLoading());

    try {
      final getData = await discoverRepository.fetchItems();
      await Future.delayed(const Duration(seconds: 2));

      emit(
        state.copyWith(
          listItemModel: getData,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          submitStatus: FormzStatus.submissionFailure,
          errorMessage: "Gagal menambahkan item",
        ),
      );
    }
  }

  Future<void> discoverAddItemsEvent(ItemModel item) async {
    final state = this.state;
    emit(
      state.copyWith(
        itemModel: item,
      ),
    );
    try {
      final userId = _prefs.getUserId();

      final itemModel = await discoverRepository.addItem(item, userId);

      if (itemModel.id != null) {
        final userId = _prefs.getUserId();

        List<CartItemModel>? getData =
            await discoverRepository.fetchBadgesItems(userId);

        emit(
          state.copyWith(
            addItemStatus: FormzStatus.submissionSuccess,
            successMessage: "Berhasil menambahkan item",
            listCartModel: getData,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          addItemStatus: FormzStatus.submissionFailure,
          errorMessage: "Gagal menambahkan item",
        ),
      );
    }
  }

  Future<void> fetchDiscoverBadgesEvent() async {
    emit(NewDiscoverBadgesLoading());

    try {
      final userId = _prefs.getUserId();

      List<CartItemModel>? getData =
          await discoverRepository.fetchBadgesItems(userId);

      await Future.delayed(const Duration(seconds: 2));

      if (getData != null) {
        emit(
          state.copyWith(
            listCartModel: getData,
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
