import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:mangap/fetures/genre/presentation/pages/genre_page.dart';
import 'package:mangap/fetures/main/bloc/navigation_bloc.dart';

class KomikGenreWidgetHome extends StatelessWidget {
  const KomikGenreWidgetHome({
    super.key,
    required this.title,
    required this.href,
  });

  final String title;
  final String href;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        context.read<NavigationBloc>().add(HideBottomBarEvent());
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => GenrePage(
              href: href,
              title: title,
            ),
          ),
        );
        context.read<NavigationBloc>().add(ShowBottomBarEvent());
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 3, top: 8),
        decoration: BoxDecoration(
          color: ColorConstant.kThird,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: GoogleFonts.openSans(
              color: ColorConstant.whiteColor,
              fontWeight: FontWeight.normal,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
