import 'package:flutter/material.dart';
import 'settings.dart';

class MenuDrawer extends StatefulWidget {
  final VoidCallback onProfileTap;
  final VoidCallback onSettingsTap;
  final VoidCallback onAboutAppTap;
  final VoidCallback onHelpTap;
  final VoidCallback onLogoutTap;

  const MenuDrawer({
    required this.onProfileTap,
    required this.onSettingsTap,
    required this.onAboutAppTap,
    required this.onHelpTap,
    required this.onLogoutTap,
  });

  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Drawer(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: screenHeight * 0.05,
              left: screenWidth * 0.04,
              right: screenWidth * 0.04,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.close, size: screenWidth * 0.06),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[800],
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nikson Nadar',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        'App ID : HM12434322',
                        style: TextStyle(
                          fontSize: screenWidth * 0.03,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.03,
                      vertical: screenHeight * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: screenWidth * 0.04,
                          color: Colors.white,
                        ),
                        SizedBox(width: screenWidth * 0.01),
                        Text(
                          'Verified',
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.02),
              decoration: BoxDecoration(
                color: Colors.blue[800],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Edit Your Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.035,
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Divider(),
          SizedBox(height: screenHeight * 0.03),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildMenuItem(
                  icon: Icons.person,
                  title: 'Your Profile',
                  index: 0,
                  onTap: widget.onProfileTap,
                  screenWidth: screenWidth,
                ),
                _buildMenuItem(
                  icon: Icons.settings,
                  title: 'Settings',
                  index: 1,
                  onTap: widget.onSettingsTap,
                  screenWidth: screenWidth,
                ),
                _buildMenuItem(
                  icon: Icons.info,
                  title: 'About App',
                  index: 2,
                  onTap: widget.onAboutAppTap,
                  screenWidth: screenWidth,
                ),
                _buildMenuItem(
                  icon: Icons.help,
                  title: 'Help & Support',
                  index: 3,
                  onTap: widget.onHelpTap,
                  screenWidth: screenWidth,
                ),
                SizedBox(height: screenHeight * 0.24),
                _buildMenuItem(
                  icon: Icons.exit_to_app,
                  title: 'Log Out',
                  index: 4,
                  onTap: widget.onLogoutTap,
                  screenWidth: screenWidth,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required int index,
    required VoidCallback onTap,
    required double screenWidth,
  }) {
    bool isSelected = _selectedIndex == index;

    return Padding(
      padding: EdgeInsets.only(left: screenWidth * 0.04),
      child: ListTile(
        leading: Icon(
          icon,
          size: screenWidth * 0.06,
          color: isSelected ? Colors.blue[800] : Colors.black,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: screenWidth * 0.04,
            color: isSelected ? Colors.blue[800] : Colors.black,
          ),
        ),
        trailing: index != 4
            ? Icon(
                Icons.arrow_forward_ios,
                size: screenWidth * 0.04,
                color: isSelected ? Colors.blue[800] : Colors.black,
              )
            : null,
        tileColor:
            isSelected ? Color.fromARGB(255, 80, 157, 245) : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
          onTap();
        },
      ),
    );
  }
}
