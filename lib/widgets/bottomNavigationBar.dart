import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_news_app/widgets/bloc/bloc.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final PageController controller;
  const BottomNavigationBarWidget({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
        // ignore: missing_return
        builder: (context, state) {
      if (state is Opened) {
        return BottomNavigationBar(
          backgroundColor: Colors.black,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: state.pageIndex,
          fixedColor: Colors.teal,
          iconSize: 28,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.white,
          onTap: (pageIndex) {
            BlocProvider.of<NavigationBloc>(context)
                .add(Navigate(pageIndex: pageIndex));

            controller.animateToPage(pageIndex,
                duration: Duration(milliseconds: 300), curve: Curves.linear);
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.flag), label: 'Flag'),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: 'Category'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          elevation: 10,
        );
      }
    });
  }
}
