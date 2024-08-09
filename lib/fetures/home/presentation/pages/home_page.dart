import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mangap/core/common/widget/appbar.dart';
import 'package:mangap/core/common/widget/button.dart';
import 'package:mangap/core/common/widget/error.dart';
import 'package:mangap/core/common/widget/loading.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:mangap/fetures/genre/presentation/pages/genre_page.dart';
import 'package:mangap/fetures/home/presentation/bloc/home_bloc.dart';
import 'package:mangap/fetures/home/presentation/widgets/list_popular_widget.dart';
import 'package:mangap/fetures/home/presentation/widgets/list_recommended_komik_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(
        title: "Mangapp",
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              color: ColorConstant.whiteColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: FaIcon(
              FontAwesomeIcons.circleInfo,
              color: ColorConstant.whiteColor,
            ),
          ),
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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                ListRecommendedKomikWidget(
                  title: 'Recommended Komik',
                  komiks: state.recommendedKomiks,
                ),
                const SizedBox(
                  height: 14,
                ),
                ListPopularWidget(
                  title: "Popular Komik",
                  komiks: state.popularKomiks,
                ),
                const SizedBox(
                  height: 14,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ButtonWidget(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const GenrePage(),
                      ),
                    ),
                    color: ColorConstant.kThird,
                    text: "Genre List",
                    circular: 8,
                    foregroundColor: ColorConstant.whiteColor,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
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
