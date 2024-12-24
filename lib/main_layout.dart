import 'package:flutter/material.dart';
import 'package:hiremi_app/askexpert.dart';
import 'package:hiremi_app/job_description.dart';
import 'home_screen.dart';
import 'jobs_main.dart';
import 'notifications.dart';
import 'jobs_list.dart';
import 'status.dart';
import 'menu.dart';
import 'settings.dart';
import 'selected_index_provider.dart';
import 'package:provider/provider.dart';

class MainLayout extends StatefulWidget {
  final int initialIndex;

  MainLayout({this.initialIndex = 0});

  @override
  MainLayoutState createState() => MainLayoutState();
}

class MainLayoutState extends State<MainLayout> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  final List<Widget> _screens = [
    HomeScreen(),
    JobsMainPage(),
    AskExpertScreen(),
    StatusPage(),
    Center(child: Text("360 Screen")),
    NotificationPage(),
    SettingsPage(),
  ];

  final List<IconData> _icons = [
    Icons.home,
    Icons.work,
    Icons.chat,
    Icons.assignment,
    Icons.loop,
    Icons.notifications,
  ];

  final List<String> _titles = [
    'Home',
    'Jobs',
    'Ask Expert',
    'Status',
    '360',
    'Notifications',
    'Settings',
  ];

  void changeSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToSettings() {
    Navigator.of(context).pop();
    setState(() {
      _selectedIndex = _screens.length - 1;
    });
  }

  void _navigateToHome() {
    Navigator.of(context).pop();
    setState(() {
      _selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex =
        Provider.of<SelectedIndexProvider>(context).selectedIndex;
    double horizontalMargin = MediaQuery.of(context).size.width * 0.03;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _selectedIndex == 0
          ? null
          : AppBar(
              backgroundColor: Colors.grey[100],
              elevation: 0,
              title: Text(
                _titles[_selectedIndex],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: Icon(Icons.menu, color: Colors.black),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.notifications, color: Colors.black),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = _icons.indexOf(Icons.notifications);
                    });
                  },
                ),
              ],
            ),
      body: _screens[_selectedIndex],
      drawer: MenuDrawer(
        onProfileTap: () {
          _navigateToHome();
        },
        onSettingsTap: _navigateToSettings,
        onAboutAppTap: () {
          _navigateToSettings();
        },
        onHelpTap: () {
          _navigateToSettings();
        },
        onLogoutTap: () {},
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            5,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                  Provider.of<SelectedIndexProvider>(context, listen: false)
                      .changeSelectedIndex(index);
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _icons[index],
                    color: _selectedIndex == index
                        ? Colors.blue[800]
                        : Colors.grey,
                    size: 28,
                  ),
                  SizedBox(height: 2),
                  Text(
                    _titles[index],
                    style: TextStyle(
                      color: _selectedIndex == index
                          ? Colors.blue[800]
                          : Colors.grey,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
