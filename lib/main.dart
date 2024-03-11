import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangap/core/services/depedency_container.dart';
import 'package:mangap/fetures/home/presentation/bloc/home_bloc.dart';
import 'package:mangap/fetures/home/presentation/pages/home_page.dart';
import 'package:mangap/fetures/onboard/presentation/pages/onboard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<HomeBloc>(),
          child: const HomePage(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: OnboardScreen(),
      ),
    );
  }
}
