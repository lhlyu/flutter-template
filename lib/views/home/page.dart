import 'package:flutter/material.dart';
import 'package:flutter_template/views/about/page.dart';
import 'package:flutter_template/views/permission/page.dart';
import 'package:flutter_template/views/upgrade/page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 1;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const <Widget>[
          PermissionPage(),
          UpgradePage(),
          AboutPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        // selectedIconTheme: IconThemeData(
        //   size: ((IconTheme.of(context).size)! * 1.3),
        // ),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.tune), label: "许可"),
          BottomNavigationBarItem(icon: Icon(Icons.upgrade), label: "更新"),
          BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: "关于"),
        ],
      ),
    );
  }
}
