import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:islamic_app/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:islamic_app/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:islamic_app/features/dashboard/data/models/prayer_tracking_model.dart';
import 'package:islamic_app/features/dashboard/presentation/pages/today_prayers_page.dart';
import 'package:islamic_app/core/widgets/circular_progress_painter.dart';
import 'package:islamic_app/core/theme/app_theme.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final timeOfDay = now.hour;
    String greeting = timeOfDay < 12 ? 'Good Morning' : (timeOfDay < 17 ? 'Good Afternoon' : 'Good Evening');
    
    return Scaffold(
      backgroundColor: const Color(0xFFF0FDF4),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF0D9488)));
          }

          if (state is DashboardError) {
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
                      context.read<DashboardBloc>().add(LoadDashboardData());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

           if (state is DashboardLoaded) {
             // Mock data - replace with API later
             final prayerTracking = PrayerTrackingData.mock();
             final deenJourney = DeenJourneyData.mock();
             
             return CustomScrollView(
               slivers: [
                 // Custom App Bar with Islamic greeting
                 SliverAppBar(
                   expandedHeight: 200,
                   floating: false,
                   pinned: true,
                   backgroundColor: const Color(0xFF0D9488),
                   flexibleSpace: FlexibleSpaceBar(
                     background: Container(
                       decoration: BoxDecoration(
                         gradient: LinearGradient(
                           begin: Alignment.topLeft,
                           end: Alignment.bottomRight,
                           colors: [
                             const Color(0xFF0D9488),
                             const Color(0xFF14B8A6),
                             const Color(0xFF2DD4BF),
                           ],
                         ),
                       ),
                       child: SafeArea(
                         child: Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text(
                                         'السلام عليكم',
                                         style: TextStyle(
                                           color: Colors.white.withOpacity(0.9),
                                           fontSize: 18,
                                           fontWeight: FontWeight.w500,
                                         ),
                                       ),
                                       const SizedBox(height: 4),
                                       Text(
                                         greeting,
                                         style: const TextStyle(
                                           color: Colors.white,
                                           fontSize: 28,
                                           fontWeight: FontWeight.bold,
                                         ),
                                       ),
                                     ],
                                   ),
                                   GestureDetector(
                                     onTap: () {
                                       // Navigate to profile page
                                       // Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
                                     },
                                     child: Container(
                                       width: 56,
                                       height: 56,
                                       decoration: BoxDecoration(
                                         color: Colors.white.withOpacity(0.2),
                                         borderRadius: BorderRadius.circular(16),
                                         border: Border.all(
                                           color: Colors.white.withOpacity(0.3),
                                           width: 2,
                                         ),
                                       ),
                                       child: ClipRRect(
                                         borderRadius: BorderRadius.circular(14),
                                         child: Container(
                                           color: Colors.white.withOpacity(0.1),
                                           child: const Icon(
                                             Icons.person,
                                             color: Colors.white,
                                             size: 28,
                                           ),
                                         ),
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                               const Spacer(),
                               Container(
                                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                 decoration: BoxDecoration(
                                   color: Colors.white.withOpacity(0.2),
                                   borderRadius: BorderRadius.circular(20),
                                 ),
                                 child: Row(
                                   mainAxisSize: MainAxisSize.min,
                                   children: [
                                     const Icon(Icons.calendar_today, color: Colors.white, size: 16),
                                     const SizedBox(width: 8),
                                     Text(
                                       DateFormat('EEEE, MMM d, yyyy').format(now),
                                       style: const TextStyle(
                                         color: Colors.white,
                                         fontSize: 13,
                                         fontWeight: FontWeight.w600,
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                             ],
                           ),
                         ),
                       ),
                     ),
                   ),
                 ),
                 
                 // Dashboard Content
                 SliverToBoxAdapter(
                   child: Padding(
                     padding: const EdgeInsets.all(20),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         // Prayer Tracking Widgets
                         _buildPrayerTrackingWidgets(context, prayerTracking),
                         const SizedBox(height: 24),
                         
                         // Deen Journey Section
                         const Text(
                           'Your Deen Journey',
                           style: TextStyle(
                             fontSize: 20,
                             fontWeight: FontWeight.bold,
                             color: Color(0xFF1F2937),
                           ),
                         ),
                         const SizedBox(height: 16),
                         _buildDeenJourneySection(deenJourney),
                         const SizedBox(height: 24),
                         
                         // Quick Access
                         const Text(
                           'Quick Access',
                           style: TextStyle(
                             fontSize: 20,
                             fontWeight: FontWeight.bold,
                             color: Color(0xFF1F2937),
                           ),
                         ),
                         const SizedBox(height: 16),
                         _buildQuickAccessGrid(),
                       ],
                     ),
                   ),
                 ),
               ],
             );
           }

          return const SizedBox();
        },
      ),
    );
  }

  // Prayer Tracking Widgets
  Widget _buildPrayerTrackingWidgets(BuildContext context, PrayerTrackingData data) {
    return Column(
      children: [
        Row(
          children: [
            // Current Prayer Card - Make it tappable
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TodayPrayersPage()),
                  );
                },
                child: _buildCurrentPrayerCard(data),
              ),
            ),
            const SizedBox(width: 12),
            // Check-in Card
            Expanded(
              flex: 2,
              child: _buildCheckInCard(data),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Weekly Streak
        _buildWeeklyStreak(data.weeklyStreak),
      ],
    );
  }

  Widget _buildCurrentPrayerCard(PrayerTrackingData data) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0A2F2F),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.cloud, color: Colors.white70, size: 20),
              const SizedBox(width: 8),
              Text(
                data.location,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              const Text('🇮🇳', style: TextStyle(fontSize: 14)),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            data.currentTime,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            data.currentPrayer,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF14B8A6).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${data.nextPrayer.name} in ${data.nextPrayer.timeRemaining}',
              style: const TextStyle(
                color: Color(0xFF5EEAD4),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckInCard(PrayerTrackingData data) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0A2F2F),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF84CC16),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Check in done! ✨',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            '${data.starsEarned} Stars earned',
            style: TextStyle(
              color: const Color(0xFFFBBF24),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyStreak(List<bool> streak) {
    const days = ['T', 'F', 'S', 'S', 'M', 'T', 'W'];
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(7, (index) {
          final isToday = index == 6; // W is today
          final isCompleted = streak[index];
          
          return Column(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isCompleted ? const Color(0xFF10B981) : const Color(0xFFF3F4F6),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: isToday 
                    ? const Text('🔥', style: TextStyle(fontSize: 16))
                    : Text(
                        days[index],
                        style: TextStyle(
                          color: isCompleted ? Colors.white : const Color(0xFF9CA3AF),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                ),
              ),
              if (isToday) ...[
                const SizedBox(height: 4),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D9488),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      'W',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          );
        }),
      ),
    );
  }

  // Deen Journey Section
  Widget _buildDeenJourneySection(DeenJourneyData data) {
    return Column(
      children: [
        // Today's Progress Card
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              const Text(
                'Today\'s Progress',
                style: TextStyle(
                  color: Color(0xFF1F2937),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildProgressMetric(
                    icon: Icons.mosque,
                    label: 'Prayers',
                    value: '${data.todayProgress.prayers.completed}/${data.todayProgress.prayers.total}',
                    color: const Color(0xFF10B981),
                  ),
                  _buildProgressMetric(
                    icon: Icons.menu_book,
                    label: 'Quran',
                    value: '${data.todayProgress.quran.minutes}/${data.todayProgress.quran.goal} mins',
                    color: const Color(0xFF0D9488),
                  ),
                  _buildProgressMetric(
                    icon: Icons.check_circle,
                    label: 'Check in',
                    value: data.todayProgress.checkIn ? 'Done' : 'Pending',
                    color: const Color(0xFF84CC16),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Achievements
        Row(
          children: [
            Expanded(
              child: _buildAchievementCard(
                title: 'I\'m on a ${data.achievements.dailyStreak}-day streak!',
                emoji: '🔥',
                color: const Color(0xFF10B981),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildAchievementCard(
                title: 'I\'m on a ${data.achievements.prayerJourneyDays}-day Prayer journey',
                emoji: '📗',
                color: const Color(0xFF059669),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProgressMetric({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementCard({
    required String title,
    required String emoji,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color,
            color.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 32),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.share, color: Colors.white, size: 14),
                SizedBox(width: 4),
                Text(
                  'Share',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccessGrid() {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _buildQuickAccessItem(Icons.menu_book, 'Quran', const Color(0xFF059669)),
        _buildQuickAccessItem(Icons.mosque, 'Qibla', const Color(0xFF0D9488)),
        _buildQuickAccessItem(Icons.favorite, 'Duas', const Color(0xFFDC2626)),
        _buildQuickAccessItem(Icons.circle_outlined, 'Tasbeeh', const Color(0xFFF59E0B)),
      ],
    );
  }

  Widget _buildQuickAccessItem(IconData icon, String label, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF4B5563),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
