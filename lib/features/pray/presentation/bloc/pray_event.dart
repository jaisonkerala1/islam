import 'package:equatable/equatable.dart';

abstract class PrayEvent extends Equatable {
  const PrayEvent();

  @override
  List<Object?> get props => [];
}

class LoadPrayData extends PrayEvent {}

class IncrementTasbeeh extends PrayEvent {}

class ResetTasbeeh extends PrayEvent {}

class UpdateQiblaDirection extends PrayEvent {
  final double direction;

  const UpdateQiblaDirection(this.direction);

  @override
  List<Object?> get props => [direction];
}



