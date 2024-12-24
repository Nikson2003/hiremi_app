import 'package:flutter/material.dart';
import 'jobs_list.dart';
import 'top_bar.dart';
import 'bottom_bar.dart';
import 'main_layout.dart';
import 'package:provider/provider.dart';
import 'selected_index_provider.dart';

class JobDescriptionPage extends StatefulWidget {
  final Job job;

  JobDescriptionPage({required this.job});

  @override
  _JobDescriptionPageState createState() => _JobDescriptionPageState();
}

class _JobDescriptionPageState extends State<JobDescriptionPage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    Center(child: Text("Home Screen")),
    Center(child: Text("Jobs Screen")),
    Center(child: Text("Ask Expert Screen")),
    Center(child: Text("Status Screen")),
    Center(child: Text("360 Screen")),
    Center(child: Text("Notifications Screen")),
    Center(child: Text("Settings Screen")),
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

  void _onBottomBarItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
      Provider.of<SelectedIndexProvider>(context, listen: false)
          .changeSelectedIndex(index);
      print("Selected Index: $index");
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainLayout(initialIndex: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: TopBar(
        title: 'Job Description',
        onMenuTap: () {
          Navigator.pop(context);
        },
        onNotificationTap: () {
          setState(() {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainLayout(initialIndex: 5),
              ),
            );
          });
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenHeight * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.01),
              Text(
                "Role: ${widget.job.title}",
                style: TextStyle(
                  fontSize: screenHeight * 0.025,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 21, 101, 192),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                "Location: ${widget.job.location}",
                style: TextStyle(
                  fontSize: screenHeight * 0.02,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                "Salary: ₹${widget.job.minPay} - ₹${widget.job.maxPay}",
                style: TextStyle(
                  fontSize: screenHeight * 0.02,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                "About the Role",
                style: TextStyle(
                  fontSize: screenHeight * 0.022,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 21, 101, 192),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                widget.job.description,
                style: TextStyle(
                  fontSize: screenHeight * 0.018,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                "Skills Required",
                style: TextStyle(
                  fontSize: screenHeight * 0.022,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 21, 101, 192),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildSkillTag('Flutter'),
                  _buildSkillTag('Dart'),
                  _buildSkillTag('Firebase'),
                  _buildSkillTag('Android'),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                "Eligibility Criteria",
                style: TextStyle(
                  fontSize: screenHeight * 0.022,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 21, 101, 192),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                "• Minimum 2 years of experience in mobile app development.",
                style: TextStyle(
                  fontSize: screenHeight * 0.018,
                  color: Colors.black,
                ),
              ),
              Text(
                "• Strong understanding of mobile UI/UX design principles.",
                style: TextStyle(
                  fontSize: screenHeight * 0.018,
                  color: Colors.black,
                ),
              ),
              Text(
                "• Good problem-solving skills and attention to detail.",
                style: TextStyle(
                  fontSize: screenHeight * 0.018,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                "About ${widget.job.company}",
                style: TextStyle(
                  fontSize: screenHeight * 0.022,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 21, 101, 192),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                "We are a leading company in the tech industry, known for our innovative solutions and commitment to creating a positive impact on the community. Our team is passionate about building cutting-edge applications and providing a great work environment.",
                style: TextStyle(
                  fontSize: screenHeight * 0.018,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Apply >",
                    style: TextStyle(
                      fontSize: screenHeight * 0.02,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 21, 101, 192),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenHeight * 0.015,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onBottomBarItemSelected,
      ),
    );
  }

  Widget _buildSkillTag(String skill) {
    return Chip(
      label: Text(skill),
      backgroundColor: Colors.blue[200],
      labelStyle: TextStyle(
        color: Colors.blue[800],
      ),
    );
  }
}
