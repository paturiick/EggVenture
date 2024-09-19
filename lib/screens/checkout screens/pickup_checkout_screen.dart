import 'package:eggventure/screens/checkout%20screens/address%20edit/edit_address_screen.dart';
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
    _addressController.text = "Macabalan, Cagayan de Oro City, Philippines";

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
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFF353E55)),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
          ),
          title: Text(
            "Pick-Up",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Color(0xFF353E55),
            ),
          ),
          centerTitle: true, // Center the title
        ),
        body: Padding(
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
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF353E55)),
    );
  }

  Widget _buildAddressInput(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditAddressScreen()),
        );
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
          style: TextStyle(fontSize: 16, color: Color(0xFF353E55)),
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
              style: TextStyle(fontSize: 16, color: Color(0xFF353E55)),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade200,
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
      ),
      value: _selectedTime,
      hint: Text("ASAP",
          style: TextStyle(fontSize: 16, color: Color(0xFF353E55))),
      items: _times.map((String time) {
        return DropdownMenuItem<String>(
          value: time,
          child: Text(time,
              style: TextStyle(fontSize: 16, color: Color(0xFF353E55))),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedTime = value;
        });
      },
    );
  }

  Widget _buildTotalPrice() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Color(0xFF353E55),
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
                    color: Color(0xFFF9B514)),
              ),
              Text(
                "Price Here",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF9B514)),
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
                color: Color(0xFF353E55),
                decoration: TextDecoration.underline,
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
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFF9B514),
          padding: EdgeInsets.symmetric(vertical: 16.0),
        ),
        onPressed: () {
          String userAddress = _addressController.text;
          print('Selected address: $userAddress');
        },
        child: Text(
          "Confirm Pick-up Date",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF353E55)),
        ),
      ),
    );
  }
}
