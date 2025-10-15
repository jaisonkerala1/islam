import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/features/pray/presentation/bloc/pray_bloc.dart';
import 'package:islamic_app/features/pray/presentation/bloc/pray_state.dart';
import 'package:islamic_app/features/pray/presentation/widgets/tasbeeh_card.dart';

class TasbeehPage extends StatelessWidget {
  const TasbeehPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasbeeh Counter'),
      ),
      body: BlocBuilder<PrayBloc, PrayState>(
        builder: (context, state) {
          if (state is PrayLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: TasbeehCard(count: state.tasbeehCount),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}



