import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final String appId = 'APP34364534';

  bool _isJobAlertEnabled = false;

  List<bool> _isSelected = [false, false, false, false, false];

  String? username;
  String? email;
  String? password;
  bool? status;

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
      email = prefs.getString('email');
      password = prefs.getString('password');
      status = prefs.getBool('status');
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double avatarRadius = width * 0.05;
    double fontSizeUsername = width * 0.06;
    double fontSizeAppId = width * 0.03;

    _loadUserData();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: EdgeInsets.all(width * 0.04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(width * 0.04),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 6,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: avatarRadius,
                      backgroundImage:
                          AssetImage('assets/job_status_profile1.jpg'),
                    ),
                    SizedBox(width: width * 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username ?? 'Unknown',
                          style: TextStyle(
                            fontSize: fontSizeUsername,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              'APP ID: ',
                              style: TextStyle(
                                fontSize: fontSizeAppId,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              appId,
                              style: TextStyle(
                                fontSize: fontSizeAppId,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.02, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue[800],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            status == true ? Icons.verified : Icons.close,
                            color: Colors.white,
                            size: width * 0.05,
                          ),
                          SizedBox(width: 4),
                          Text(
                            status == true ? 'Verified' : 'Unverified',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.05),
              _buildSection(
                title: 'Account',
                items: [
                  _buildListItem(
                    title: 'Your Profile',
                    icon: Icons.person,
                    hasToggle: false,
                    onTap: () {
                      setState(() {
                        _isSelected[0] = !_isSelected[0];
                      });
                    },
                    isSelected: _isSelected[0],
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),
              _buildSection(
                title: 'Privacy & Security',
                items: [
                  _buildListItem(
                    title: 'Change Password',
                    icon: Icons.lock,
                    hasToggle: false,
                    onTap: () {
                      setState(() {
                        _isSelected[1] = !_isSelected[1];
                      });
                    },
                    isSelected: _isSelected[1],
                  ),
                  _buildListItem(
                    title: 'Job Alert Notification',
                    icon: Icons.notifications,
                    hasToggle: true,
                    onTap: () {
                      setState(() {
                        _isJobAlertEnabled = !_isJobAlertEnabled;
                      });
                    },
                    isSelected: _isJobAlertEnabled,
                  ),
                  _buildListItem(
                    title: 'Terms and conditions',
                    icon: Icons.description,
                    hasToggle: false,
                    onTap: () {
                      setState(() {
                        _isSelected[2] = !_isSelected[2];
                      });
                    },
                    isSelected: _isSelected[2],
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),
              _buildSection(
                title: 'About & More',
                items: [
                  _buildListItem(
                    title: 'About Us',
                    icon: Icons.info,
                    hasToggle: false,
                    onTap: () {
                      setState(() {
                        _isSelected[3] = !_isSelected[3];
                      });
                    },
                    isSelected: _isSelected[3],
                  ),
                  _buildListItem(
                    title: 'Help and Support',
                    icon: Icons.help,
                    hasToggle: false,
                    onTap: () {
                      setState(() {
                        _isSelected[4] = !_isSelected[4];
                      });
                    },
                    isSelected: _isSelected[4],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.only(left: 10, bottom: 10, right: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              ...items,
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListItem({
    required String title,
    required IconData icon,
    required bool hasToggle,
    required VoidCallback onTap,
    required bool isSelected,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: isSelected ? Colors.blue[800] : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.blue[800] : null,
        ),
      ),
      trailing: hasToggle
          ? Switch(
              value: isSelected,
              onChanged: (value) {
                onTap();
              },
              activeColor: Colors.blue[800],
            )
          : Icon(
              Icons.arrow_forward_ios,
              color: isSelected ? Colors.blue[800] : null,
            ),
    );
  }
}
