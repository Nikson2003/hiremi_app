import 'package:flutter/material.dart';
import 'jobs_list.dart';
import 'job_description.dart';
import 'dart:ui';

class JobsMainPage extends StatefulWidget {
  @override
  _JobsMainPageState createState() => _JobsMainPageState();
}

class _JobsMainPageState extends State<JobsMainPage> {
  List<bool> _isSelected = [true, true, true];
  bool _isFilterSelected = false;

  List<String> options = [
    'Software Development',
    'Business Development',
    'Product Management',
    'Human Resources'
  ];
  List<bool> _isSelected2 = [true, false, false, false, false];

  JobsList jobsList = JobsList();

  List<Job> _filteredJobs = [];

  List<Job> _appliedJobs = [];

  int days = 6;

  void _applyFilters() {
    setState(() {
      if (!_isSelected.contains(true)) {
        _filteredJobs = jobsList.jobs;
        return;
      }

      _filteredJobs = jobsList.jobs.where((job) {
        if (_isSelected[0] && job.type == JobType.Internship) return true;
        if (_isSelected[1] && job.type == JobType.Freshers) return true;
        if (_isSelected[2] && job.type == JobType.Experienced) return true;
        return false;
      }).toList();
    });
  }

  void filterJobs(JobType type) {
    setState(() {
      _filteredJobs = jobsList.jobs.where((job) => job.type == type).toList();
    });
  }

  @override
  void initState() {
    super.initState();

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

    _filteredJobs = jobsList.jobs;
  }

