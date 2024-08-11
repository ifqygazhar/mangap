import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mangap/core/common/widget/appbar.dart';
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
                ErrorWidget(state.errorMessage);
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
                firstPageProgressIndicatorBuilder: (context) =>
                    const Center(child: CircularProgressIndicator()),
                newPageProgressIndicatorBuilder: (context) =>
                    const Center(child: CircularProgressIndicator()),
                noItemsFoundIndicatorBuilder: (context) =>
                    const Center(child: Text('No Data Available')),
                firstPageErrorIndicatorBuilder: (context) =>
                    const Center(child: Text('Error loading data')),
                newPageErrorIndicatorBuilder: (context) =>
                    const Center(child: Text('Error loading more data')),
                noMoreItemsIndicatorBuilder: (context) =>
                    const Center(child: Text('All Data Has Been Loaded')),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
