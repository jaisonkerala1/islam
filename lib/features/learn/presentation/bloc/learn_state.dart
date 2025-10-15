import 'package:equatable/equatable.dart';

class Surah {
  final String id;
  final int number;
  final String name;
  final String arabicName;
  final String translation;
  final int verses;
  final String revelation;

  const Surah({
    required this.id,
    required this.number,
    required this.name,
    required this.arabicName,
    required this.translation,
    required this.verses,
    required this.revelation,
  });
}

class Course {
  final String id;
  final String title;
  final String description;
  final String instructor;
  final int lessons;
  final String level;
  final String duration;

  const Course({
    required this.id,
    required this.title,
    required this.description,
    required this.instructor,
    required this.lessons,
    required this.level,
    required this.duration,
  });
}

class TestPrediction {
  final String id;
  final String topic;
  final String description;
  final int questions;
  final String difficulty;

  const TestPrediction({
    required this.id,
    required this.topic,
    required this.description,
    required this.questions,
    required this.difficulty,
  });
}

abstract class LearnState extends Equatable {
  const LearnState();

  @override
  List<Object?> get props => [];
}

class LearnInitial extends LearnState {}

class LearnLoading extends LearnState {}

class LearnLoaded extends LearnState {
  final List<Surah> surahs;
  final List<Course> courses;
  final List<TestPrediction> testPredictions;

  const LearnLoaded({
    required this.surahs,
    required this.courses,
    required this.testPredictions,
  });

  @override
  List<Object?> get props => [surahs, courses, testPredictions];
}

class LearnError extends LearnState {
  final String message;

  const LearnError(this.message);

  @override
  List<Object?> get props => [message];
}



