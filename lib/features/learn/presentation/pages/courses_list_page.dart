import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/features/learn/presentation/bloc/learn_bloc.dart';
import 'package:islamic_app/features/learn/presentation/bloc/learn_state.dart';
import 'package:islamic_app/features/learn/presentation/widgets/courses_card.dart';

class CoursesListPage extends StatelessWidget {
  const CoursesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Islamic Courses'),
      ),
      body: BlocBuilder<LearnBloc, LearnState>(
        builder: (context, state) {
          if (state is LearnLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: CoursesCard(courses: state.courses),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}



