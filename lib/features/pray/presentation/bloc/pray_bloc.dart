import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/features/pray/presentation/bloc/pray_event.dart';
import 'package:islamic_app/features/pray/presentation/bloc/pray_state.dart';

class PrayBloc extends Bloc<PrayEvent, PrayState> {
  PrayBloc() : super(PrayInitial()) {
    on<LoadPrayData>(_onLoadPrayData);
    on<IncrementTasbeeh>(_onIncrementTasbeeh);
    on<ResetTasbeeh>(_onResetTasbeeh);
    on<UpdateQiblaDirection>(_onUpdateQiblaDirection);
  }

  Future<void> _onLoadPrayData(
    LoadPrayData event,
    Emitter<PrayState> emit,
  ) async {
    emit(PrayLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));

      // Mock Duas data
      final duas = [
        const Dua(
          id: '1',
          title: 'Morning Dua',
          arabicText: 'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ',
          translation: 'We have entered a new day and the whole kingdom belongs to Allah',
          transliteration: 'Asbahnaa wa asbahal mulku lillah',
        ),
        const Dua(
          id: '2',
          title: 'Before Eating',
          arabicText: 'بِسْمِ اللَّهِ',
          translation: 'In the name of Allah',
          transliteration: 'Bismillah',
        ),
        const Dua(
          id: '3',
          title: 'After Eating',
          arabicText: 'الْحَمْدُ لِلَّهِ الَّذِي أَطْعَمَنَا وَسَقَانَا',
          translation: 'Praise be to Allah who has fed us and given us drink',
          transliteration: 'Alhamdulillahil-ladhi at\'amana wa saqana',
        ),
        const Dua(
          id: '4',
          title: 'Before Sleeping',
          arabicText: 'بِاسْمِكَ اللَّهُمَّ أَمُوتُ وَأَحْيَا',
          translation: 'In Your name, O Allah, I die and I live',
          transliteration: 'Bismika Allahumma amootu wa ahya',
        ),
        const Dua(
          id: '5',
          title: 'Upon Waking',
          arabicText: 'الْحَمْدُ لِلَّهِ الَّذِي أَحْيَانَا بَعْدَ مَا أَمَاتَنَا',
          translation: 'Praise is to Allah who gave us life after death',
          transliteration: 'Alhamdulillahil-ladhi ahyana ba\'da ma amatana',
        ),
      ];

      emit(PrayLoaded(
        duas: duas,
        tasbeehCount: 0,
        qiblaDirection: 0.0,
      ));
    } catch (e) {
      emit(PrayError('Failed to load pray data: ${e.toString()}'));
    }
  }

  void _onIncrementTasbeeh(
    IncrementTasbeeh event,
    Emitter<PrayState> emit,
  ) {
    if (state is PrayLoaded) {
      final currentState = state as PrayLoaded;
      emit(currentState.copyWith(
        tasbeehCount: currentState.tasbeehCount + 1,
      ));
    }
  }

  void _onResetTasbeeh(
    ResetTasbeeh event,
    Emitter<PrayState> emit,
  ) {
    if (state is PrayLoaded) {
      final currentState = state as PrayLoaded;
      emit(currentState.copyWith(tasbeehCount: 0));
    }
  }

  void _onUpdateQiblaDirection(
    UpdateQiblaDirection event,
    Emitter<PrayState> emit,
  ) {
    if (state is PrayLoaded) {
      final currentState = state as PrayLoaded;
      emit(currentState.copyWith(qiblaDirection: event.direction));
    }
  }
}



