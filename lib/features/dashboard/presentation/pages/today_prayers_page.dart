import 'package:flutter/material.dart';
import 'package:islamic_app/features/dashboard/data/models/prayer_tracking_model.dart';
import 'package:islamic_app/core/widgets/circular_progress_painter.dart';

class TodayPrayersPage extends StatelessWidget {
  const TodayPrayersPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data - replace with BLoC later
    final dailyPrayer = DailyPrayerData.mock();

    return Scaffold(
      backgroundColor: const Color(0xFFF0FDF4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D9488),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Today\'s Prayers',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today, color: Colors.white),
            onPressed: () {
              // Open calendar to view other days
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF0D9488),
                    const Color(0xFF14B8A6),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dailyPrayer.date,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dailyPrayer.hijriDate,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.white, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        dailyPrayer.location,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Progress Summary
            _buildProgressSummary(dailyPrayer),
            const SizedBox(height: 24),

            // Special Times (Imsak & Sunrise)
            Row(
              children: [
                Expanded(
                  child: _buildSpecialTimeCard(
                    icon: Icons.wb_twilight,
                    label: 'Imsak',
                    time: dailyPrayer.imsak,
                    color: const Color(0xFF8B5CF6),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSpecialTimeCard(
                    icon: Icons.wb_sunny,
                    label: 'Sunrise',
                    time: dailyPrayer.sunrise,
                    color: const Color(0xFFF59E0B),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Prayer Times List
            const Text(
              'Prayer Times',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 16),
            _buildDailyPrayerProgress(dailyPrayer),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressSummary(DailyPrayerData data) {
    final percentage = data.completed / data.total;

    return Container(
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
      child: Row(
        children: [
          // Progress Circle
          SizedBox(
            width: 100,
            height: 100,
            child: CustomPaint(
              painter: CircularProgressPainter(
                percentage: percentage,
                strokeWidth: 10,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${data.completed}/${data.total}',
                      style: const TextStyle(
                        color: Color(0xFF1F2937),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'prayed',
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Today\'s Progress',
                  style: TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${data.completed} out of ${data.total} prayers completed',
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: percentage,
                  backgroundColor: const Color(0xFFF3F4F6),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF10B981)),
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialTimeCard({
    required IconData icon,
    required String label,
    required String time,
    required Color color,
  }) {
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
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: const TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyPrayerProgress(DailyPrayerData data) {
    return Container(
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
        children: data.prayers.map((prayer) {
          final index = data.prayers.indexOf(prayer);
          final isLast = index == data.prayers.length - 1;
          
          return _buildPrayerRow(prayer, isLast);
        }).toList(),
      ),
    );
  }

  Widget _buildPrayerRow(Prayer prayer, bool isLast) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        border: isLast ? null : const Border(
          bottom: BorderSide(
            color: Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Prayer Icon
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: prayer.current 
                  ? const Color(0xFF0D9488).withOpacity(0.1)
                  : prayer.completed
                      ? const Color(0xFF10B981).withOpacity(0.1)
                      : const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                prayer.icon,
                style: const TextStyle(fontSize: 28),
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // Prayer Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      prayer.name,
                      style: TextStyle(
                        color: const Color(0xFF1F2937),
                        fontSize: 18,
                        fontWeight: prayer.current ? FontWeight.bold : FontWeight.w600,
                      ),
                    ),
                    if (prayer.current) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D9488),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Now',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      prayer.time,
                      style: TextStyle(
                        color: prayer.current ? const Color(0xFF0D9488) : const Color(0xFF4B5563),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (prayer.countdown != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        prayer.countdown!,
                        style: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          
          // Status Icon
          if (prayer.completed)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: Color(0xFF10B981),
                size: 24,
              ),
            )
          else if (prayer.alarm)
            IconButton(
              icon: Icon(
                Icons.notifications_outlined,
                color: Colors.grey.shade400,
                size: 24,
              ),
              onPressed: () {
                // Toggle alarm
              },
            )
          else
            IconButton(
              icon: Icon(
                Icons.notifications_off_outlined,
                color: Colors.grey.shade300,
                size: 24,
              ),
              onPressed: () {
                // Toggle alarm
              },
            ),
        ],
      ),
    );
  }
}

