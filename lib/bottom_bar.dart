import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  BottomBar({required this.selectedIndex, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              onItemSelected(index);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                index == 0
                    ? Icon(
                        Icons.home,
                        color: selectedIndex == index
                            ? Colors.blue[800]
                            : Colors.grey,
                        size: 28,
                      )
                    : index == 1
                        ? SvgPicture.asset(
                            'assets/bottom_bar/jobs.svg',
                            color: selectedIndex == index
                                ? Colors.blue[800]
                                : Colors.grey,
                            height: 28,
                          )
                        : index == 2
                            ? SvgPicture.asset(
                                'assets/bottom_bar/ask_expert.svg',
                                color: selectedIndex == index
                                    ? Colors.blue[800]
                                    : Colors.grey,
                                height: 28,
                              )
                            : index == 3
                                ? SvgPicture.asset(
                                    'assets/bottom_bar/status.svg',
                                    color: selectedIndex == index
                                        ? Colors.blue[800]
                                        : Colors.grey,
                                    height: 28,
                                  )
                                : index == 4
                                    ? Image.asset(
                                        'assets/bottom_bar/hiremi_360.png',
                                        height: 28,
                                      )
                                    : Icon(
                                        Icons.notifications,
                                        color: selectedIndex == index
                                            ? Colors.blue[800]
                                            : Colors.grey,
                                        size: 28,
                                      ),
                SizedBox(height: 2),
                Text(
                  index == 0
                      ? 'Home'
                      : index == 1
                          ? 'Jobs'
                          : index == 2
                              ? 'Ask Expert'
                              : index == 3
                                  ? 'Status'
                                  : index == 4
                                      ? '360'
                                      : 'Notifications',
                  style: TextStyle(
                    color:
                        selectedIndex == index ? Colors.blue[800] : Colors.grey,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
