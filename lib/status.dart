import 'package:flutter/material.dart';

class JobStatus {
  final String image;
  final String status;
  final int level;
  final String message;
  final String statusMessage;
  final bool isRead;
  final String username;

  JobStatus({
    required this.image,
    required this.status,
    required this.level,
    required this.message,
    required this.statusMessage,
    required this.isRead,
    required this.username,
  });
}

class StatusPage extends StatefulWidget {
  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  List<JobStatus> messages = [
    JobStatus(
        image: "assets/job_status_profile1.jpg",
        status:
            "Thank you for your submission! Our team will review your query shortly.",
        level: 1,
        message:
            "Thank you for your submission! Our team will review your query shortly.",
        statusMessage: "Application Sent",
        isRead: true,
        username: "Hiremi Mentor"),
    JobStatus(
        image: "assets/job_status_profile2.jpg",
        status:
            "Your query has been analyzed. A meeting has been scheduled and details.",
        level: 1,
        message:
            "Thank you for your submission! Our team will review your query shortly.",
        statusMessage: "Query Analyzed",
        isRead: true,
        username: "Hiremi Mentor"),
    JobStatus(
        image: "assets/job_status_profile3.jpg",
        status: "Looks perfect, send it for technical review tomorrow!",
        level: 1,
        message:
            "Thank you for your submission! Our team will review your query shortly.",
        statusMessage: "Meeting Scheduled",
        isRead: true,
        username: "Hiremi Mentor"),
    JobStatus(
        image: "assets/job_status_profile4.jpg",
        status: "Looks perfect, send it for technical review tomorrow!",
        level: 1,
        message:
            "Thank you for your submission! Our team will review your query shortly.",
        statusMessage: "Query has been resolved",
        isRead: false,
        username: "Hiremi Mentor"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: MessageCard(status: messages[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MessageCard extends StatelessWidget {
  final JobStatus status;

  MessageCard({required this.status});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(status.image),
            ),
            title: Row(
              children: [
                Text(
                  status.username.isNotEmpty ? status.username : "Unknown",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.04,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Added a new message',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: screenWidth * 0.035,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              status.status,
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03,
                    vertical: screenWidth * 0.01,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status.statusMessage,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.02),
                  child: Icon(
                    status.isRead
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: status.isRead ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
