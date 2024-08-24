import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mangap/core/common/widget/appbar.dart';
import 'package:mangap/core/common/widget/error.dart';
import 'package:mangap/core/common/widget/loading.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:mangap/fetures/main/bloc/navigation_bloc.dart';
import 'package:mangap/fetures/read/domain/entities/read_entity.dart';
import 'package:mangap/fetures/read/presentation/bloc/read_bloc.dart';
import 'package:mangap/fetures/read/presentation/widgets/information_fullscreen.dart';
import 'package:mangap/fetures/read/presentation/widgets/list_image_widget.dart';
import 'package:mangap/fetures/read/presentation/widgets/list_information_widget.dart';

class ReadPage extends StatelessWidget {
  const ReadPage({super.key, required this.href, required this.route});

  final String href, route;

  @override
  Widget build(BuildContext context) {
    context.read<ReadBloc>().add(
          ReadGetChapter(href),
        );

    return BlocBuilder<ReadBloc, ReadState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorConstant.kPrimary,
          appBar: state.isFullscreen
              ? null
              : AppbarWidget(
                  title: 'Read',
                  leading: IconButton(
                    onPressed: () {
                      if (route == "history") {
                        context
                            .read<NavigationBloc>()
                            .add(ShowBottomBarEvent());
                      } else {
                        context
                            .read<NavigationBloc>()
                            .add(HideBottomBarEvent());
                      }

                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Platform.isIOS || Platform.isMacOS
                          ? Icons.arrow_back_ios
                          : Icons.arrow_back,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () => context.read<ReadBloc>().add(
                            ReadGetChapter(href),
                          ),
                      icon: const Icon(Icons.restart_alt),
                    ),
                    IconButton(
                      onPressed: () {
                        if (state.isFullscreen) {
                          context.read<ReadBloc>().add(ShowReadNoFullscreen());
                        } else {
                          context.read<ReadBloc>().add(ShowReadFullscreen());
                        }
                      },
                      icon: Icon(
                        state.isFullscreen
                            ? Icons.fullscreen_exit
                            : Icons.fullscreen,
                      ),
                    ),
                  ],
                ),
          body: GestureDetector(
            onDoubleTap: () {
              context.read<ReadBloc>().add(ShowReadNoFullscreen());
            },
            child: Builder(
              builder: (context) {
                switch (state.status) {
                  case ReadStatus.loading:
                    return const LoadingWidget(
                        textColor: ColorConstant.whiteColor);
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
                    final chapterEntity = ReadEntity(
                      title: href,
                      prev: 'prev',
                      next: 'next',
                      panel: [],
                    );
                    context
                        .read<ReadBloc>()
                        .add(ReadSaveChapter(chapterEntity));
                    return ListView(
                      children: [
                        const InformationFullscreen(),
                        ListInformationWidget(
                          read: state.read,
                          route: route,
                        ),
                        ListImageWidget(read: state.read),
                        ListInformationWidget(read: state.read, route: route),
                      ],
                    );
                  default:
                    return const SizedBox.shrink();
                }
              },
            ),
          ),
        );
      },
    );
  }
}
