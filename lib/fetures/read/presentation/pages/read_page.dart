import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangap/core/common/widget/appbar.dart';
import 'package:mangap/core/common/widget/error.dart';
import 'package:mangap/core/common/widget/loading.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:mangap/fetures/read/domain/entities/read_entity.dart';
import 'package:mangap/fetures/read/presentation/bloc/read_bloc.dart';
import 'package:mangap/fetures/read/presentation/widgets/list_image_widget.dart';
import 'package:mangap/fetures/read/presentation/widgets/list_information_widget.dart';

class ReadPage extends StatelessWidget {
  const ReadPage({super.key, required this.href});

  final String href;

  @override
  Widget build(BuildContext context) {
    final chapterEntity = ReadEntity(
      title: href,
      prev: 'prev',
      next: 'next',
      panel: [],
    );
    context.read<ReadBloc>().add(ReadSaveChapter(chapterEntity));
    context.read<ReadBloc>().add(
          ReadGetChapter(href),
        );

    return Scaffold(
      backgroundColor: ColorConstant.kPrimary,
      appBar: AppbarWidget(
        title: 'Read',
        actions: [
          IconButton(
              onPressed: () => context.read<ReadBloc>().add(
                    ReadGetChapter(href),
                  ),
              icon: const Icon(Icons.restart_alt))
        ],
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
                  context.read<ReadBloc>().add(
                        ReadGetChapter(href),
                      );
                },
              );
            case ReadStatus.success:
              return ListView(
                children: [
                  ListInformationWidget(read: state.read),
                  ListImageWidget(read: state.read),
                  ListInformationWidget(read: state.read),
                ],
              );
          }
        },
      ),
    );
  }
}
