import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangap/core/common/widget/appbar.dart';
import 'package:mangap/core/common/widget/error.dart';
import 'package:mangap/core/common/widget/loading.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:mangap/fetures/read/presentation/bloc/read_bloc.dart';
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
                return ListView.builder(
                  itemCount: state.saveRead.length,
                  itemBuilder: (context, index) {
                    final chapter = state.saveRead[index];
                    return Dismissible(
                      key: UniqueKey(), // Gunakan identifier unik
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        // Memanggil event untuk menghapus chapter
                        context
                            .read<ReadBloc>()
                            .add(ReadRemoveChapter(chapter));
                        context.read<ReadBloc>().add(ReadGetSaveChapter());
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      child: ListHistoryReadWidget(
                        title: chapter.title,
                      ),
                    );
                  },
                );
              }
          }
        },
      ),
    );
  }
}
