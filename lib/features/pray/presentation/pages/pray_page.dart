import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/features/pray/presentation/bloc/pray_bloc.dart';
import 'package:islamic_app/features/pray/presentation/bloc/pray_event.dart';
import 'package:islamic_app/features/pray/presentation/bloc/pray_state.dart';
import 'package:islamic_app/features/pray/presentation/pages/duas_page.dart';
import 'package:islamic_app/features/pray/presentation/pages/qibla_page.dart';
import 'package:islamic_app/features/pray/presentation/pages/tasbeeh_page.dart';
import 'package:islamic_app/core/theme/app_theme.dart';

class PrayPage extends StatelessWidget {
  const PrayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FDF4), // Light green-white background (base-100)
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Pray',
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
              context.read<PrayBloc>().add(LoadPrayData());
            },
          ),
        ],
      ),
      body: BlocBuilder<PrayBloc, PrayState>(
        builder: (context, state) {
          if (state is PrayLoading) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF0D9488)));
          }

          if (state is PrayError) {
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
                      context.read<PrayBloc>().add(LoadPrayData());
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
                title: 'Daily Duas',
                description: 'Essential prayers for daily life',
                gradientColors: [
                  const Color(0xFF0D9488), // Deep teal
                  const Color(0xFF059669), // Emerald
                  const Color(0xFF10B981), // Green
                  const Color(0xFF34D399), // Light green
                ],
                icon: Icons.menu_book_rounded,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DuasPage()),
                  );
                },
              ),
              const SizedBox(height: 24),
              _buildModernCard(
                context,
                title: 'Qibla Finder',
                description: 'Find direction to Mecca',
                gradientColors: [
                  const Color(0xFFD97706), // Dark amber
                  const Color(0xFFF59E0B), // Amber
                  const Color(0xFFFBBF24), // Yellow
                  const Color(0xFFFDE047), // Light yellow
                ],
                icon: Icons.explore_rounded,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QiblaPage()),
                  );
                },
              ),
              const SizedBox(height: 24),
              _buildModernCard(
                context,
                title: 'Tasbeeh Counter',
                description: 'Digital dhikr counter',
                gradientColors: [
                  const Color(0xFF0891B2), // Cyan
                  const Color(0xFF14B8A6), // Teal
                  const Color(0xFF2DD4BF), // Light teal
                  const Color(0xFF5EEAD4), // Very light teal
                ],
                icon: Icons.circle_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TasbeehPage()),
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
