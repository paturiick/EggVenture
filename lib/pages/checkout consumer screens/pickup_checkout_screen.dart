import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PickupCheckoutScreen extends StatefulWidget {
  @override
  _PickupCheckoutScreenState createState() => _PickupCheckoutScreenState();
}

class _PickupCheckoutScreenState extends State<PickupCheckoutScreen> {
  DateTime? _selectedDate;
  String? _selectedTime;
  final List<String> _times = [
    "ASAP",
    "9:00 AM",
    "10:00 AM",
    "11:00 AM",
    "12:00 PM",
    "1:00 PM",
    "2:00 PM",
    "3:00 PM",
    "4:00 PM"
  ];
  TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _addressController.text = "Input Address Here...";

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0, // No built-in elevation
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: AppColors.BLUE),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.HOMESCREEN);
                  },
                ),
                title: Text(
                  "Pick-Up",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: AppColors.BLUE,
                  ),
                ),
                centerTitle: true,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("Store Address"),
                    const SizedBox(height: 8),
                    _buildAddressInput(context),
                    const SizedBox(height: 20),
                    _buildSectionTitle("Pick-up Date"),
                    const SizedBox(height: 8),
                    _buildDatePicker(context),
                    const SizedBox(height: 20),
                    _buildSectionTitle("Pick-up Time"),
                    const SizedBox(height: 8),
                    _buildTimePicker(context),
                    const SizedBox(height: 40),
                    _buildTotalPrice(),
                    const SizedBox(height: 8),
                    _buildTermsAndConditions(),
                    const Spacer(),
                    _buildConfirmButton(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.BLUE),
    );
  }

  Widget _buildAddressInput(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.PICKUPEDITINFO);
      },
      child: AbsorbPointer(
        child: TextField(
          controller: _addressController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade200,
            contentPadding:
                EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            hintText: 'Enter your address',
          ),
          style: TextStyle(fontSize: 16, color: AppColors.BLUE),
        ),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return InkWell(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: _selectedDate ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          setState(() {
            _selectedDate = pickedDate;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedDate == null
                  ? "Today, ${DateFormat.yMMMMd().format(DateTime.now())}"
                  : DateFormat.yMMMMd().format(_selectedDate!),
              style: TextStyle(fontSize: 16, color: AppColors.BLUE),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            String? tempSelectedTime = _selectedTime;
            return Container(
              height: 300,
              child: Column(
                children: [
                  Expanded(
                    child: ListWheelScrollView(
                      itemExtent: 50.0,
                      physics: FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (int index) {
                        tempSelectedTime = _times[index];
                      },
                      children: _times.map((String time) {
                        return Center(
                          child: Text(
                            time,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: AppColors.BLUE,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedTime = tempSelectedTime;
                      });
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15.0, horizontal: 25),
                      child: Text(
                        'Done',
                        style: TextStyle(
                          color: AppColors.BLUE,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.YELLOW,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            );
          },
        ).whenComplete(() {
          if (_selectedTime == null) {
            setState(() {
              _selectedTime = "Select a time";
            });
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedTime ?? "Select a time",
              style: TextStyle(fontSize: 16, color: AppColors.BLUE),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalPrice() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: AppColors.BLUE,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Price",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.YELLOW),
              ),
              Text(
                "Price Here",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.YELLOW),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Center(
      child: Column(
        children: [
          Text(
            "By completing this order, I agree to all",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          GestureDetector(
            onTap: () {
              // Handle navigation to Terms and Conditions
            },
            child: Text(
              "Terms and Conditions",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.BLUE,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Handle order confirmation
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            'Confirm',
            style: TextStyle(
              color: AppColors.BLUE,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.YELLOW,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
