import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/features/learn/presentation/bloc/learn_bloc.dart';
import 'package:islamic_app/features/learn/presentation/bloc/learn_event.dart';
import 'package:islamic_app/features/learn/presentation/bloc/learn_state.dart';
import 'package:islamic_app/features/learn/presentation/pages/quran_list_page.dart';
import 'package:islamic_app/features/learn/presentation/pages/courses_list_page.dart';
import 'package:islamic_app/features/learn/presentation/pages/tests_list_page.dart';
import 'package:islamic_app/core/theme/app_theme.dart';

class LearnPage extends StatelessWidget {
  const LearnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FDF4), // Light green-white background (base-100)
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Learn',
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
              context.read<LearnBloc>().add(LoadLearnData());
            },
          ),
        ],
      ),
      body: BlocBuilder<LearnBloc, LearnState>(
        builder: (context, state) {
          if (state is LearnLoading) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF0D9488)));
          }

          if (state is LearnError) {
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
                      context.read<LearnBloc>().add(LoadLearnData());
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
                title: 'Holy Quran',
                description: 'Read and learn the Quran with translations',
                gradientColors: [
                  const Color(0xFF047857), // Emerald 700
                  const Color(0xFF059669), // Emerald 600
                  const Color(0xFF10B981), // Emerald 500
                  const Color(0xFF6EE7B7), // Emerald 300
                ],
                icon: Icons.menu_book_rounded,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QuranListPage()),
                  );
                },
              ),
              const SizedBox(height: 24),
              _buildModernCard(
                context,
                title: 'Islamic Courses',
                description: 'Learn from expert teachers',
                gradientColors: [
                  const Color(0xFFB45309), // Amber 700
                  const Color(0xFFD97706), // Amber 600
                  const Color(0xFFF59E0B), // Amber 500
                  const Color(0xFFFDE68A), // Amber 200
                ],
                icon: Icons.school_rounded,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CoursesListPage()),
                  );
                },
              ),
              const SizedBox(height: 24),
              _buildModernCard(
                context,
                title: 'Test Predictions',
                description: 'Test your Islamic knowledge',
                gradientColors: [
                  const Color(0xFF0891B2), // Cyan 600
                  const Color(0xFF06B6D4), // Cyan 500
                  const Color(0xFF22D3EE), // Cyan 400
                  const Color(0xFFA5F3FC), // Cyan 200
                ],
                icon: Icons.quiz_rounded,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TestsListPage()),
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
