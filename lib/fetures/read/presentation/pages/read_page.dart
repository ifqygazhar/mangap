import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangap/core/common/widget/appbar.dart';
import 'package:mangap/core/common/widget/error.dart';
import 'package:mangap/core/common/widget/loading.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:mangap/fetures/read/presentation/bloc/read_bloc.dart';
import 'package:mangap/fetures/read/presentation/widgets/list_image_widget.dart';
import 'package:mangap/fetures/read/presentation/widgets/list_information_widget.dart';

class ReadPage extends StatelessWidget {
  const ReadPage({super.key, required this.href});

  final String href;

  @override
  Widget build(BuildContext context) {
    context.read<ReadBloc>().add(
          ReadGetChapter(href),
        );
    return Scaffold(
        backgroundColor: ColorConstant.kPrimary,
        appBar: const AppbarWidget(
          title: 'Read',
        ),
        body: BlocBuilder<ReadBloc, ReadState>(
          builder: (context, state) {
            if (state.status == ReadStatus.loading) {
              return const LoadingWidget(textColor: ColorConstant.whiteColor);
            } else if (state.status == ReadStatus.error) {
              return ErrorWidgetComponent(
                errorMessage: state.errorMessage,
                onTap: () {},
              );
            } else {
              return ListView(
                children: [
                  ListInformationWidget(read: state.read),
                  ListImageWidget(read: state.read),
                  ListInformationWidget(read: state.read),
                ],
              );
            }
          },
        ));
  }
}
