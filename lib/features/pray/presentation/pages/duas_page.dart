import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/features/pray/presentation/bloc/pray_bloc.dart';
import 'package:islamic_app/features/pray/presentation/bloc/pray_state.dart';
import 'package:islamic_app/features/pray/presentation/widgets/duas_card.dart';

class DuasPage extends StatelessWidget {
  const DuasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Duas'),
      ),
      body: BlocBuilder<PrayBloc, PrayState>(
        builder: (context, state) {
          if (state is PrayLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: DuasCard(duas: state.duas),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}



