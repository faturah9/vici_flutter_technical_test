import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../resources/colors.dart';
import '../discover/presentation/pages/discover_page.dart';
import '../profile/presentation/pages/profile_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: const <Widget>[
              DiscoverPage(),
              ProfilePage(),
              // _discoverScreen!,
              // _wishlist!,
              // _cartScreen!,
              // _profileScreen!,
            ],
          ),
        ),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
            ]),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: GNav(
                gap: 0,
                activeColor: Colors.white,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: const Duration(milliseconds: 800),
                tabBackgroundColor: AppColors.deepSkyBlue,
                tabs: const [
                  GButton(
                    icon: CupertinoIcons.home,
                    text: 'Discover',
                  ),
                  // GButton(
                  //   icon: CupertinoIcons.heart,
                  //   text: 'Favorite',
                  // ),
                  // GButton(
                  //   icon: CupertinoIcons.cart,
                  //   text: 'Cart',
                  // ),
                  GButton(
                    icon: CupertinoIcons.person,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: _currentIndex,
                onTabChange: (index) {
                  setState(() => _currentIndex = index);
                  _pageController!.jumpToPage(index);
                },
              ),
            )));
  }
}
