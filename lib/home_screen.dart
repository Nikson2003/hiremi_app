import 'dart:async';
import 'package:flutter/material.dart';
import 'menu.dart';
import 'jobs_list.dart';
import 'main_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
import 'dart:ui';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;
  JobsList jobsList = JobsList();
  List<Job> selJobList = [];
  late Timer _timer;

  String? username;
  String? email;
  String? password;
  bool? status;

  bool _isUserDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
    _loadUserData();

    jobsList.addJob(Job(
      title: 'Software Engineer',
      location: 'Mumbai',
      company: 'Hiremi',
      type: JobType.Freshers,
      work: WorkType.onSite,
      minPay: 1200000,
      maxPay: 2000000,
      minYearsOfExperience: 2,
      maxYearsOfExperience: 5,
      description:
          ' As a Software Engineer at Hiremi, you will be responsible for developing, testing, and maintaining software applications. You will collaborate with cross-functional teams to design scalable systems, optimize code performance, and ensure the delivery of high-quality products. This role requires proficiency in programming languages such as Java, Python, or C++, and the ability to work in an agile environment.',
    ));

    jobsList.addJob(Job(
      title: 'Senior Developer',
      location: 'Delhi',
      company: 'Hiremi',
      type: JobType.Experienced,
      work: WorkType.remote,
      minPay: 6500000,
      maxPay: 8500000,
      minYearsOfExperience: 5,
      maxYearsOfExperience: 10,
      description:
          'As a Senior Developer, you will lead the development of complex software solutions at Hiremi. You will work closely with product managers and architects to create scalable, reliable, and secure applications. Your responsibilities will include mentoring junior developers, reviewing code, and improving the development process. Strong experience in web development frameworks, cloud technologies, and database management is required.',
    ));

    jobsList.addJob(Internship(
      title: 'Flutter Intern',
      location: 'Bangalore',
      company: 'CRTD Technologies',
      type: JobType.Internship,
      work: WorkType.hybrid,
      minPay: 15000,
      maxPay: 15000,
      minYearsOfExperience: 0,
      maxYearsOfExperience: 1,
      duration: 6,
      description:
          'Join CRTD Technologies as a Flutter Intern and gain hands-on experience in building mobile applications using the Flutter framework. You will assist in developing, testing, and maintaining cross-platform mobile apps, and work closely with the development team to deliver high-quality user experiences. Ideal candidates should have a basic understanding of Flutter and Dart, with a strong eagerness to learn and grow in mobile app development',
    ));

    selJobList = jobsList.jobs;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < 3) {
        _pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.jumpToPage(0);
      }
    });
  }

  Future<void> makeVerified() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('status', true);
    await _loadUserData();
  }

  Future<void> makeUnverfied() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('status', false);
    await _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (!_isUserDataLoaded) {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        username = prefs.getString('username');
        email = prefs.getString('email');
        password = prefs.getString('password');
        status = prefs.getBool('status');
        _isUserDataLoaded = true;
      });
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  Future<void> _showVerificationDialog(BuildContext context) async {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
            Center(
              child: AlertDialog(
                contentPadding: EdgeInsets.only(bottom: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight * 0.04),
                      decoration: BoxDecoration(
                        color: Colors.blue[800],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/verified.png',
                            height: screenHeight * 0.2,
                            fit: BoxFit.contain,
                          ),
                          Image.asset(
                            'assets/verified_user.gif',
                            height: screenHeight * 0.2,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      'Congratulations! You are verified.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenHeight * 0.02,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    SizedBox(
                      width: screenWidth * 0.7,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[800],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.015),
                          child: Text('OK'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Widget _buildProgressStep({required bool completed, required String label}) {
  //   return Column(
  //     children: [
  //       Row(
  //         children: [
  //           Icon(
  //             completed ? Icons.check_circle : Icons.circle_outlined,
  //             color: Colors.white,
  //             size: 24,
  //           ),
  //           if (!completed)
  //             Container(width: 30, height: 2, color: Colors.white),
  //         ],
  //       ),
  //       SizedBox(height: 8),
  //       Text(
  //         label,
  //         style: TextStyle(
  //           color: Colors.white,
  //           fontSize: 12,
  //           fontWeight: FontWeight.w500,
  //         ),
  //         textAlign: TextAlign.center,
  //       ),
  //     ],
  //   );
  // }

  Widget _buildCircleWithLine(
      int stepNumber, bool isCompleted, double screenWidth,
      {bool isLast = false}) {
    return Expanded(
      child: Row(
        children: [
          Container(
            width: screenWidth * 0.08,
            height: screenWidth * 0.08,
            decoration: BoxDecoration(
              color: isCompleted ? Colors.blue[800] : Colors.white,
              border: Border.all(
                  color: const Color.fromRGBO(30, 136, 229, 1), width: 2),
              borderRadius: BorderRadius.circular(screenWidth * 0.04),
            ),
            child: Center(
              child: isCompleted
                  ? Icon(Icons.check,
                      color: Colors.white, size: screenWidth * 0.04)
                  : Text(
                      '$stepNumber',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          if (!isLast)
            Expanded(
              child: Container(
                height: 2,
                color: Colors.blue[600],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStepLabel(String label, double screenWidth) {
    return SizedBox(
      width: screenWidth * 0.2,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: screenWidth * 0.025,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double appBarHeight = AppBar().preferredSize.height;
    double blueBoxHeight = appBarHeight * 2.5;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // _loadUserData();
    // makeUnverfied();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(21, 101, 192, 1),
        elevation: 0,
        title: Text(
          'Hiremi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MainLayout(initialIndex: 5),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                width: screenWidth,
                height: status == true
                    ? blueBoxHeight + 0.2 * appBarHeight
                    : blueBoxHeight + 1.3 * appBarHeight,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(21, 101, 192, 1),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: screenWidth - 2 * 16.0,
                      decoration: BoxDecoration(
                        color: status == false
                            ? Color.fromARGB(4, 114, 227, 51)
                            : Colors.blue[400],
                        borderRadius: BorderRadius.circular(15),
                        border: status == false
                            ? Border.all(
                                color: Colors.white, width: screenWidth * 0.004)
                            : null,
                        boxShadow: status == false
                            ? [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ]
                            : [],
                      ),
                      padding: EdgeInsets.all(16),
                      child: status == true
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      username ?? 'Unknown',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue[900],
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'App ID : HM12434322',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.verified,
                                        color: Colors.blue[800],
                                        size: 20,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        'Verified',
                                        style: TextStyle(
                                          color: Colors.blue[800],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Verify your account',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.013),
                                Center(
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(width: screenWidth * 0.08),
                                            _buildCircleWithLine(
                                                1, true, screenWidth),
                                            _buildCircleWithLine(
                                                2, false, screenWidth),
                                            _buildCircleWithLine(
                                                3, false, screenWidth),
                                            _buildCircleWithLine(
                                                4, false, screenWidth,
                                                isLast: true),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: screenHeight * 0.01),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          _buildStepLabel(
                                              'Complete Profile', screenWidth),
                                          _buildStepLabel(
                                              'Verification Payment',
                                              screenWidth),
                                          _buildStepLabel(
                                              'Wait for Verification',
                                              screenWidth),
                                          _buildStepLabel('Get Lifetime Access',
                                              screenWidth),
                                        ],
                                      ),
                                      SizedBox(height: screenHeight * 0.01),
                                      Center(
                                        child: SizedBox(
                                          width: screenWidth * 0.7,
                                          height: screenHeight * 0.04,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              await _showVerificationDialog(
                                                  context);
                                              await makeUnverfied();
                                              await _loadUserData();
                                              final prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              await prefs.setBool(
                                                  'status', true);
                                              status = true;
                                              // print(prefs.getBool('status'));
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.verified,
                                                  color: Colors.blue[800],
                                                  size: screenWidth * 0.045,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  'Get Verified',
                                                  style: TextStyle(
                                                    fontSize:
                                                        screenWidth * 0.045,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue[800],
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.blue[800],
                                                  size: screenWidth * 0.033,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            ),

            // Slider
            Container(
              height: appBarHeight * 2,
              margin: EdgeInsets.only(
                top: 10,
                left: 20,
                right: 20,
              ),
              child: PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: List.generate(
                  4,
                  (index) => Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: 'Hiremi ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: '360',
                                  style: TextStyle(
                                    color: Colors.blue[800],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Career ka backup',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Success ka guarantee',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: _currentPage == index
                      ? CircleAvatar(
                          radius: 3,
                          backgroundColor: Colors.blue[800],
                        )
                      : Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                        ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 10, left: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Hiremi's Featured",
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: screenWidth * 0.05,
                  mainAxisSpacing: screenHeight * 0.02,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  String title, description;
                  Color startColor, endColor;
                  String imagePath;

                  if (index == 0) {
                    title = 'Ask Expert';
                    description = 'Ask Anything Get Expert Guidance';
                    endColor = Colors.blue.shade400;
                    startColor = Colors.lightBlue.shade100;
                    imagePath = 'assets/ask_expert.png';
                  } else if (index == 1) {
                    title = 'Internship';
                    description = 'Gain Practical Experience';
                    endColor = Colors.green.shade400;
                    startColor = Colors.lightGreen.shade100;
                    imagePath = 'assets/internship.png';
                  } else if (index == 2) {
                    title = 'Status';
                    description = 'Apply Mentorship & more';
                    endColor = Colors.pink.shade400;
                    startColor = Colors.pink.shade100;
                    imagePath = 'assets/status.png';
                  } else if (index == 3) {
                    title = 'Freshers';
                    description = 'Gain Practical Experience';
                    endColor = Colors.yellow.shade400;
                    startColor = Colors.yellow.shade100;
                    imagePath = 'assets/freshers.png';
                  } else if (index == 4) {
                    title = 'Hiremi 360';
                    description = 'Gain Practical Experience';
                    endColor = Colors.orange.shade400;
                    startColor = Colors.orange.shade100;
                    imagePath = 'assets/hiremi_360.png';
                  } else {
                    title = 'Experience';
                    description = 'Explore diverse careers';
                    endColor = Colors.purple.shade400;
                    startColor = Colors.purple.shade100;
                    imagePath = 'assets/experience.png';
                  }

                  void navigateToPage(int index) {
                    int targetIndex;
                    switch (index) {
                      case 0:
                        targetIndex = 2;
                        break;
                      case 1:
                        targetIndex = 1;
                        break;
                      case 2:
                        targetIndex = 3;
                        break;
                      case 3:
                        targetIndex = 1;
                        break;
                      case 4:
                        targetIndex = 4;
                        break;
                      case 5:
                        targetIndex = 1;
                        break;
                      default:
                        targetIndex = 0;
                    }

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MainLayout(initialIndex: targetIndex),
                      ),
                    );
                  }

                  return GestureDetector(
                    onTap: () => navigateToPage(index),
                    child: Container(
                      height: screenHeight * 0.2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            startColor,
                            Colors.white,
                            endColor,
                          ],
                          stops: [0.0, 0.65, 1.0],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    title,
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.04,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.005),
                                  Text(
                                    description,
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.035,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              imagePath,
                              width: screenWidth * 0.18,
                              height: screenHeight * 0.12,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 10, left: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Jobs for you",
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: selJobList.map((job) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10, horizontal: screenWidth * 0.05),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: SizedBox(
                          width: screenWidth * 0.75,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                job.title,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Text(
                                job.company,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.grey[600],
                                    size: screenWidth * 0.04,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    job.location,
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.04,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Row(
                                children: [
                                  Icon(
                                    Icons.currency_rupee,
                                    color: Colors.grey[600],
                                    size: screenWidth * 0.04,
                                  ),
                                  SizedBox(width: 8),
                                  job.minPay != job.maxPay
                                      ? Text(
                                          '₹${job.minPay} - ₹${job.maxPay}',
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.04,
                                            color: Colors.grey[600],
                                          ),
                                        )
                                      : Text(
                                          '₹${job.minPay}',
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.04,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
