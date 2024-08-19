import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangap/core/common/widget/appbar.dart';
import 'package:mangap/core/common/widget/error.dart';
import 'package:mangap/core/common/widget/komik_card.dart';
import 'package:mangap/core/common/widget/loading.dart';
import 'package:mangap/core/common/widget/rating.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:mangap/fetures/detail/presentation/bloc/detail_bloc.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<DetailBloc>().add(const DetailGetBookmarks());

    return Scaffold(
      backgroundColor: ColorConstant.kPrimary,
      appBar: const AppbarWidget(
        title: "Bookmarks",
      ),
      body: SafeArea(
        child: BlocBuilder<DetailBloc, DetailState>(
          builder: (context, state) {
            return _buildContent(context, state);
          },
        ),
      ),
    );
  }
}

Widget _buildContent(BuildContext context, DetailState state) {
  switch (state.status) {
    case DetailStatus.loading:
      return const LoadingWidget(textColor: ColorConstant.whiteColor);
    case DetailStatus.error:
      String extractErrorMessage(String errorMessage) {
        final startIndex = errorMessage.indexOf('(');
        final endIndex = errorMessage.indexOf(')');

        if (startIndex != -1 && endIndex != -1 && endIndex > startIndex) {
          return errorMessage.substring(startIndex + 1, endIndex);
        }

        return errorMessage;
      }
      return ErrorWidgetComponent(
        errorMessage: extractErrorMessage(state.errorMessage),
        onTap: () => context.read<DetailBloc>().add(const DetailGetBookmarks()),
      );
    case DetailStatus.success:
      if (state.bookmarks.isEmpty) {
        return const Center(
          child: Text(
            'Bookmark Belum Ditambahkan',
            style: TextStyle(color: ColorConstant.whiteColor),
          ),
        );
      }
      return RefreshIndicator(
        backgroundColor: ColorConstant.whiteColor,
        color: ColorConstant.kThird,
        onRefresh: () async {
          context.read<DetailBloc>().add(const DetailGetBookmarks());
        },
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: state.bookmarks.length,
          itemBuilder: (context, index) {
            final item = state.bookmarks[index];
            return Dismissible(
              key: Key(item.href!), // Menggunakan href sebagai kunci unik
              direction: DismissDirection.endToStart, // Hanya swipe ke kiri
              onDismissed: (direction) {
                context.read<DetailBloc>().add(DetailRemoveBookmark(item));
              },
              background: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 155, 46, 38),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(16),
                child: const Icon(
                  Icons.delete,
                  color: Color.fromARGB(255, 185, 185, 185),
                  size: 48,
                ),
              ),
              child: KomikCardWidget(
                title: item.title,
                status: item.status,
                href: item.href!,
                rate: fixedRating(item.rating),
                type: item.type,
                thumbnail: item.thumbnail,
              ),
            );
          },
        ),
      );
  }
}
