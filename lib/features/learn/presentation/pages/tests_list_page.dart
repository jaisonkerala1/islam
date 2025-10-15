import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/features/learn/presentation/bloc/learn_bloc.dart';
import 'package:islamic_app/features/learn/presentation/bloc/learn_state.dart';
import 'package:islamic_app/features/learn/presentation/widgets/test_predictions_card.dart';

class TestsListPage extends StatelessWidget {
  const TestsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Predictions'),
      ),
      body: BlocBuilder<LearnBloc, LearnState>(
        builder: (context, state) {
          if (state is LearnLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: TestPredictionsCard(testPredictions: state.testPredictions),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}



