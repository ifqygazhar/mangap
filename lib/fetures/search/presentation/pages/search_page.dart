import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangap/core/common/widget/appbar.dart';
import 'package:mangap/core/common/widget/error.dart';
import 'package:mangap/core/common/widget/komik_card.dart';
import 'package:mangap/core/common/widget/loading.dart';
import 'package:mangap/core/common/widget/rating.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:mangap/fetures/detail/presentation/pages/detail_page.dart';
import 'package:mangap/fetures/main/bloc/navigation_bloc.dart';
import 'package:mangap/fetures/search/presentation/bloc/search_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final searchBloc = context.read<SearchBloc>();
    searchController.text = searchBloc.state.searchText;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(
        title: "Search",
      ),
      backgroundColor: ColorConstant.kPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildInputSearch(searchController, context),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state.status == SearchStatus.success) {
                      if (state.searchKomik.isNotEmpty) {
                        return _buildSearchResult(state);
                      } else {
                        return ErrorWidgetComponent(
                          errorMessage: "Tidak Ada Hasil Tersebut",
                          onTap: () {
                            context.read<SearchBloc>().add(
                                  SearchGetKomik(searchController.text),
                                );
                          },
                        );
                      }
                    } else if (state.status == SearchStatus.error) {
                      return ErrorWidgetComponent(
                        errorMessage: state.errorMessage,
                        onTap: () {
                          context.read<SearchBloc>().add(
                                SearchGetKomik(searchController.text),
                              );
                        },
                      );
                    }
                    return const LoadingWidget(
                      textColor: ColorConstant.whiteColor,
                      image: 'assets/images/keyword.gif',
                      text: 'Cari Komik Dulu...',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _buildSearchResult(SearchState state) {
    return SizedBox(
      height: 420,
      child: ListView.builder(
        itemCount: state.searchKomik.length,
        itemBuilder: (context, index) {
          final komik = state.searchKomik[index];
          return GestureDetector(
            onTap: () async {
              context.read<NavigationBloc>().add(HideBottomBarEvent());
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
      ),
    );
  }

  Container _buildInputSearch(
      TextEditingController searchController, BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorConstant.kThird,
      ),
      child: TextField(
        controller: searchController,
        style: GoogleFonts.openSans(
          color: ColorConstant.whiteColor,
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        cursorColor: ColorConstant.whiteColor,
        decoration: const InputDecoration(
          hintText: 'Cari Komik...',
          hintStyle: TextStyle(
            fontSize: 14.8,
            color: ColorConstant.lightText,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: ColorConstant.lightText,
          ),
          filled: true,
          fillColor: Colors.transparent,
          border: InputBorder.none,
        ),
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            context.read<SearchBloc>().add(
                  SearchGetKomik(value),
                );
          }
        },
      ),
    );
  }
}
