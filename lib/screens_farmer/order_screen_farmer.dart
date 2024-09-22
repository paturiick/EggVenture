import 'package:flutter/material.dart';
import 'package:eggventure/widgets/navigation_bar_farmer.dart';
import 'package:intl/intl.dart';

class OrderScreenFarmer extends StatefulWidget {
  @override
  _OrderScreenFarmerState createState() => _OrderScreenFarmerState();
}

class _OrderScreenFarmerState extends State<OrderScreenFarmer>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTimeRange? selectedDateRange;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Function to select a date range
  Future<void> _selectDateRange() async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
      initialDateRange: selectedDateRange,
    );

    if (picked != null) {
      setState(() {
        selectedDateRange = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Orders',
              style: TextStyle(
                fontFamily: 'AvenirNextCyr',
                fontWeight: FontWeight.bold,
                fontSize: 30,
                height: 1.2,
                color: Color(0xFF353E55),
              ),
            ),
            SizedBox(height: 5),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              decoration: BoxDecoration(
                color: Color(0xFF353E55),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search orders...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Color(0xFFF5F5F5),
              ),
            ),
            SizedBox(height: 10),
            // Date range picker button under the search bar
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: _selectDateRange,
                child: Text(
                  selectedDateRange == null
                      ? 'Select Date'
                      : '${DateFormat('yyyy/MM/dd').format(selectedDateRange!.start)} - ${DateFormat('yyyy/MM/dd').format(selectedDateRange!.end)}',
                ),
              ),
            ),
            SizedBox(height: 20),

            // TabBar for different order statuses
            TabBar(
              controller: _tabController,
              labelColor: Color(0xFF353E55),
              unselectedLabelColor: Colors.grey,
              indicatorColor: Color(0xFF353E55),
              tabs: [
                Tab(text: 'All'),
                Tab(text: 'To Process'),
                Tab(text: 'Processed'),
              ],
            ),
            SizedBox(height: 20),

            // Order List
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildOrderList(),
                  _buildOrderList(),
                  _buildOrderList(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBarWidgetFarmer(currentIndex: 1),
    );
  }

  // Function to display order list based on tab
  Widget _buildOrderList() {
    // Dummy order data (replace with your actual data logic)
    List<Map<String, String>> orders = [
      {
        'product': 'Medium Egg Tray',
        'quantity': '1',
        'price': '160',
        'status': 'To Deliver',
        'user': '"Name of the Consumer"',
        'productImage': 'assets/browse store/medium_eggs.jpg',
      },
    ];

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.amberAccent, width: 1.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                // User name with blank profile icon
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors
                          .grey[300], // Light grey for a placeholder color
                      radius: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      orders[index]['user']!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.message_outlined), // Chat icon
                  ],
                ),

                SizedBox(height: 10),

                // Column labels: Product(s), Total Price, Actions
                Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          'Product(s)',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Total Price',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Actions',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),

                // Product row details
                Row(
                  children: [
                    // Product image
                    Image.asset(
                      orders[index]['productImage']!,
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 10),

                    // Product info
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            orders[index]['product']!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "Size : Medium",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            "x${orders[index]['quantity']}",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),

                    // Price info
                    Expanded(
                      flex: 2,
                      child: Text(
                        orders[index]['price']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    // Status (Actions)
                    Expanded(
                      flex: 2,
                      child: Text(
                        orders[index]['status']!,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
