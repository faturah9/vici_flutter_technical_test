part of 'cart_cubit.dart';

class CartState {
  final FormzStatus? submitStatus;
  final FormzStatus? addItemStatus;
  final List<CartItemModel>? listCartModel;
  final List<ProcessItemModel>? listProcessCartModel;
  final bool? showCardBadge;
  final String? errorMessage;
  final String? successMessage;

  CartState({
    this.submitStatus = FormzStatus.pure,
    this.addItemStatus = FormzStatus.pure,
    this.listCartModel,
    this.listProcessCartModel,
    this.showCardBadge = false,
    this.errorMessage,
    this.successMessage,
  });

  CartState copyWith({
    FormzStatus? submitStatus,
    FormzStatus? addItemStatus,
    List<CartItemModel>? listCartModel,
    List<ProcessItemModel>? listProcessCartModel,
    bool? showCardBadge,
    String? errorMessage,
    String? successMessage,
  }) {
    return CartState(
      submitStatus: submitStatus ?? this.submitStatus,
      addItemStatus: addItemStatus ?? this.addItemStatus,
      listCartModel: listCartModel ?? this.listCartModel,
      listProcessCartModel: listProcessCartModel ?? this.listProcessCartModel,
      showCardBadge: showCardBadge ?? this.showCardBadge,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}
