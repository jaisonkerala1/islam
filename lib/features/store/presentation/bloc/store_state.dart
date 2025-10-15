import 'package:equatable/equatable.dart';

class HalalPlace {
  final String id;
  final String name;
  final String type;
  final String address;
  final double rating;
  final String distance;

  const HalalPlace({
    required this.id,
    required this.name,
    required this.type,
    required this.address,
    required this.rating,
    required this.distance,
  });
}

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String imageUrl;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
  });
}

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object?> get props => [];
}

class StoreInitial extends StoreState {}

class StoreLoading extends StoreState {}

class StoreLoaded extends StoreState {
  final List<HalalPlace> halalPlaces;
  final List<Product> products;

  const StoreLoaded({
    required this.halalPlaces,
    required this.products,
  });

  @override
  List<Object?> get props => [halalPlaces, products];
}

class StoreError extends StoreState {
  final String message;

  const StoreError(this.message);

  @override
  List<Object?> get props => [message];
}



