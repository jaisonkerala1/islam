import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:islamic_app/features/dashboard/presentation/bloc/dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<LoadDashboardData>(_onLoadDashboardData);
    on<PlayAudio>(_onPlayAudio);
    on<PlayVideo>(_onPlayVideo);
  }

  Future<void> _onLoadDashboardData(
    LoadDashboardData event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));

      // Mock Prayer Times
      final prayerTimes = [
        const PrayerTime(name: 'Fajr', time: '5:30 AM', isNext: false),
        const PrayerTime(name: 'Dhuhr', time: '12:45 PM', isNext: true),
        const PrayerTime(name: 'Asr', time: '4:15 PM', isNext: false),
        const PrayerTime(name: 'Maghrib', time: '6:30 PM', isNext: false),
        const PrayerTime(name: 'Isha', time: '8:00 PM', isNext: false),
      ];

      // Mock Audio Items
      final audioItems = [
        const AudioItem(
          id: '1',
          title: 'Surah Al-Baqarah',
          reciter: 'Sheikh Mishary Rashid',
          duration: '45:32',
        ),
        const AudioItem(
          id: '2',
          title: 'Surah Ar-Rahman',
          reciter: 'Sheikh Abdul Basit',
          duration: '12:15',
        ),
        const AudioItem(
          id: '3',
          title: 'Surah Yasin',
          reciter: 'Sheikh Sudais',
          duration: '18:20',
        ),
      ];

      // Mock Video Items
      final videoItems = [
        const VideoItem(
          id: '1',
          title: 'The Pillars of Islam',
          speaker: 'Sheikh Yasir Qadhi',
          duration: '25:45',
        ),
        const VideoItem(
          id: '2',
          title: 'Understanding Tawheed',
          speaker: 'Dr. Bilal Philips',
          duration: '32:10',
        ),
        const VideoItem(
          id: '3',
          title: 'Stories of the Prophets',
          speaker: 'Mufti Menk',
          duration: '42:30',
        ),
      ];

      emit(DashboardLoaded(
        prayerTimes: prayerTimes,
        audioItems: audioItems,
        videoItems: videoItems,
      ));
    } catch (e) {
      emit(DashboardError('Failed to load dashboard data: ${e.toString()}'));
    }
  }

  void _onPlayAudio(
    PlayAudio event,
    Emitter<DashboardState> emit,
  ) {
    // Handle audio playback
  }

  void _onPlayVideo(
    PlayVideo event,
    Emitter<DashboardState> emit,
  ) {
    // Handle video playback
  }
}



