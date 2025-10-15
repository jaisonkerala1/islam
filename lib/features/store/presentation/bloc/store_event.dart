import 'package:equatable/equatable.dart';

abstract class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object?> get props => [];
}

class LoadStoreData extends StoreEvent {}

class SearchHalalPlace extends StoreEvent {
  final String query;

  const SearchHalalPlace(this.query);

  @override
  List<Object?> get props => [query];
}

class AddToCart extends StoreEvent {
  final String productId;

  const AddToCart(this.productId);

  @override
  List<Object?> get props => [productId];
}



