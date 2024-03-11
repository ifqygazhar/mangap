import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:mangap/fetures/home/presentation/bloc/home_bloc.dart';
import 'package:mangap/fetures/home/presentation/widgets/list_komik_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeBloc>(context).add(HomeGetPopularKomik());
    BlocProvider.of<HomeBloc>(context).add(HomeGetLatestKomik());

    return Scaffold(
      backgroundColor: kPrimary,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return _buildContent(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, HomeState state) {
    switch (state.status) {
      case HomeStatus.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case HomeStatus.error:
        return Center(
          child: Text(
            state.errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
        );
      case HomeStatus.success:
        final popularKomiks = state.popularKomiks;
        final latestKomiks = state.latestKomiks;

        return ListView(children: [
          ListKomikWidget(title: 'Popular Komik', komiks: popularKomiks),
          ListKomikWidget(title: 'Latest Komik', komiks: latestKomiks),
        ]);
      default:
        return Container(); // Menangani kasus default
    }
  }
}