  Widget _buildTag(
      String text, Color color, double screenWidth, double screenHeight) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.02,
        vertical: screenHeight * 0.008,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(screenHeight * 0.01),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: screenHeight * 0.011,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _showApplyDialog(Job job, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: Colors.black.withOpacity(0),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/apply_q.png',
                        height: screenHeight * 0.15,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        'Are you sure you want to apply for this opportunity?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: screenHeight * 0.018,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightBlue,
                                  padding: EdgeInsets.symmetric(
                                    vertical: screenHeight * 0.015,
                                  ),
                                ),
                                child: Text('Cancel'),
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.1),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  _appliedJobs.add(job);
                                  print(_appliedJobs);
                                  _showConfirmationDialog(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[800],
                                  padding: EdgeInsets.symmetric(
                                    vertical: screenHeight * 0.015,
                                  ),
                                ),
                                child: Text('Yes, Apply'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showConfirmationDialog(BuildContext context) {
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
                contentPadding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/apply_confirm.png',
                      height: screenHeight * 0.2,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      'Thank you for applying at Hiremi',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenHeight * 0.02,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.blue[800]?.withOpacity(0.2) ??
                          Colors.blue[600]!.withOpacity(0.2),
                      child: Text(
                        'You\'ve successfully applied for this job',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: screenHeight * 0.016,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'If ',
                        style: TextStyle(
                          fontSize: screenHeight * 0.016,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: 'selected',
                            style: TextStyle(
                              fontSize: screenHeight * 0.016,
                              color: Colors.green,
                            ),
                          ),
                          TextSpan(
                            text: ', you will be contacted via ',
                            style: TextStyle(
                              fontSize: screenHeight * 0.016,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'email',
                            style: TextStyle(
                              fontSize: screenHeight * 0.016,
                              color: Colors.green,
                            ),
                          ),
                          TextSpan(
                            text: ' with further details',
                            style: TextStyle(
                              fontSize: screenHeight * 0.016,
                              color: Colors.black,
                            ),
                          ),
                        ],
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
                          child: Text('Browse More Jobs'),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      'Applied Date: 22/12/2024',
                      style: TextStyle(
                        fontSize: screenHeight * 0.014,
                        color: Colors.grey[600],
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

  @override
  Widget build(BuildContext context) {
    List<Job> filteredJobs = jobsList.filterJobs(_isSelected);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    int count = 10;

    String _getMainType(Job job) {
      if (job is Internship) {
        return 'internship';
      }

      if (job.minYearsOfExperience < 1) {
        return 'fresher';
      } else if (job.minYearsOfExperience < 4) {
        return 'associate';
      } else if (job.minYearsOfExperience <= 7) {
        return 'senior';
      } else {
        return 'experienced';
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenHeight * 0.013),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isSelected[0] = !_isSelected[0];
                          _applyFilters();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _isSelected[0] ? Colors.blue[800] : Colors.white,
                        side: BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Internships',
                        style: TextStyle(
                          color: _isSelected[0] ? Colors.white : Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isSelected[1] = !_isSelected[1];
                          _applyFilters();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _isSelected[1] ? Colors.blue[800] : Colors.white,
                        side: BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Freshers',
                        style: TextStyle(
                          color: _isSelected[1] ? Colors.white : Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isSelected[2] = !_isSelected[2];
                          _applyFilters();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _isSelected[2] ? Colors.blue[800] : Colors.white,
                        side: BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Experienced',
                        style: TextStyle(
                          color: _isSelected[2] ? Colors.white : Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  bottom: screenHeight * 0.03,
                ),
                child: Row(
                  children: [
                    Container(
                      width: screenWidth * 0.75,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.01,
                            horizontal: screenWidth * 0.02,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    Container(
                      decoration: BoxDecoration(
                        color:
                            _isFilterSelected ? Colors.blue[800] : Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _isFilterSelected = !_isFilterSelected;
                          });
                        },
                        icon: Icon(Icons.filter_list, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      options.length + 1,
                      (index) => Padding(
                        padding: EdgeInsets.only(right: screenWidth * 0.04),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (index == 0) {
                                _isSelected2 = List<bool>.filled(
                                    options.length + 1, false);
                                _isSelected2[0] = true;
                              } else {
                                _isSelected2[0] = false;
                                _isSelected2[index] = !_isSelected2[index];
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isSelected2[index]
                                ? Colors.blue[800]
                                : Colors.white,
                            side: BorderSide(color: Colors.black),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            index == 0 ? 'All' : options[index - 1],
                            style: TextStyle(
                              color: _isSelected2[index]
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.01, left: screenWidth * 0.01),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Available jobs (${_filteredJobs.length})",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              // Dynamic Job Listing
              _filteredJobs.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/no_jobs.png',
                            width: screenWidth * 0.5,
                            height: screenHeight * 0.3,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Text(
                            "Hiremi's Recruiters are planning for new jobs and roles, please wait for few days",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: screenHeight * 0.02,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: _filteredJobs.map((job) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.01),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      JobDescriptionPage(job: job),
                                ),
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(screenHeight * 0.01),
                              ),
                              elevation: 3,
                              child: SizedBox(
                                width: screenWidth * 0.95,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: screenHeight * 0.02,
                                    top: screenHeight * 0.02,
                                    bottom: screenHeight * 0.02,
                                    right: screenHeight * 0.01,
                                  ),
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            job.title,
                                            style: TextStyle(
                                              fontSize: screenHeight * 0.022,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: screenHeight * 0.01),
                                          Text(
                                            job.company,
                                            style: TextStyle(
                                              fontSize: screenHeight * 0.013,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                          SizedBox(height: screenHeight * 0.01),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: Colors.grey[600],
                                                size: screenHeight * 0.013,
                                              ),
                                              SizedBox(
                                                  width: screenWidth * 0.02),
                                              Text(
                                                job.location,
                                                style: TextStyle(
                                                  fontSize:
                                                      screenHeight * 0.013,
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
                                                size: screenHeight * 0.012,
                                              ),
                                              SizedBox(
                                                  width: screenWidth * 0.02),
                                              job.minPay != job.maxPay
                                                  ? Text(
                                                      '₹${job.minPay} - ₹${job.maxPay}',
                                                      style: TextStyle(
                                                        fontSize: screenHeight *
                                                            0.012,
                                                        color: Colors.grey[600],
                                                      ),
                                                    )
                                                  : Text(
                                                      '₹${job.minPay}',
                                                      style: TextStyle(
                                                        fontSize: screenHeight *
                                                            0.012,
                                                        color: Colors.grey[600],
                                                      ),
                                                    ),
                                            ],
                                          ),
                                          SizedBox(
                                              height: screenHeight * 0.015),
                                          Wrap(
                                            spacing: screenWidth * 0.01,
                                            runSpacing: screenHeight * 0.002,
                                            children: [
                                              _buildTag(
                                                job.type
                                                    .toString()
                                                    .split('.')
                                                    .last
                                                    .toUpperCase(),
                                                Color.fromARGB(
                                                    255, 21, 101, 192),
                                                screenWidth,
                                                screenHeight,
                                              ),
                                              _buildTag(
                                                _getMainType(job).toUpperCase(),
                                                Colors.green,
                                                screenWidth,
                                                screenHeight,
                                              ),
                                              _buildTag(
                                                '${job.minYearsOfExperience} Years Exp',
                                                Colors.orange,
                                                screenWidth,
                                                screenHeight,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: screenHeight * 0.02),
                                        ],
                                      ),
                                      Positioned(
                                        top: screenHeight * 0.095,
                                        right: screenWidth * 0.01,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _showApplyDialog(job, context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color.fromARGB(
                                                255, 21, 101, 192),
                                          ),
                                          child: Text('Apply Now  >'),
                                        ),
                                      ),
                                      SizedBox(height: screenHeight * 0.18),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Divider(
                                              thickness: 1,
                                              color: Colors.grey[300],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      screenWidth * 0.02),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Actively Recruiting",
                                                    style: TextStyle(
                                                      fontSize:
                                                          screenHeight * 0.014,
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    "$days days ago",
                                                    style: TextStyle(
                                                      fontSize:
                                                          screenHeight * 0.014,
                                                      color: Colors.grey[500],
                                                    ),
                                                  ),
                                                ],
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
                        );
                      }).toList(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
