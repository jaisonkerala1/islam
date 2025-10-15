import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/features/community/presentation/bloc/community_bloc.dart';
import 'package:islamic_app/features/community/presentation/bloc/community_event.dart';
import 'package:islamic_app/features/community/presentation/bloc/community_state.dart';
import 'package:islamic_app/features/community/presentation/pages/discussions_page.dart';
import 'package:islamic_app/features/community/presentation/pages/charity_page.dart';
import 'package:islamic_app/features/community/presentation/pages/articles_page.dart';
import 'package:islamic_app/core/theme/app_theme.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FDF4), // Light green-white background (base-100)
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Community',
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
              context.read<CommunityBloc>().add(LoadCommunityData());
            },
          ),
        ],
      ),
      body: BlocBuilder<CommunityBloc, CommunityState>(
        builder: (context, state) {
          if (state is CommunityLoading) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF0D9488)));
          }

          if (state is CommunityError) {
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
                      context.read<CommunityBloc>().add(LoadCommunityData());
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
                title: 'Discussions',
                description: 'Engage with the Muslim community',
                gradientColors: [
                  const Color(0xFF0E7490), // Cyan 700
                  const Color(0xFF0891B2), // Cyan 600
                  const Color(0xFF06B6D4), // Cyan 500
                  const Color(0xFF67E8F9), // Cyan 300
                ],
                icon: Icons.forum_rounded,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DiscussionsPage()),
                  );
                },
              ),
              const SizedBox(height: 24),
              _buildModernCard(
                context,
                title: 'Charity',
                description: 'Support various Islamic causes',
                gradientColors: [
                  const Color(0xFFEA580C), // Orange 600
                  const Color(0xFFF59E0B), // Amber 500
                  const Color(0xFFFBBF24), // Yellow 400
                  const Color(0xFFFEF08A), // Yellow 200
                ],
                icon: Icons.volunteer_activism_rounded,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CharityPage()),
                  );
                },
              ),
              const SizedBox(height: 24),
              _buildModernCard(
                context,
                title: 'Articles',
                description: 'Read insightful Islamic content',
                gradientColors: [
                  const Color(0xFF047857), // Emerald 700
                  const Color(0xFF059669), // Emerald 600
                  const Color(0xFF10B981), // Emerald 500
                  const Color(0xFFA7F3D0), // Emerald 200
                ],
                icon: Icons.article_rounded,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ArticlesPage()),
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
