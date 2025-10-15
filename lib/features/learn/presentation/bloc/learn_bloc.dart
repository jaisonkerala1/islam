import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/features/learn/presentation/bloc/learn_event.dart';
import 'package:islamic_app/features/learn/presentation/bloc/learn_state.dart';

class LearnBloc extends Bloc<LearnEvent, LearnState> {
  LearnBloc() : super(LearnInitial()) {
    on<LoadLearnData>(_onLoadLearnData);
    on<SelectSurah>(_onSelectSurah);
    on<EnrollCourse>(_onEnrollCourse);
  }

  Future<void> _onLoadLearnData(
    LoadLearnData event,
    Emitter<LearnState> emit,
  ) async {
    emit(LearnLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));

      // Mock Surah data
      final surahs = [
        const Surah(
          id: '1',
          number: 1,
          name: 'Al-Fatihah',
          arabicName: 'الفاتحة',
          translation: 'The Opening',
          verses: 7,
          revelation: 'Meccan',
        ),
        const Surah(
          id: '2',
          number: 2,
          name: 'Al-Baqarah',
          arabicName: 'البقرة',
          translation: 'The Cow',
          verses: 286,
          revelation: 'Medinan',
        ),
        const Surah(
          id: '3',
          number: 3,
          name: 'Aali Imran',
          arabicName: 'آل عمران',
          translation: 'The Family of Imran',
          verses: 200,
          revelation: 'Medinan',
        ),
        const Surah(
          id: '112',
          number: 112,
          name: 'Al-Ikhlas',
          arabicName: 'الإخلاص',
          translation: 'The Sincerity',
          verses: 4,
          revelation: 'Meccan',
        ),
      ];

      // Mock Course data
      final courses = [
        const Course(
          id: '1',
          title: 'Tajweed Basics',
          description: 'Learn the fundamental rules of Quranic recitation',
          instructor: 'Sheikh Ahmed',
          lessons: 12,
          level: 'Beginner',
          duration: '6 weeks',
        ),
        const Course(
          id: '2',
          title: 'Islamic History',
          description: 'Comprehensive overview of Islamic civilization',
          instructor: 'Dr. Fatima',
          lessons: 20,
          level: 'Intermediate',
          duration: '10 weeks',
        ),
        const Course(
          id: '3',
          title: 'Arabic Language',
          description: 'Master Quranic Arabic step by step',
          instructor: 'Ustadh Yusuf',
          lessons: 24,
          level: 'Beginner',
          duration: '12 weeks',
        ),
      ];

      // Mock Test Predictions
      final testPredictions = [
        const TestPrediction(
          id: '1',
          topic: 'Pillars of Islam',
          description: 'Test your knowledge of the five pillars',
          questions: 20,
          difficulty: 'Easy',
        ),
        const TestPrediction(
          id: '2',
          topic: 'Prophets in Islam',
          description: 'Learn about the messengers of Allah',
          questions: 25,
          difficulty: 'Medium',
        ),
        const TestPrediction(
          id: '3',
          topic: 'Quranic Knowledge',
          description: 'Advanced questions about Quran',
          questions: 30,
          difficulty: 'Hard',
        ),
      ];

      emit(LearnLoaded(
        surahs: surahs,
        courses: courses,
        testPredictions: testPredictions,
      ));
    } catch (e) {
      emit(LearnError('Failed to load learn data: ${e.toString()}'));
    }
  }

  void _onSelectSurah(
    SelectSurah event,
    Emitter<LearnState> emit,
  ) {
    // Handle surah selection
  }

  void _onEnrollCourse(
    EnrollCourse event,
    Emitter<LearnState> emit,
  ) {
    // Handle course enrollment
  }
}



