import 'package:flutter/material.dart';
import 'package:eggventure/widgets/navigation_bar.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ManageProfilePage(),
    );
  }
}

class ManageProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MANAGE PROFILE'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end, 
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.store),
                  label: Text('Start Selling'),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/joel.jpg'), 
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return Icon(Icons.star, color: Colors.yellow);
                  }),
                ),
                SizedBox(height: 10),
                Text(
                  'Joel Sabuero',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildProfileInfo('follower', '10'),
                    _buildProfileInfo('following', '10'),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Edit profile'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.black,
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Share Profile'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTabItem(Icons.payment, 'To Pay'),
                _buildTabItem(Icons.local_shipping, 'Processing'),
                _buildTabItem(Icons.reviews, 'Review'),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBarWidget(currentIndex: 4),
    );
  }

  Widget _buildProfileInfo(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(title),
        ],
      ),
    );
  }

  Widget _buildTabItem(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 30),
        Text(label),
      ],
    );
  }
}
