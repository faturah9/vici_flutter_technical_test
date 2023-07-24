part of 'new_discover_cubit.dart';

class NewDiscoverState {
  final FormzStatus? submitStatus;
  final FormzStatus? addItemStatus;
  final ItemModel? itemModel;
  final List<ItemModel>? listItemModel;
  final List<CartItemModel>? listCartModel;
  final bool? showCardBadge;
  final String? errorMessage;
  final String? successMessage;

  NewDiscoverState({
    this.submitStatus = FormzStatus.pure,
    this.addItemStatus = FormzStatus.pure,
    this.itemModel,
    this.listItemModel,
    this.listCartModel,
    this.showCardBadge = false,
    this.errorMessage,
    this.successMessage,
  });

  NewDiscoverState copyWith({
    FormzStatus? submitStatus,
    FormzStatus? addItemStatus,
    ItemModel? itemModel,
    List<ItemModel>? listItemModel,
    List<CartItemModel>? listCartModel,
    bool? showCardBadge,
    String? errorMessage,
    String? successMessage,
  }) {
    return NewDiscoverState(
      submitStatus: submitStatus ?? this.submitStatus,
      addItemStatus: addItemStatus ?? this.addItemStatus,
      itemModel: itemModel ?? this.itemModel,
      listItemModel: listItemModel ?? this.listItemModel,
      listCartModel: listCartModel ?? this.listCartModel,
      showCardBadge: showCardBadge ?? this.showCardBadge,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }
}

class NewDiscoverInitial extends NewDiscoverState {}

class NewDiscoverLoading extends NewDiscoverState {}

class NewDiscoverBadgesLoading extends NewDiscoverState {}
