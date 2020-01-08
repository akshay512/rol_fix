import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:rol_fix/UI/home.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  bool theme = false;
  bool isLoading = true;
  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  _changeTheme() {
    setState(() {
      theme = !theme;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'App Panel',
      theme: ThemeData(brightness: theme ? Brightness.dark : Brightness.light),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Food menu'),
        ),
        bottomNavigationBar: FancyBottomNavigation(
          tabs: <TabData>[
            TabData(iconData: Icons.home, title: 'Home',onclick: () => _pageController.jumpTo(0)),
            TabData(iconData: Icons.favorite, title: 'Favourite',onclick: () => _pageController.jumpTo(1)),
            TabData(iconData: Icons.person, title: 'Accounts',onclick: () => _pageController.jumpTo(2)),
            TabData(iconData: Icons.settings, title: 'Settings',onclick: () => _pageController.jumpTo(3))
          ],
          onTabChangedListener: (position) {
            setState(() {
              _pageController.jumpTo(position.toDouble());
            });
          },
        ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[Home(),
           Home(), 
           Home(), 
           Home(),
           ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _changeTheme(),
          tooltip: 'Change theme',
          child: Icon(Icons.add_circle),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
