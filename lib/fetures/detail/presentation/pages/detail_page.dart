import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangap/core/common/widget/appbar.dart';
import 'package:mangap/core/common/widget/error.dart';
import 'package:mangap/core/common/widget/loading.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:mangap/fetures/detail/presentation/bloc/detail_bloc.dart';
import 'package:mangap/fetures/detail/presentation/widgets/komik_chapter_widget.dart';
import 'package:mangap/fetures/detail/presentation/widgets/komik_description_widget.dart';
import 'package:mangap/fetures/detail/presentation/widgets/komik_genre_widget.dart';
import 'package:mangap/fetures/detail/presentation/widgets/list_komik_detail_widget.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.href});
  final String href;

  @override
  Widget build(BuildContext context) {
    context.read<DetailBloc>().add(DetailRefresh(href));

    return Scaffold(
      backgroundColor: ColorConstant.kPrimary,
      appBar: const AppbarWidget(
        title: "Detail",
      ),
      body: SafeArea(
        child: BlocBuilder<DetailBloc, DetailState>(
          builder: (context, state) {
            return _buildContent(context, state, href);
          },
        ),
      ),
    );
  }
}

Widget _buildContent(BuildContext context, DetailState state, String href) {
  switch (state.status) {
    case DetailStatus.loading:
      return const LoadingWidget(textColor: ColorConstant.whiteColor);
    case DetailStatus.error:
      return ErrorWidgetComponent(
        errorMessage: state.errorMessage,
        onTap: () => context.read<DetailBloc>().add(
              DetailRefresh(href),
            ),
      );
    case DetailStatus.success:
      return RefreshIndicator(
        backgroundColor: ColorConstant.whiteColor,
        color: ColorConstant.kThird,
        onRefresh: () async {
          context.read<DetailBloc>().add(DetailRefresh(href));
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              ListKomikDetailWidget(
                details: state.details,
                genres: state.genres,
              ),
              const SizedBox(
                height: 14,
              ),
              KomikGenreWidget(genres: state.genres),
              const SizedBox(
                height: 14,
              ),
              KomikDescriptionWidget(
                description: state.details.description == "-"
                    ? "Not have description"
                    : state.details.description,
              ),
              const SizedBox(
                height: 14,
              ),
              KomikChapterWidget(chapters: state.chapters),
            ],
          ),
        ),
      );
    default:
      return const LoadingWidget(textColor: ColorConstant.whiteColor);
  }
}
