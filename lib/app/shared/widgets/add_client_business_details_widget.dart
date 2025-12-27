
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

class AddClientDetailsWidget extends StatefulWidget {
  final List<Widget> myWidgets;

  const AddClientDetailsWidget({
    super.key,
    required this.myWidgets,
  });

  @override
  _AddClientDetailsWidgetState createState() => _AddClientDetailsWidgetState();
}

class _AddClientDetailsWidgetState extends State<AddClientDetailsWidget> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.40,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: widget.myWidgets.length,
              onPageChanged: (int index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                // display the data for the client email
                return widget.myWidgets[index];
              },
            ),
          ),
          PageViewDotIndicator(
            currentItem: _currentPageIndex,
            count: widget.myWidgets.length,
            unselectedColor: const Color(0xFFD4D4D4),
            selectedColor: const Color(0xFF667EEA),
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}
