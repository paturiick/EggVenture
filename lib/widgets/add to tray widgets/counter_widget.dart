// counter_widget.dart
import 'package:flutter/material.dart';
import 'package:eggventure/constants/colors.dart';

class CounterWidget extends StatefulWidget {
  final int index;
  final int counter;
  final Function(int) onIncrement;
  final Function(int) onDecrement;

  const CounterWidget({
    Key? key,
    required this.index,
    required this.counter,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Row(
      children: [
        Container(
          width: screenWidth * 0.05,
          height: screenHeight * 0.03,
          decoration: BoxDecoration(
            color: AppColors.BLUE,
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Center(
            child: IconButton(
              icon: Icon(
                Icons.remove,
                size: screenWidth * 0.05,
              ),
              padding: EdgeInsets.all(0),
              constraints: BoxConstraints(),
              color: AppColors.YELLOW,
              onPressed: () {
                if (widget.counter > 0) {
                  widget.onDecrement(widget.index);
                }
              },
            ),
          ),
        ),
        SizedBox(
          width: screenWidth * 0.02,
        ),
        Text(
          '${widget.counter}',
          style: TextStyle(
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.bold,
            color: AppColors.BLUE,
          ),
        ),
        SizedBox(
          width: screenWidth * 0.02,
        ),
        Container(
          width: screenWidth * 0.05,
          height: screenHeight * 0.03,
          decoration: BoxDecoration(
            color: AppColors.YELLOW,
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Center(
            child: IconButton(
              icon: Icon(
                Icons.add,
                size: screenWidth * 0.05,
              ),
              padding: EdgeInsets.all(0),
              constraints: BoxConstraints(),
              color: AppColors.BLUE,
              onPressed: () {
                widget.onIncrement(widget.index);
              },
            ),
          ),
        ),
      ],
    );
  }
}
