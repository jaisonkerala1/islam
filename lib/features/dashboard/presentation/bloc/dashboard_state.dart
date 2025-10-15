import 'package:equatable/equatable.dart';

class PrayerTime {
  final String name;
  final String time;
  final bool isNext;

  const PrayerTime({
    required this.name,
    required this.time,
    required this.isNext,
  });
}

class AudioItem {
  final String id;
  final String title;
  final String reciter;
  final String duration;

  const AudioItem({
    required this.id,
    required this.title,
    required this.reciter,
    required this.duration,
  });
}

class VideoItem {
  final String id;
  final String title;
  final String speaker;
  final String duration;

  const VideoItem({
    required this.id,
    required this.title,
    required this.speaker,
    required this.duration,
  });
}

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<PrayerTime> prayerTimes;
  final List<AudioItem> audioItems;
  final List<VideoItem> videoItems;

  const DashboardLoaded({
    required this.prayerTimes,
    required this.audioItems,
    required this.videoItems,
  });

  @override
  List<Object?> get props => [prayerTimes, audioItems, videoItems];
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message);

  @override
  List<Object?> get props => [message];
}



