import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class LoadDashboardData extends DashboardEvent {}

class PlayAudio extends DashboardEvent {
  final String audioId;

  const PlayAudio(this.audioId);

  @override
  List<Object?> get props => [audioId];
}

class PlayVideo extends DashboardEvent {
  final String videoId;

  const PlayVideo(this.videoId);

  @override
  List<Object?> get props => [videoId];
}



