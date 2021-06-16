import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:udafarm/screen/components/kamus/page_dictionary.dart';
import 'package:udafarm/screen/components/gallery/page_gallery.dart';
import 'package:udafarm/screen/home/home_view.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _bottomNavView = [
    HomeView(),
    PageGallery(),
    PageDictionary(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _bottomNavView.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -10),
              blurRadius: 35,
              color: Colors.green.withOpacity(0.38),
            )
          ],
        ),
        child: BottomNavigationBar(
          // backgroundColor: Colors.green[400],
          currentIndex: _selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          // selectedFontSize: 11,
          // unselectedFontSize: 11,
          // selectedItemColor: Colors.orange,
          type: BottomNavigationBarType.fixed,
          onTap: _onItemTapped,
          items: _navBarList
              .map(
                (e) => BottomNavigationBarItem(
                  icon: SvgPicture.asset(e.icon, width: 25.0),
                  activeIcon: SvgPicture.asset(
                    e.activeIcon,
                    width: 30.0,
                    // color: Colors.green,
                  ),
                  label: e.title,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class NavBarItem {
  final String icon;
  final String activeIcon;
  final String title;
  NavBarItem({
    required this.icon,
    required this.activeIcon,
    required this.title,
  });
}

List<NavBarItem> _navBarList = [
  NavBarItem(
    icon: "assets/svg/icons8-home.svg",
    activeIcon: "assets/svg/home-house-svgrepo-com.svg",
    title: "Home",
  ),
  NavBarItem(
    icon: "assets/svg/gallery-svgrepo-com.svg",
    activeIcon: "assets/svg/gallery-svgrepo-com-color.svg",
    title: "Gallery",
  ),
  NavBarItem(
    icon: "assets/svg/search-svgrepo.svg",
    activeIcon: "assets/svg/search-repo.svg",
    title: "Search",
  ),
];
