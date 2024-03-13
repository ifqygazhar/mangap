import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangap/core/common/widget/error.dart';
import 'package:mangap/core/common/widget/loading.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:mangap/fetures/home/presentation/bloc/home_bloc.dart';
import 'package:mangap/fetures/home/presentation/widgets/list_komik_update.dart';
import 'package:mangap/fetures/home/presentation/widgets/list_komik_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeBloc>(context).add(HomeGetPopularKomik());
    BlocProvider.of<HomeBloc>(context).add(const HomeGetUpdateKomik(page: "1"));

    return Scaffold(
      backgroundColor: ColorConstant.kPrimary,
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
        return const LoadingWidget(textColor: ColorConstant.whiteColor);
      case HomeStatus.error:
        return ErrorWidgetComponent(
          errorMessage: state.errorMessage,
          onTap: () => context.read<HomeBloc>().add(
                HomeRefresh(),
              ),
        );
      case HomeStatus.success:
        return RefreshIndicator(
          backgroundColor: ColorConstant.whiteColor,
          color: ColorConstant.kThird,
          onRefresh: () async {
            context.read<HomeBloc>().add(HomeRefresh());
          },
          child: ListView(
            children: [
              ListKomikWidget(
                title: 'Popular Komik',
                komiks: state.popularKomiks,
              ),
              ListKomikUpdate(
                title: 'Chapter Terbaru',
                komiks: state.updateKomiks,
              ),
            ],
          ),
        );
      default:
        return Container(); // Menangani kasus default
    }
  }
}
