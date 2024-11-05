import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangap/core/common/widget/appbar.dart';
import 'package:mangap/core/common/widget/error.dart';
import 'package:mangap/core/common/widget/information_card.dart';
import 'package:mangap/core/common/widget/loading.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:mangap/core/utils/format_title.dart';
import 'package:mangap/fetures/main/bloc/navigation_bloc.dart';
import 'package:mangap/fetures/read/presentation/bloc/read_bloc.dart';
import 'package:mangap/fetures/read/presentation/pages/read_page.dart';
import 'package:mangap/fetures/read/presentation/widgets/list_history_read_widget.dart';

class ReadHistoryPage extends StatelessWidget {
  const ReadHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger untuk mendapatkan chapter yang disimpan
    context.read<ReadBloc>().add(ReadGetSaveChapter());

    return Scaffold(
      backgroundColor: ColorConstant.kPrimary,
      appBar: const AppbarWidget(
        title: "History",
      ),
      body: BlocBuilder<ReadBloc, ReadState>(
        builder: (context, state) {
          switch (state.status) {
            case ReadStatus.loading:
              return const LoadingWidget(textColor: ColorConstant.whiteColor);

            case ReadStatus.error:
              return ErrorWidgetComponent(
                errorMessage: state.errorMessage,
                onTap: () {
                  context.read<ReadBloc>().add(ReadGetSaveChapter());
                },
              );

            case ReadStatus.success:
              if (state.saveRead.isEmpty) {
                return const LoadingWidget(
                  textColor: ColorConstant.whiteColor,
                  image: 'assets/images/keyword.gif',
                  text: 'Belum ada histori...',
                );
              } else {
                return Column(
                  children: [
                    const InformationCard(konteks: 'histori'),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: ListView.builder(
                        itemCount: state.saveRead.length,
                        itemBuilder: (context, index) {
                          final chapter = state.saveRead[index];
                          final formatted = formatTitle(chapter.title);
                          return Dismissible(
                            key: UniqueKey(), // Gunakan identifier unik
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              // Memanggil event untuk menghapus chapter
                              context
                                  .read<ReadBloc>()
                                  .add(ReadRemoveChapter(chapter));
                              context
                                  .read<ReadBloc>()
                                  .add(ReadGetSaveChapter());
                            },
                            background: Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 155, 46, 38),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.centerRight,
                              child: const Icon(
                                Icons.delete,
                                color: Color.fromARGB(255, 185, 185, 185),
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                context
                                    .read<NavigationBloc>()
                                    .add(HideBottomBarEvent());
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ReadPage(
                                      href: chapter.title,
                                      route: 'history',
                                    ),
                                  ),
                                );
                                context
                                    .read<NavigationBloc>()
                                    .add(ShowBottomBarEvent());
                              },
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: ListHistoryReadWidget(
                                    title: formatted['text'] ?? '',
                                    chapter: formatted['number'] ?? '',
                                  )),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
          }
        },
      ),
    );
  }
}
