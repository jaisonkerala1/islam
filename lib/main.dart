import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/core/theme/app_theme.dart';
import 'package:islamic_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:islamic_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:islamic_app/features/auth/presentation/pages/auth_page.dart';
import 'package:islamic_app/features/pray/presentation/bloc/pray_bloc.dart';
import 'package:islamic_app/features/pray/presentation/bloc/pray_event.dart';
import 'package:islamic_app/features/learn/presentation/bloc/learn_bloc.dart';
import 'package:islamic_app/features/learn/presentation/bloc/learn_event.dart';
import 'package:islamic_app/features/community/presentation/bloc/community_bloc.dart';
import 'package:islamic_app/features/community/presentation/bloc/community_event.dart';
import 'package:islamic_app/features/store/presentation/bloc/store_bloc.dart';
import 'package:islamic_app/features/store/presentation/bloc/store_event.dart';
import 'package:islamic_app/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:islamic_app/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:islamic_app/features/home/presentation/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const IslamicApp());
}

class IslamicApp extends StatelessWidget {
  const IslamicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => PrayBloc()..add(LoadPrayData())),
        BlocProvider(create: (context) => LearnBloc()..add(LoadLearnData())),
        BlocProvider(create: (context) => CommunityBloc()..add(LoadCommunityData())),
        BlocProvider(create: (context) => StoreBloc()..add(LoadStoreData())),
        BlocProvider(create: (context) => DashboardBloc()..add(LoadDashboardData())),
      ],
      child: MaterialApp(
        title: 'Islamic App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return const HomePage();
            }
            return const AuthPage();
          },
        ),
      ),
    );
  }
}

