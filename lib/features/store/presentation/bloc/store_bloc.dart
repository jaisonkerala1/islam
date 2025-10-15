import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/features/store/presentation/bloc/store_event.dart';
import 'package:islamic_app/features/store/presentation/bloc/store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(StoreInitial()) {
    on<LoadStoreData>(_onLoadStoreData);
    on<SearchHalalPlace>(_onSearchHalalPlace);
    on<AddToCart>(_onAddToCart);
  }

  Future<void> _onLoadStoreData(
    LoadStoreData event,
    Emitter<StoreState> emit,
  ) async {
    emit(StoreLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));

      // Mock Halal Places
      final halalPlaces = [
        const HalalPlace(
          id: '1',
          name: 'Al-Salam Restaurant',
          type: 'Restaurant',
          address: '123 Main Street, City',
          rating: 4.5,
          distance: '0.5 km',
        ),
        const HalalPlace(
          id: '2',
          name: 'Halal Mart',
          type: 'Grocery',
          address: '456 Oak Avenue, City',
          rating: 4.8,
          distance: '1.2 km',
        ),
        const HalalPlace(
          id: '3',
          name: 'Barakah Butcher',
          type: 'Butcher',
          address: '789 Elm Street, City',
          rating: 4.7,
          distance: '2.0 km',
        ),
      ];

      // Mock Products
      final products = [
        const Product(
          id: '1',
          name: 'Prayer Mat',
          description: 'Premium quality prayer mat with compass',
          price: 29.99,
          category: 'Prayer Items',
          imageUrl: '',
        ),
        const Product(
          id: '2',
          name: 'Quran - English Translation',
          description: 'Beautiful hardcover Quran with English translation',
          price: 39.99,
          category: 'Books',
          imageUrl: '',
        ),
        const Product(
          id: '3',
          name: 'Miswak Stick',
          description: 'Natural teeth cleaning stick',
          price: 4.99,
          category: 'Personal Care',
          imageUrl: '',
        ),
        const Product(
          id: '4',
          name: 'Islamic Wall Art',
          description: 'Beautiful calligraphy wall decoration',
          price: 49.99,
          category: 'Home Decor',
          imageUrl: '',
        ),
        const Product(
          id: '5',
          name: 'Tasbeeh Counter',
          description: 'Digital prayer counter with LED display',
          price: 14.99,
          category: 'Prayer Items',
          imageUrl: '',
        ),
        const Product(
          id: '6',
          name: 'Hijab Collection',
          description: 'Premium quality hijab in various colors',
          price: 19.99,
          category: 'Clothing',
          imageUrl: '',
        ),
      ];

      emit(StoreLoaded(
        halalPlaces: halalPlaces,
        products: products,
      ));
    } catch (e) {
      emit(StoreError('Failed to load store data: ${e.toString()}'));
    }
  }

  void _onSearchHalalPlace(
    SearchHalalPlace event,
    Emitter<StoreState> emit,
  ) {
    // Handle halal place search
  }

  void _onAddToCart(
    AddToCart event,
    Emitter<StoreState> emit,
  ) {
    // Handle add to cart
  }
}



