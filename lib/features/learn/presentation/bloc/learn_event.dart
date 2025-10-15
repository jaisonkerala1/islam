import 'package:equatable/equatable.dart';

abstract class LearnEvent extends Equatable {
  const LearnEvent();

  @override
  List<Object?> get props => [];
}

class LoadLearnData extends LearnEvent {}

class SelectSurah extends LearnEvent {
  final String surahId;

  const SelectSurah(this.surahId);

  @override
  List<Object?> get props => [surahId];
}

class EnrollCourse extends LearnEvent {
  final String courseId;

  const EnrollCourse(this.courseId);

  @override
  List<Object?> get props => [courseId];
}



