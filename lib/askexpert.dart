import 'package:flutter/material.dart';
import 'dart:ui';

class AskExpertScreen extends StatefulWidget {
  @override
  _AskExpertScreenState createState() => _AskExpertScreenState();
}

class _AskExpertScreenState extends State<AskExpertScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedGender;
  String? _queryType;
  String? fullName;
  String? email;
  String? subject;
  String? issueDescription;

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
            // Dialog content
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
                      'Thank you for submitting your query',
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
                        'Our Expert will contact you shortly',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: screenHeight * 0.016,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    SizedBox(
                      width: screenWidth * 0.2,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue[800],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.015),
                          child: Text('OK'),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 21, 101, 192),
                    Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: JobSlider(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Header(title: 'Full Name*'),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 15, 60, 201),
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 15, 60, 201),
                              width: 2.0,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          fullName = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      Header(title: "Email Address*"),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email Address*',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 15, 60, 201),
                                width: 2.0),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email address';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      Header(title: 'Gender'),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: RadioListTile<String>(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    'Male',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  value: 'Male',
                                  groupValue: _selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value;
                                    });
                                  },
                                  activeColor: Colors.blue[800],
                                  visualDensity: VisualDensity.compact,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: RadioListTile<String>(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    'Female',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  value: 'Female',
                                  groupValue: _selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value;
                                    });
                                  },
                                  activeColor: Colors.blue[800],
                                  visualDensity: VisualDensity.compact,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Header(title: "Subject*"),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Subject*',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          subject = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a subject';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      Header(title: "Query Type*"),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Select Query Type*',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'Career Guidance',
                            child: Text('Career Guidance'),
                          ),
                          DropdownMenuItem(
                            value: 'Internship & Job Search',
                            child: Text('Internship & Job Search'),
                          ),
                          DropdownMenuItem(
                            value: 'Skill Development',
                            child: Text('Skill Development'),
                          ),
                          DropdownMenuItem(
                            value: 'Exam Preparation',
                            child: Text('Exam Preparation'),
                          ),
                          DropdownMenuItem(
                            value: 'Career Transition',
                            child: Text('Career Transition'),
                          ),
                          DropdownMenuItem(
                            value: 'Freelancing or Entrepreneurship',
                            child: Text('Freelancing or Entrepreneurship'),
                          ),
                          DropdownMenuItem(
                            value: 'Other',
                            child: Text('Other'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _queryType = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a query type';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      Header(title: "Describe Your Issue (Optional)"),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Your Issue',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 4,
                        onChanged: (value) {
                          issueDescription = value;
                        },
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 21, 101, 192),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Map<String, String?> formData = {
                                  'fullName': fullName,
                                  'email': email,
                                  'gender': _selectedGender,
                                  'subject': subject,
                                  'queryType': _queryType,
                                  'issueDescription': issueDescription,
                                };

                                print(formData);

                                _showConfirmationDialog(context);
                              }
                            },
                            child: Text(
                              'Submit Your Query',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  final String title;
  const Header({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}

class JobSlider extends StatefulWidget {
  @override
  _JobSliderState createState() => _JobSliderState();
}

class _JobSliderState extends State<JobSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<String> items = [
    "assets/ask_expert1.png",
    "assets/ask_expert2.png",
    "assets/ask_expert3.png",
    "assets/ask_expert4.png",
    "assets/ask_expert5.png",
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), _autoScroll);
  }

  void _autoScroll() {
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        (_currentPage + 1) % items.length,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage = (_currentPage + 1) % items.length;
      });
      Future.delayed(Duration(seconds: 3), _autoScroll);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: PageView.builder(
        controller: _pageController,
        itemCount: null,
        itemBuilder: (context, index) {
          final currentIndex = index % items.length;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              items[currentIndex],
              fit: BoxFit.cover,
            ),
          );
        },
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
      ),
    );
  }
}
