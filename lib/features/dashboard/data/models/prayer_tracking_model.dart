class PrayerTrackingData {
  final String currentTime;
  final String currentPrayer;
  final String location;
  final NextPrayer nextPrayer;
  final bool checkInDone;
  final int starsEarned;
  final List<bool> weeklyStreak;

  PrayerTrackingData({
    required this.currentTime,
    required this.currentPrayer,
    required this.location,
    required this.nextPrayer,
    required this.checkInDone,
    required this.starsEarned,
    required this.weeklyStreak,
  });

  // Mock data for now - easily replaceable with API call
  factory PrayerTrackingData.mock() {
    return PrayerTrackingData(
      currentTime: _getCurrentTime(),
      currentPrayer: "Asr",
      location: "Mangaluru",
      nextPrayer: NextPrayer(
        name: "Maghrib",
        timeRemaining: "13m 12s",
      ),
      checkInDone: true,
      starsEarned: 10,
      weeklyStreak: [true, true, false, true, true, false, true], // T F S S M T W
    );
  }

  static String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : now.hour;
    final period = now.hour >= 12 ? 'pm' : 'am';
    return '${hour == 0 ? 12 : hour}:${now.minute.toString().padLeft(2, '0')} $period';
  }
}

class NextPrayer {
  final String name;
  final String timeRemaining;

  NextPrayer({
    required this.name,
    required this.timeRemaining,
  });
}

class DailyPrayerData {
  final String date;
  final String hijriDate;
  final String location;
  final String imsak;
  final String sunrise;
  final List<Prayer> prayers;
  final int completed;
  final int total;

  DailyPrayerData({
    required this.date,
    required this.hijriDate,
    required this.location,
    required this.imsak,
    required this.sunrise,
    required this.prayers,
    required this.completed,
    required this.total,
  });

  // Mock data - easily replaceable with API
  factory DailyPrayerData.mock() {
    return DailyPrayerData(
      date: "Today, 15 October",
      hijriDate: "23 Rabi' II 1447",
      location: "Mangaluru",
      imsak: "5:10 am",
      sunrise: "6:21 am",
      prayers: [
        Prayer(
          name: "Fajr",
          icon: "✨",
          time: "5:10 am",
          completed: true,
          alarm: true,
          current: false,
          countdown: null,
        ),
        Prayer(
          name: "Dhuhr",
          icon: "☀️",
          time: "12:16 pm",
          completed: true,
          alarm: false,
          current: false,
          countdown: null,
        ),
        Prayer(
          name: "Asr",
          icon: "☁️",
          time: "4:33 pm",
          completed: true,
          alarm: false,
          current: true,
          countdown: null,
        ),
        Prayer(
          name: "Maghrib",
          icon: "🌅",
          time: "6:12 pm",
          completed: false,
          alarm: true,
          current: false,
          countdown: "in 12m 47s",
        ),
        Prayer(
          name: "Isha'a",
          icon: "🌙",
          time: "7:23 pm",
          completed: false,
          alarm: true,
          current: false,
          countdown: null,
        ),
      ],
      completed: 3,
      total: 5,
    );
  }
}

class Prayer {
  final String name;
  final String icon;
  final String time;
  final bool completed;
  final bool alarm;
  final bool current;
  final String? countdown;

  Prayer({
    required this.name,
    required this.icon,
    required this.time,
    required this.completed,
    required this.alarm,
    required this.current,
    this.countdown,
  });
}

class DeenJourneyData {
  final TodayProgress todayProgress;
  final Achievements achievements;

  DeenJourneyData({
    required this.todayProgress,
    required this.achievements,
  });

  // Mock data
  factory DeenJourneyData.mock() {
    return DeenJourneyData(
      todayProgress: TodayProgress(
        prayers: ProgressMetric(completed: 3, total: 5),
        quran: QuranProgress(minutes: 0, goal: 10),
        checkIn: true,
      ),
      achievements: Achievements(
        dailyStreak: 1,
        prayerJourneyDays: 1,
      ),
    );
  }
}

class TodayProgress {
  final ProgressMetric prayers;
  final QuranProgress quran;
  final bool checkIn;

  TodayProgress({
    required this.prayers,
    required this.quran,
    required this.checkIn,
  });
}

class ProgressMetric {
  final int completed;
  final int total;

  ProgressMetric({
    required this.completed,
    required this.total,
  });
}

class QuranProgress {
  final int minutes;
  final int goal;

  QuranProgress({
    required this.minutes,
    required this.goal,
  });
}

class Achievements {
  final int dailyStreak;
  final int prayerJourneyDays;

  Achievements({
    required this.dailyStreak,
    required this.prayerJourneyDays,
  });
}


