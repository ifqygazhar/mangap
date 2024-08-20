import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mangap/core/common/widget/appbar.dart';
import 'package:mangap/core/common/widget/error.dart';
import 'package:mangap/core/common/widget/komik_card.dart';
import 'package:mangap/core/common/widget/loading.dart';
import 'package:mangap/core/common/widget/rating.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:mangap/fetures/detail/presentation/pages/detail_page.dart';
import 'package:mangap/fetures/main/bloc/navigation_bloc.dart';
import 'package:mangap/fetures/manga/domain/entities/manga_entity.dart';
import 'package:mangap/fetures/manga/presentation/bloc/manga_bloc.dart';
import 'package:mangap/fetures/search/presentation/pages/search_page.dart';

class MangaPage extends StatefulWidget {
  const MangaPage({super.key});

  @override
  State<MangaPage> createState() => _MangaPageState();
}

class _MangaPageState extends State<MangaPage> {
  final PagingController<int, MangaEntity> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      context.read<MangaBloc>().add(MangaReset());
      context.read<MangaBloc>().add(Manga(pageKey));
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pagingController.refresh();
    context.read<MangaBloc>().add(MangaReset());
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  void _refresh() {
    _pagingController.refresh();
    context.read<MangaBloc>().add(MangaReset());
    context.read<MangaBloc>().add(const Manga(1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.kPrimary,
      appBar: AppbarWidget(
        title: "Mangapp",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: GestureDetector(
              onTap: () async {
                context.read<NavigationBloc>().add(HideBottomBarEvent());
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SearchPage(),
                  ),
                );
                context.read<NavigationBloc>().add(ShowBottomBarEvent());
              },
              child: const FaIcon(
                FontAwesomeIcons.magnifyingGlass,
                color: ColorConstant.whiteColor,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: FaIcon(
              FontAwesomeIcons.circleInfo,
              color: ColorConstant.whiteColor,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: RefreshIndicator(
            backgroundColor: ColorConstant.whiteColor,
            color: ColorConstant.kThird,
            onRefresh: () async {
              _refresh();
            },
            child: BlocListener<MangaBloc, MangaState>(
              listener: (context, state) {
                if (state.status == MangaStatus.success) {
                  final existingIds = _pagingController.itemList
                          ?.map((komik) => komik.href)
                          .toSet() ??
                      {};
                  final newKomiks = state.manga
                      .where((komik) => !existingIds.contains(komik.href))
                      .toList();

                  if (state.hasReachedMax) {
                    _pagingController.appendLastPage(newKomiks);
                  } else {
                    final nextPageKey =
                        (_pagingController.nextPageKey ?? 1) + 1;
                    _pagingController.appendPage(newKomiks, nextPageKey);
                  }
                } else if (state.status == MangaStatus.error) {
                  ErrorWidgetComponent(
                    errorMessage: state.errorMessage,
                    onTap: () {
                      _refresh();
                    },
                  );

                  _pagingController.error = state.errorMessage;
                }
              },
              child: PagedListView<int, MangaEntity>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<MangaEntity>(
                  itemBuilder: (context, komik, index) {
                    return GestureDetector(
                      onTap: () async {
                        context
                            .read<NavigationBloc>()
                            .add(HideBottomBarEvent());
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              href: komik.href,
                            ),
                          ),
                        );
                      },
                      child: KomikCardWidget(
                        title: komik.title,
                        status: komik.chapter,
                        href: komik.href,
                        rate: fixedRating(komik.rating),
                        type: komik.type,
                        thumbnail: komik.thumbnail,
                      ),
                    );
                  },
                  firstPageProgressIndicatorBuilder: (context) =>
                      const LoadingWidget(textColor: ColorConstant.whiteColor),
                  newPageProgressIndicatorBuilder: (context) =>
                      const LoadingWidget(
                    widthImage: 132,
                    heightImage: 132,
                    textSize: 14,
                    textColor: ColorConstant.whiteColor,
                  ),
                  noItemsFoundIndicatorBuilder: (context) =>
                      ErrorWidgetComponent(
                    widthImage: 132,
                    heightImage: 132,
                    textSize: 14,
                    errorMessage: "Tidak Ada Komik Coba Lagi!",
                    onTap: () {
                      _refresh();
                    },
                  ),
                  firstPageErrorIndicatorBuilder: (context) =>
                      ErrorWidgetComponent(
                    errorMessage: "Gagal Memuat Komik",
                    onTap: () {
                      _refresh();
                    },
                  ),
                  newPageErrorIndicatorBuilder: (context) =>
                      ErrorWidgetComponent(
                    widthImage: 132,
                    heightImage: 132,
                    textSize: 14,
                    errorMessage: "Gagal Memuat Lebih Banyak Komik",
                    onTap: () {
                      _refresh();
                    },
                  ),
                  noMoreItemsIndicatorBuilder: (context) =>
                      ErrorWidgetComponent(
                    widthImage: 132,
                    heightImage: 132,
                    textSize: 14,
                    textButton: "Kembali",
                    errorMessage: "Semua Komik Sudah Ditampilkan",
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
