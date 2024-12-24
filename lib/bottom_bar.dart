import 'package:flutter/material.dart';
import 'main_layout.dart';

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
          6,
          (index) => GestureDetector(
            onTap: () {
              onItemSelected(index);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  index == 0
                      ? Icons.home
                      : index == 1
                          ? Icons.work
                          : index == 2
                              ? Icons.chat
                              : index == 3
                                  ? Icons.checklist
                                  : index == 4
                                      ? Icons.loop
                                      : Icons.notifications,
                  color:
                      selectedIndex == index ? Colors.blue[800] : Colors.grey,
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
