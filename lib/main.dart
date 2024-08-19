import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangap/core/services/depedency_container.dart';
import 'package:mangap/fetures/detail/presentation/bloc/detail_bloc.dart';
import 'package:mangap/fetures/genre/presentation/bloc/genre_detail_bloc.dart';
import 'package:mangap/fetures/home/presentation/bloc/home_bloc.dart';
import 'package:mangap/fetures/main/bloc/navigation_bloc.dart';
import 'package:mangap/fetures/main/main_page.dart';
import 'package:mangap/fetures/manga/presentation/bloc/manga_bloc.dart';
import 'package:mangap/fetures/onboard/presentation/pages/onboard.dart';
import 'package:mangap/fetures/read/presentation/bloc/read_bloc.dart';
import 'package:mangap/fetures/search/presentation/bloc/search_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  final sharedPreferences = await SharedPreferences.getInstance();
  final bool hasSeenOnboarding =
      sharedPreferences.getBool('hasSeenOnboarding') ?? false;
  runApp(MyApp(
    hasSeenOnboarding: hasSeenOnboarding,
  ));
}

class MyApp extends StatelessWidget {
  final bool hasSeenOnboarding;

  const MyApp({super.key, required this.hasSeenOnboarding});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<NavigationBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<HomeBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<DetailBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<GenreDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<MangaBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<SearchBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<ReadBloc>(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: hasSeenOnboarding ? MainPage() : const OnboardScreen(),
      ),
    );
  }
}
