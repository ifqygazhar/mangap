import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mangap/core/common/widget/appbar.dart';
import 'package:mangap/core/common/widget/error.dart';
import 'package:mangap/core/common/widget/loading.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:mangap/fetures/genre/domain/entities/genre_detail_entity.dart';
import 'package:mangap/fetures/genre/presentation/widgets/komik_genre_card_widget.dart';
import 'package:mangap/fetures/genre/presentation/bloc/genre_detail_bloc.dart';

class GenrePage extends StatefulWidget {
  const GenrePage({super.key, required this.href, required this.title});

  final String href;
  final String title;

  @override
  State<GenrePage> createState() => _GenrePageState();

  String get cleanTitle {
    return title.split('(').first.trim();
  }
}

class _GenrePageState extends State<GenrePage> {
  final PagingController<int, KomikGenreDetailDataEntity> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      context
          .read<GenreDetailBloc>()
          .add(GenreDetailGetPage(widget.href, pageKey));
      context
          .read<GenreDetailBloc>()
          .add(GenreDetailGetDataGenre(widget.href, pageKey));
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pagingController.refresh();
    context.read<GenreDetailBloc>().add(GenreDetailReset());
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  void _refresh() {
    _pagingController.refresh();
    context.read<GenreDetailBloc>().add(GenreDetailReset());
    context.read<GenreDetailBloc>().add(GenreDetailGetPage(widget.href, 1));
    context
        .read<GenreDetailBloc>()
        .add(GenreDetailGetDataGenre(widget.href, 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: widget.cleanTitle),
      backgroundColor: ColorConstant.kPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocListener<GenreDetailBloc, GenreDetailState>(
            listener: (context, state) {
              if (state.status == GenreStatus.success) {
                final existingIds = _pagingController.itemList
                        ?.map((komik) => komik.href)
                        .toSet() ??
                    {};
                final newKomiks = state.genreKomiks
                    .where((komik) => !existingIds.contains(komik.href))
                    .toList();

                if (state.hasReachedMax) {
                  log(state.hasReachedMax.toString());
                  _pagingController.appendLastPage(newKomiks);
                } else {
                  final nextPageKey = state.pageKomiks.current_page + 1;
                  _pagingController.appendPage(newKomiks, nextPageKey);
                }
              } else if (state.status == GenreStatus.error) {
                Center(
                  child: ErrorWidgetComponent(
                    errorMessage: state.errorMessage,
                    onTap: () {
                      context.read<GenreDetailBloc>().add(GenreDetailReset());
                      context
                          .read<GenreDetailBloc>()
                          .add(GenreDetailGetPage(widget.href, 1));
                      context
                          .read<GenreDetailBloc>()
                          .add(GenreDetailGetDataGenre(widget.href, 1));
                    },
                  ),
                );
                _pagingController.error = state.errorMessage;
              }
            },
            child: PagedListView<int, KomikGenreDetailDataEntity>(
              pagingController: _pagingController,
              builderDelegate:
                  PagedChildBuilderDelegate<KomikGenreDetailDataEntity>(
                itemBuilder: (context, komik, index) {
                  String formattedRate = komik.rating == "?"
                      ? "0.00"
                      : komik.rating.replaceAll(',', '.');
                  double rating = double.tryParse(formattedRate) ?? 0.00;
                  return KomikGenreCardWidget(
                    title: komik.title,
                    chapter: komik.chapter,
                    href: komik.href,
                    rate: rating.toString(),
                    type: komik.type,
                    thumbnail: komik.thumbnail,
                  );
                },
                firstPageProgressIndicatorBuilder: (context) => const Center(
                  child: LoadingWidget(textColor: ColorConstant.whiteColor),
                ),
                newPageProgressIndicatorBuilder: (context) => const Center(
                  child: LoadingWidget(
                      widthImage: 132,
                      heightImage: 132,
                      textSize: 14,
                      textColor: ColorConstant.whiteColor),
                ),
                noItemsFoundIndicatorBuilder: (context) => Center(
                  child: ErrorWidgetComponent(
                    widthImage: 132,
                    heightImage: 132,
                    textSize: 14,
                    errorMessage: "No Data Available",
                    onTap: () {
                      _refresh();
                    },
                  ),
                ),
                firstPageErrorIndicatorBuilder: (context) => Center(
                  child: ErrorWidgetComponent(
                    errorMessage: "Error Load Data",
                    onTap: () {
                      _refresh();
                    },
                  ),
                ),
                newPageErrorIndicatorBuilder: (context) => Center(
                  child: ErrorWidgetComponent(
                      widthImage: 132,
                      heightImage: 132,
                      textSize: 14,
                      errorMessage: "Error Load More Data",
                      onTap: () {
                        _refresh();
                      }),
                ),
                noMoreItemsIndicatorBuilder: (context) => Center(
                  child: ErrorWidgetComponent(
                    widthImage: 132,
                    heightImage: 132,
                    textSize: 14,
                    textButton: "Back",
                    errorMessage: "All data has been loaded",
                    onTap: () => Navigator.pop(context),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
