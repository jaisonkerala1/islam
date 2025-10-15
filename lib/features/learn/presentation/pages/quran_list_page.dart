import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/features/learn/presentation/bloc/learn_bloc.dart';
import 'package:islamic_app/features/learn/presentation/bloc/learn_state.dart';
import 'package:islamic_app/features/learn/presentation/widgets/quran_card.dart';

class QuranListPage extends StatelessWidget {
  const QuranListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Holy Quran'),
      ),
      body: BlocBuilder<LearnBloc, LearnState>(
        builder: (context, state) {
          if (state is LearnLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: QuranCard(surahs: state.surahs),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}



