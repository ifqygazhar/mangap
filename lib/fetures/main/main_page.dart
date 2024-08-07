import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mangap/core/constants/color.dart';
import 'package:mangap/fetures/home/presentation/pages/home_page.dart';
import 'package:mangap/fetures/main/bloc/navigation_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      const Center(child: Text("Page 1: List of items")),
      const Center(child: Text("Page 1: List of items")),
      Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Refresh Page'),
        ),
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const FaIcon(FontAwesomeIcons.house),
        title: "Home",
        activeColorPrimary: ColorConstant.whiteColor,
        inactiveColorPrimary: ColorConstant.whiteColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.menu_book),
        title: "Manga List",
        activeColorPrimary: ColorConstant.whiteColor,
        inactiveColorPrimary: ColorConstant.whiteColor,
      ),
      PersistentBottomNavBarItem(
        icon: const FaIcon(FontAwesomeIcons.bookOpenReader),
        title: "History",
        activeColorPrimary: ColorConstant.whiteColor,
        inactiveColorPrimary: ColorConstant.whiteColor,
      ),
      PersistentBottomNavBarItem(
        icon: const FaIcon(FontAwesomeIcons.solidBookmark),
        title: "Bookmark",
        activeColorPrimary: ColorConstant.whiteColor,
        inactiveColorPrimary: ColorConstant.whiteColor,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: Scaffold(
        body: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            final PersistentTabController controller =
                PersistentTabController(initialIndex: 0);
            return PersistentTabView(
              context,
              controller: controller,
              screens: _buildScreens(),
              items: _navBarsItems(),
              navBarStyle: NavBarStyle.style1,
              onItemSelected: (index) {
                context.read<NavigationBloc>().add(NavigateToPage(index));
              },
              backgroundColor: ColorConstant.kThird,
              decoration: NavBarDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              handleAndroidBackButtonPress: true,
              resizeToAvoidBottomInset: true,
            );
          },
        ),
      ),
    );
  }
}
