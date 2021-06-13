import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lyrics/src/blocs/search_song_bloc.dart';

import 'bottom_navigator_item.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SearchSongBloc(),
        ),
      ],
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (int index){
            setState(() {
              _currentIndex = index;
            });
          },
          children: navigatorItems.map((e) => e.screen).toList(),
        ),
        bottomNavigationBar: BottomNavigatorBarWidget(
          onItemClicked: onNavigatorItemClicked,
          currentIndex: _currentIndex,
        ),
      ),
    );
  }

  void onNavigatorItemClicked(int index) {
    updateIndex(index);
  }

  void updateIndex(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(
        index,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 500),
      );
    });
  }
}

class BottomNavigatorBarWidget extends StatelessWidget {
  final double navBarRoundness = 20;
  final int currentIndex;
  final Function onItemClicked;

  const BottomNavigatorBarWidget(
      {Key key, this.currentIndex, this.onItemClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(navBarRoundness),
          topLeft: Radius.circular(navBarRoundness),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(navBarRoundness),
          topRight: Radius.circular(navBarRoundness),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onItemClicked,
          type: BottomNavigationBarType.fixed,
          items: navigatorItems.map((e) {
            return BottomNavigationBarItem(
              label: e.label,
              icon: Icon(e.iconData),
            );
          }).toList(),
        ),
      ),
    );
  }
}
