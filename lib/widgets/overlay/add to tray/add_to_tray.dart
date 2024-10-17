import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/controller/add_to_tray_controller.dart';
import 'package:eggventure/providers/add_to_tray_provider.dart';
import 'package:eggventure/models/tray_item.dart';
import 'package:eggventure/widgets/overlay/add%20to%20tray/error_to_add_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  List<TrayItem> trayItems = [
    TrayItem(
        id: 0,
        name: "Small Egg Tray",
        price: "P 140",
        imagePath: "assets/browse store/small_eggs.jpg"),
    TrayItem(
        id: 1,
        name: "Medium Egg Tray",
        price: "P 180",
        imagePath: "assets/browse store/medium_eggs.jpg"),
    TrayItem(
        id: 2,
        name: "Large Egg Tray",
        price: "P 220",
        imagePath: "assets/browse store/large_eggs.jpeg"),
    TrayItem(
        id: 3,
        name: "XL Egg Tray",
        price: "P 250",
        imagePath: "assets/browse store/xl_eggs.jpg"),
  ];
  List<TrayItem> checkedItems = [];

  @override
  Widget build(BuildContext context) {
    final trayProvider = Provider.of<AddToTrayProvider>(context);

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
              children: trayItems.map((item) => _buildTrayItem(item)).toList(),
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
                  _isChecked.asMap().entries.map((entry) {
                    int index = entry.key;
                    bool isChecked = entry.value;

                    if (isChecked && _counters[index] > 0) {
                      checkedItems.add(trayItems[index]);
                      checkedItems.forEach((item) {
                        trayProvider.trayItems.add(item);
                      });
                      Navigator.of(context).pop();
                    } else {
                      ErrorToAddWidget();
                    }
                  }).toList();
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

  Widget _buildTrayItem(TrayItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Checkbox(
            value: _isChecked[item.id],
            onChanged: (value) {
              setState(() {
                _isChecked[item.id] = value!;
              });
            },
            activeColor: AppColors.YELLOW,
          ),
          Column(
            children: [
              Image.asset(
                item.imagePath,
                width: 50,
                height: 50,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 5),
              Text(
                item.price,
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
              item.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF353E55),
              ),
            ),
          ),
          _buildCounter(item.id),
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
