import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/features/store/presentation/bloc/store_bloc.dart';
import 'package:islamic_app/features/store/presentation/bloc/store_event.dart';
import 'package:islamic_app/features/store/presentation/bloc/store_state.dart';
import 'package:islamic_app/features/store/presentation/pages/halal_finder_page.dart';
import 'package:islamic_app/features/store/presentation/pages/products_page.dart';
import 'package:islamic_app/core/theme/app_theme.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FDF4), // Light green-white background (base-100)
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Search',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937), // text-primary
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xFF1F2937)),
            onPressed: () {
              context.read<StoreBloc>().add(LoadStoreData());
            },
          ),
        ],
      ),
      body: BlocBuilder<StoreBloc, StoreState>(
        builder: (context, state) {
          if (state is StoreLoading) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF0D9488)));
          }

          if (state is StoreError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Color(0xFF4B5563)),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: const TextStyle(color: Color(0xFF1F2937)),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<StoreBloc>().add(LoadStoreData());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _buildModernCard(
                context,
                title: 'Find Mosques',
                description: 'Discover mosques near your location',
                gradientColors: [
                  const Color(0xFF059669), // Emerald 600
                  const Color(0xFF10B981), // Emerald 500
                  const Color(0xFF34D399), // Emerald 400
                  const Color(0xFF6EE7B7), // Emerald 300
                ],
                icon: Icons.mosque,
                onTap: () {
                  // Navigate to mosque finder page
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => const MosquePage()));
                },
              ),
              const SizedBox(height: 24),
              _buildModernCard(
                context,
                title: 'Halal Finder',
                description: 'Locate halal places near you',
                gradientColors: [
                  const Color(0xFF0D9488), // Teal 600
                  const Color(0xFF14B8A6), // Teal 500
                  const Color(0xFF5EEAD4), // Teal 300
                  const Color(0xFFCCFBF1), // Teal 100
                ],
                icon: Icons.location_on_rounded,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HalalFinderPage()),
                  );
                },
              ),
              const SizedBox(height: 24),
              _buildModernCard(
                context,
                title: 'Islamic Products',
                description: 'Shop for Islamic items',
                gradientColors: [
                  const Color(0xFFB45309), // Amber 700
                  const Color(0xFFD97706), // Amber 600
                  const Color(0xFFFBBF24), // Yellow 400
                  const Color(0xFFFEF9C3), // Yellow 100
                ],
                icon: Icons.shopping_bag_rounded,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProductsPage()),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildModernCard(
    BuildContext context, {
    required String title,
    required String description,
    required List<Color> gradientColors,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 175,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColors[0].withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(28),
          child: Padding(
            padding: const EdgeInsets.all(26),
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            description,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 14.5,
                              height: 1.4,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      // Circular action button
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 21,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      icon,
                      size: 85,
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
