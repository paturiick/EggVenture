import 'package:eggventure/widgets/add%20to%20tray%20widgets/counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/models/tray_item.dart';

class CheckboxItemWidget extends StatelessWidget {
  final TrayItem item;
  final bool isChecked;
  final int counter;
  final Function(bool?) onCheckboxChanged;
  final Function(int) onIncrement;
  final Function(int) onDecrement;

  const CheckboxItemWidget({
    Key? key,
    required this.item,
    required this.isChecked,
    required this.counter,
    required this.onCheckboxChanged,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Checkbox(
            value: isChecked,
            onChanged: onCheckboxChanged,
            activeColor: AppColors.YELLOW,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.YELLOW,
                    ),
                    borderRadius: BorderRadius.circular(8.0)),
                child: Image.asset(
                  item.imagePath,
                  width: screenWidth * 0.12,
                  height: screenHeight * 0.06,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              SizedBox(width: screenWidth * 0.02),
            ],
          ),
          SizedBox(width: screenWidth * 0.001),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.03,
                  color: AppColors.BLUE,
                ),
              ),
              Text(
                'P ${item.price.toString()}',
                style: TextStyle(
                  fontSize: screenWidth * 0.03,
                  color: AppColors.YELLOW,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
          CounterWidget(
            index: item.id,
            counter: counter,
            onIncrement: onIncrement,
            onDecrement: onDecrement,
          ),
        ],
      ),
    );
  }
}
