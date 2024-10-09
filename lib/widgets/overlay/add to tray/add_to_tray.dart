import 'package:eggventure/constants/colors.dart';
import 'package:flutter/material.dart';

class AddToTrayScreen {
  static void showAddToTrayScreen(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.6,
          minChildSize: 0.4,
          builder: (context, scrollController) {
            return AddToTrayContent(scrollController: scrollController);
          },
        );
      },
    );
  }
}

class AddToTrayContent extends StatefulWidget {
  final ScrollController scrollController;

  const AddToTrayContent({Key? key, required this.scrollController})
      : super(key: key);

  @override
  _AddToTrayContentState createState() => _AddToTrayContentState();
}

class _AddToTrayContentState extends State<AddToTrayContent> {
  // Track the checkbox and counter states for each egg tray
  List<bool> _isChecked = List.filled(4, false);
  List<int> _counters = List.filled(4, 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              controller: widget.scrollController,
              children: [
                _buildTrayItem(0, "Small Egg Tray", "P 140",
                    "assets/browse store/small_eggs.jpg"),
                _buildTrayItem(1, "Medium Egg Tray", "P 180",
                    "assets/browse store/medium_eggs.jpg"),
                _buildTrayItem(2, "Large Egg Tray", "P 220",
                    "assets/browse store/large_eggs.jpeg"),
                _buildTrayItem(3, "XL Egg Tray", "P 250",
                    "assets/browse store/xl_eggs.jpg"),
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: BorderSide(color: Colors.red),
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle the Add to Cart functionality here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFB612),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Add To Tray',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF353E55),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrayItem(
      int index, String title, String price, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Checkbox(
            value: _isChecked[index],
            onChanged: (value) {
              setState(() {
                _isChecked[index] = value!;
              });
            },
            activeColor: AppColors.YELLOW,
          ),
          Column(
            children: [
              Image.asset(
                imagePath,
                width: 50,
                height: 50,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 5),
              Text(
                price,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFFFB612),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(width: 20),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF353E55),
              ),
            ),
          ),
          _buildCounter(index),
        ],
      ),
    );
  }

  Widget _buildCounter(int index) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              color: Color(0xFF353E55),
              onPressed: () {
                if (_counters[index] > 0) {
                  setState(() {
                    _counters[index]--;
                  });
                }
              },
            ),
            Text(
              '${_counters[index]}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF353E55),
              ),
            ),
            IconButton(
              icon: Icon(Icons.add),
              color: Color(0xFFFFB612),
              onPressed: () {
                setState(() {
                  _counters[index]++;
                });
              },
            ),
          ],
        );
      },
    );
  }
}
