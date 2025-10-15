import 'package:equatable/equatable.dart';

class Dua {
  final String id;
  final String title;
  final String arabicText;
  final String translation;
  final String transliteration;

  const Dua({
    required this.id,
    required this.title,
    required this.arabicText,
    required this.translation,
    required this.transliteration,
  });
}

abstract class PrayState extends Equatable {
  const PrayState();

  @override
  List<Object?> get props => [];
}

class PrayInitial extends PrayState {}

class PrayLoading extends PrayState {}

class PrayLoaded extends PrayState {
  final List<Dua> duas;
  final int tasbeehCount;
  final double qiblaDirection;

  const PrayLoaded({
    required this.duas,
    required this.tasbeehCount,
    required this.qiblaDirection,
  });

  @override
  List<Object?> get props => [duas, tasbeehCount, qiblaDirection];

  PrayLoaded copyWith({
    List<Dua>? duas,
    int? tasbeehCount,
    double? qiblaDirection,
  }) {
    return PrayLoaded(
      duas: duas ?? this.duas,
      tasbeehCount: tasbeehCount ?? this.tasbeehCount,
      qiblaDirection: qiblaDirection ?? this.qiblaDirection,
    );
  }
}

class PrayError extends PrayState {
  final String message;

  const PrayError(this.message);

  @override
  List<Object?> get props => [message];
}



