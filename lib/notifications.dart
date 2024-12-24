import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationItem {
  final String title;
  final String description;
  final DateTime timestamp;
  bool viewed;

  NotificationItem({
    required this.title,
    required this.description,
    required this.timestamp,
    this.viewed = false,
  });
}

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<NotificationItem> notifications = [];

  @override
  void initState() {
    super.initState();
    _loadViewedNotifications();
  }

  Future<void> _loadViewedNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<NotificationItem> newNotifications = [
      NotificationItem(
        title: "Software Engineer Application",
        description:
            "Your application for Software Engineer has been received.",
        timestamp: DateTime.now().subtract(Duration(hours: 1)),
      ),
      NotificationItem(
        title: "Interview Scheduled",
        description: "Your interview is scheduled for tomorrow at 10:00 AM.",
        timestamp: DateTime.now().subtract(Duration(days: 1)),
      ),
      NotificationItem(
        title: "New Job Posted",
        description: "New job posted: Product Manager at TechCorp.",
        timestamp: DateTime.now().subtract(Duration(days: 2)),
      ),
      NotificationItem(
        title: "New Job Posted",
        description: "New job posted: Product Manager at TechCorp.",
        timestamp: DateTime.now().subtract(Duration(days: 2)),
      ),
      NotificationItem(
        title: "New Job Posted",
        description: "New job posted: Product Manager at TechCorp.",
        timestamp: DateTime.now().subtract(Duration(days: 2)),
      ),
    ];

    setState(() {
      notifications.addAll(newNotifications);
    });

    for (int i = 0; i < notifications.length; i++) {
      bool? viewed = prefs.getBool('notification_$i');
      if (viewed != null) {
        setState(() {
          notifications[i].viewed = viewed;
        });
      }
    }
  }

  Future<void> _markAsViewed(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      notifications[index].viewed = true;
    });
    prefs.setBool('notification_$index', true);
  }

  // Future<void> _resetAllNotifications() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   for (int i = 0; i < notifications.length; i++) {
  //     await prefs.remove('notification_$i');

  //     setState(() {
  //       notifications[i].viewed = false;
  //     });
  //   }
  // }

  String formatTime(DateTime dateTime) {
    final istTime = dateTime.add(Duration(hours: 5, minutes: 30));
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(istTime);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.02,
          horizontal: screenWidth * 0.05,
        ),
        child: notifications.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/no_notifications.png'),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      'NNN: No new Notifications!, Please Explore Hiremi Application for a while',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenHeight * 0.022,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification =
                      notifications[notifications.length - 1 - index];
                  return GestureDetector(
                    onTap: () =>
                        _markAsViewed(notifications.length - 1 - index),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                      color: notification.viewed
                          ? Colors.grey[100]
                          : Colors.blue.withOpacity(0.7),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notification.title,
                              style: TextStyle(
                                fontSize: screenHeight * 0.022,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Text(
                              notification.description,
                              style: TextStyle(
                                fontSize: screenHeight * 0.018,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Text(
                              formatTime(notification.timestamp),
                              style: TextStyle(
                                fontSize: screenHeight * 0.016,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
