import 'package:flutter/material.dart';

class ProfileScreenReview extends StatefulWidget {
  @override
  _ProfileScreenReviewState createState() => _ProfileScreenReviewState();
}

class _ProfileScreenReviewState extends State<ProfileScreenReview>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFB612),
        title: Text(
          'Review Center',
          style: TextStyle(
            fontFamily: 'AvenirNextCyr',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFF353E55),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Color(0xFF353E55),
            indicatorColor: Color(0xFFFFB612),
            tabs: [
              Tab(text: 'Awaiting Review (2)'),
              Tab(text: 'Reviewed'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                AwaitingReviewTab(),
                ReviewedTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AwaitingReviewTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ReviewItem(
          imageUrl: 'assets/browse store/small_eggs.jpg',
          title: 'Small Egg Tray',
          quantity: 1,
          size: 'Small',
          buttonText: 'Review',
        ),
        ReviewItem(
          imageUrl: 'assets/browse store/large_eggs.jpeg',
          title: 'Large Egg Tray',
          quantity: 1,
          size: 'Large',
          buttonText: 'Review',
        ),
      ],
    );
  }
}

class ReviewedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ReviewItem(
          imageUrl:
              'assets/browse store/medium_eggs.jpg', // Replace with your own image URL
          title: 'Medium Egg Tray',
          quantity: 1,
          size: 'Medium',
        ),
      ],
    );
  }
}

class ReviewItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int quantity;
  final String size;
  final String? buttonText;

  ReviewItem({
    required this.imageUrl,
    required this.title,
    required this.quantity,
    required this.size,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: ListTile(
        leading: Image.asset(imageUrl),
        title: Text(title),
        subtitle: Text('Qty: $quantity\nSize: $size'),
        trailing: buttonText != null
            ? ElevatedButton(
                onPressed: () {
                  // Implement review action
                },
                child: Text(buttonText!),
              )
            : null,
      ),
    );
  }
}
