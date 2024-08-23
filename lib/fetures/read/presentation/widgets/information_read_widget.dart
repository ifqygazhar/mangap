import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangap/core/common/widget/button.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:mangap/fetures/main/bloc/navigation_bloc.dart';
import 'package:mangap/fetures/read/presentation/bloc/read_bloc.dart';
import 'package:mangap/fetures/read/presentation/pages/read_page.dart';

class InformationReadWidget extends StatelessWidget {
  const InformationReadWidget({
    super.key,
    required this.title,
    required this.prevHref,
    required this.nextHref,
    required this.route,
  });

  final String title, route;
  final String? prevHref, nextHref;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: ColorConstant.kThird,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title,
                style: GoogleFonts.openSans(
                  color: ColorConstant.whiteColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonWidget(
                    icon: null,
                    onTap: prevHref == null
                        ? () {}
                        : () async {
                            context.read<ReadBloc>().add(ReadLoadingEvent());
                            context
                                .read<NavigationBloc>()
                                .add(HideBottomBarEvent());
                            await Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => ReadPage(
                                  href: prevHref!,
                                  route: route,
                                ),
                              ),
                            );
                            context
                                .read<NavigationBloc>()
                                .add(ShowBottomBarEvent());
                          },
                    color: prevHref == null
                        ? ColorConstant.kPrimary
                        : ColorConstant.whiteColor,
                    text: prevHref == null ? "Chapter Awal" : "Prev Chapter",
                    circular: 4,
                    foregroundColor: ColorConstant.lightText,
                    fontSize: 10,
                  ),
                  const SizedBox(width: 8),
                  ButtonWidget(
                    icon: null,
                    onTap: nextHref == null
                        ? () {}
                        : () async {
                            context.read<ReadBloc>().add(ReadLoadingEvent());
                            context
                                .read<NavigationBloc>()
                                .add(HideBottomBarEvent());
                            await Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) =>
                                    ReadPage(href: nextHref!, route: route),
                              ),
                            );
                            context
                                .read<NavigationBloc>()
                                .add(ShowBottomBarEvent());
                          },
                    color: nextHref == null
                        ? ColorConstant.kPrimary
                        : ColorConstant.whiteColor,
                    text: nextHref == null
                        ? "Berada di chapter akhir"
                        : "Next Chapter",
                    circular: 4,
                    foregroundColor: ColorConstant.lightText,
                    fontSize: 10,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
