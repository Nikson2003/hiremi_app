import 'dart:async';
import 'package:flutter/material.dart';
import 'menu.dart';
import 'jobs_list.dart';
import 'main_layout.dart';

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

  @override
  void initState() {
    super.initState();
    _startAutoSlide();

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

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double appBarHeight = AppBar().preferredSize.height;
    double blueBoxHeight = appBarHeight * 2.5;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
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
            Container(
              width: MediaQuery.of(context).size.width,
              height: blueBoxHeight,
              color: Colors.blue[800],
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 2 * 16.0,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 75, 155, 246),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nikson Nadar',
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle,
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
                  Color boxColor;
                  String imagePath;

                  if (index == 0) {
                    title = 'Ask Expert';
                    description = 'Ask Anything Get Expert Guidance';
                    boxColor =
                        Color.fromARGB(255, 21, 101, 192).withOpacity(0.4);
                    imagePath = 'assets/ask_expert.png';
                  } else if (index == 1) {
                    title = 'Internship';
                    description = 'Gain Practical Experience';
                    boxColor = Colors.green.withOpacity(0.4);
                    imagePath = 'assets/internship.png';
                  } else if (index == 2) {
                    title = 'Status';
                    description = 'Apply Mentorship & more';
                    boxColor = Colors.pink.withOpacity(0.4);
                    imagePath = 'assets/status.png';
                  } else if (index == 3) {
                    title = 'Freshers';
                    description = 'Gain Practical Experience';
                    boxColor = Colors.yellow.withOpacity(0.4);
                    imagePath = 'assets/freshers.png';
                  } else if (index == 4) {
                    title = 'Hiremi 360';
                    description = 'Gain Practical Experience';
                    boxColor = Colors.orange.withOpacity(0.4);
                    imagePath = 'assets/hiremi_360.png';
                  } else {
                    title = 'Experience';
                    description = 'Explore diverse careers';
                    boxColor = Colors.purple.withOpacity(0.4);
                    imagePath = 'assets/experience.png';
                  }

                  return GestureDetector(
                    onTap: () {
                      // print('Box $index clicked');
                    },
                    child: Container(
                      height: screenHeight * 0.2,
                      decoration: BoxDecoration(
                        color: boxColor,
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
