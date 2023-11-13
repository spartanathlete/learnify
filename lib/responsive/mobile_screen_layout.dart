import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnify/providers/theme_provider.dart';

class MobileScreenLayout extends StatefulWidget {
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final ThemeProvider themeProvider;

  const MobileScreenLayout({
    Key? key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.themeProvider,
  }) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  // int _page = 0;
  late PageController pageController; // for tabs animation

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  // void onPageChanged(int page) {
  //   setState(() {
  //     _page = page;
  //   });
  // }

  // void navigationTapped(int page) {
  //   //Animating Page
  //   pageController.jumpToPage(page);
  // }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    // //   body: Expanded(
    // //     child: widget.body,
    // //   ),
    // //   bottomNavigationBar: NavigationRail(

    // //     leading: const CircleAvatar(
    // //       backgroundImage: AssetImage(ImageRasterPath.avatar5),
    // //       radius: 20,
    // //       backgroundColor: Colors.white,
    // //     ),
    // //     groupAlignment: 0.0,
    // //     selectedIndex: widget.selectedIndex,
    // //     onDestinationSelected: widget.onDestinationSelected,
    // //     labelType: NavigationRailLabelType.all,
    // //     destinations: [
    // //       NavigationRailDestination(
    // //         label: Text(
    // //           'Dashboard',
    // //           style: TextStyle(
    // //             color: (widget.themeProvider.isDarkTheme)
    // //                 ? null
    // //                 : const Color.fromARGB(255, 186, 232, 232),
    // //           ),
    // //         ),
    // //         icon: Icon(
    // //           Icons.dashboard,
    // //           color: (widget.themeProvider.isDarkTheme)
    // //               ? null
    // //               : const Color.fromARGB(255, 186, 232, 232),
    // //         ),
    // //       ),
    // //       NavigationRailDestination(
    // //         label: Text(
    // //           'Lessons',
    // //           style: TextStyle(
    // //             color: (widget.themeProvider.isDarkTheme)
    // //                 ? null
    // //                 : const Color.fromARGB(255, 186, 232, 232),
    // //           ),
    // //         ),
    // //         icon: Icon(
    // //           Icons.book,
    // //           color: (widget.themeProvider.isDarkTheme)
    // //               ? null
    // //               : const Color.fromARGB(255, 186, 232, 232),
    // //         ),
    // //       ),
    // //       NavigationRailDestination(
    // //         label: Text(
    // //           'Settings',
    // //           style: TextStyle(
    // //             color: (widget.themeProvider.isDarkTheme)
    // //                 ? null
    // //                 : const Color.fromARGB(255, 186, 232, 232),
    // //           ),
    // //         ),
    // //         icon: Icon(
    // //           Icons.settings,
    // //           color: (widget.themeProvider.isDarkTheme)
    // //               ? null
    // //               : const Color.fromARGB(255, 186, 232, 232),
    // //         ),
    // //       ),
    // //     ],
    // //   ),
    // // );
    return Scaffold(
      body: widget.body,
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: (widget.themeProvider.isDarkTheme)
            ? null
            : const Color.fromARGB(255, 65, 60, 110),
        // backgroundColor: mobileBackgroundColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              // color: (_page == 0) ? primaryColor : secondaryColor,
            ),
            label: 'Home',
            // backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.book,
              // color: (_page == 1) ? primaryColor : secondaryColor,
            ),
            label: 'Lessons',
            // backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              // color: (_page == 4) ? primaryColor : secondaryColor,
            ),
            label: 'Settings',
            // backgroundColor: primaryColor,
          ),
        ],
        onTap: widget.onDestinationSelected,
        currentIndex: widget.selectedIndex,
      ),
    );
  }
}
