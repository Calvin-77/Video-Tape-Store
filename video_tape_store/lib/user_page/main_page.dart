import 'package:flutter/material.dart';
import 'package:video_tape_store/user_page/home_page.dart';
import 'package:video_tape_store/user_page/settings_page.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MainPage extends StatefulWidget {
  final List<Widget> bar = [HomePage(), const SettingsPage()];
  MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: widget.bar[currentPage],
        bottomNavigationBar: Container(
          width: double.maxFinite,
          height: 77,
          padding: const EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: Theme.of(context).colorScheme.primary,
          ),
          child: BottomNavigationBar(
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                      PhosphorIcons.houseSimple(PhosphorIconsStyle.regular)),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Icon(PhosphorIcons.user(PhosphorIconsStyle.regular)),
                  label: '')
            ],
            currentIndex: currentPage,
            onTap: (int index) {
              setState(() {
                currentPage = index;
              });
            },
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.white,
            backgroundColor: Colors.transparent,
            iconSize: 30,
          ),
        ));
  }
}
