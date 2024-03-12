import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangap/core/common/widget/title_icon.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:mangap/fetures/home/domain/entities/komik_entity.dart';
import 'package:mangap/fetures/home/presentation/bloc/home_bloc.dart';
import 'package:mangap/fetures/home/presentation/widgets/update_komik_widget.dart';

class ListKomikUpdate extends StatefulWidget {
  const ListKomikUpdate({super.key, required this.title, required this.komiks});

  final String title;
  final List<KomikEntity> komiks;

  @override
  State<ListKomikUpdate> createState() => _ListKomikUpdateState();
}

class _ListKomikUpdateState extends State<ListKomikUpdate> {
  late ScrollController _scrollController;

  int _currentPage = 1;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_loadMore);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_loadMore)
      ..dispose();
    super.dispose();
  }

  void _loadMore() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= maxScroll) {
      setState(() => _currentPage++);
      BlocProvider.of<HomeBloc>(context).add(
        HomeGetUpdateKomik(
          page: _currentPage.toString(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    IconData icon = TitleIconWidget.getIcon(widget.title);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: ColorConstant.whiteColor,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                widget.title,
                style: const TextStyle(
                    color: ColorConstant.whiteColor, fontSize: 20),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 420,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: widget.komiks.length,
              itemBuilder: (context, index) {
                final komik = widget.komiks[index];
                return UpdateKomikWidget(
                  coverImg: komik.coverImg,
                  title: komik.title,
                  chapter: komik.latestChapter,
                  rating: komik.rating,
                  type: komik.type,
                  completed: komik.completed!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
