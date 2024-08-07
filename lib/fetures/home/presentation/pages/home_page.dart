import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangap/core/common/widget/error.dart';
import 'package:mangap/core/common/widget/loading.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:mangap/fetures/home/presentation/bloc/home_bloc.dart';
import 'package:mangap/fetures/home/presentation/widgets/list_popular_widget.dart';
import 'package:mangap/fetures/home/presentation/widgets/list_recommended_komik_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.kThird,
        title: Text(
          "Mangapp",
          style: GoogleFonts.openSans(
            color: ColorConstant.whiteColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              color: ColorConstant.whiteColor,
            ),
          )
        ],
      ),
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
          child: ListView(
            children: [
              ListRecommendedKomikWidget(
                title: 'Recommended Komik',
                komiks: state.recommendedKomiks,
              ),
              ListPopularWidget(
                title: "Popular Komik",
                komiks: state.popularKomiks,
              )
            ],
          ),
          onRefresh: () async {
            context.read<HomeBloc>().add(HomeRefresh());
          },
        );
      default:
        return const LoadingWidget(textColor: ColorConstant.whiteColor);
    }
  }
}
