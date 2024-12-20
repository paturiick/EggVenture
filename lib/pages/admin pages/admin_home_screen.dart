import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/widgets/navigation%20bars/navigation_bar_admin.dart';
import 'package:eggventure/pages/admin%20pages/userDetails/user_details_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int _userCount = 0;
  int _businessCount = 0;
  bool _isLoading = true;
  List<String> _userIds = [];

  @override
  void initState() {
    super.initState();
    _fetchCounts();
  }

  Future<void> _fetchCounts() async {
    setState(() => _isLoading = true);
    try {
      FirebaseFirestore.instance
          .collection('userDetails')
          .snapshots()
          .listen((userSnapshot) {
        setState(() {
          _userCount = userSnapshot.docs.length;
          _userIds = userSnapshot.docs.map((doc) => doc.id).toList();
        });
      });

      FirebaseFirestore.instance
          .collection('businessDetails')
          .snapshots()
          .listen((businessSnapshot) {
        setState(() {
          _businessCount = businessSnapshot.docs.length;
        });
      });
    } catch (error) {
      setState(() => _isLoading = false);
      _showErrorDialog('Failed to fetch data: $error');
    }
    setState(() => _isLoading = false);
  }

  Future<void> _deleteUser(String userId) async {
    try {
      await FirebaseFirestore.instance
          .collection('userDetails')
          .doc(userId)
          .delete();
      setState(() {
        _userIds.remove(userId);
        _userCount--;
      });
      _showSuccessDialog('User removed successfully.');
    } catch (error) {
      _showErrorDialog('Failed to remove user: $error');
    }
  }

  void _confirmDeleteUser(String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          'Remove User',
          style: TextStyle(color: AppColors.BLUE),
        ),
        content: Text('Are you sure you want to remove this user?',
            style: TextStyle(color: AppColors.BLUE)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: AppColors.RED)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteUser(userId);
            },
            child: Text('Remove', style: TextStyle(color: AppColors.RED)),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          'Error',
          style: TextStyle(color: AppColors.RED),
        ),
        content: Text(errorMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: TextStyle(color: AppColors.YELLOW),
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          'Success',
          style: TextStyle(color: AppColors.BLUE),
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: TextStyle(color: AppColors.BLUE),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCircularStat(
      String title, dynamic value, Color color, double size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: size,
              height: size,
              child: CircularProgressIndicator(
                value: 1.0, // Fully filled circle
                strokeWidth: 8.0,
                color: color,
                backgroundColor: Colors.grey[200],
              ),
            ),
            Text(
              value.toString(),
              style: TextStyle(
                fontSize: size * 0.3,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: size * 0.2,
            color: AppColors.BLUE,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              // AppBar Section
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.BLUE.withOpacity(0.2),
                      offset: Offset(0, 2),
                      blurRadius: 5,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  title: Text(
                    "Dashboard",
                    style: TextStyle(
                      fontSize: screenWidth * 0.07,
                      fontWeight: FontWeight.bold,
                      color: AppColors.BLUE,
                    ),
                  ),
                  centerTitle: true,
                ),
              ),

              // Main Content
              Expanded(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // System Overview Header
                              Text(
                                'System Overview',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.05,
                                  color: AppColors.BLUE,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20),

                              // Circular Stats Section
                              SizedBox(
                                height: 200, // Adjust height as needed
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    buildCircularStat('Users', _userCount,
                                        AppColors.YELLOW, 120),
                                    buildCircularStat('Businesses',
                                        _businessCount, AppColors.YELLOW, 120),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              // Refresh Button
                              Center(
                                child: ElevatedButton.icon(
                                  onPressed: _fetchCounts,
                                  icon: Icon(
                                    Icons.refresh,
                                    color: AppColors.BLUE,
                                  ),
                                  label: Text(
                                    'Refresh Data',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.03,
                                      color: AppColors.BLUE,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.YELLOW,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              // User IDs List
                              Text(
                                'User Details',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.05,
                                  color: AppColors.BLUE,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: _userIds.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      UserDetailsDialog.show(
                                          context, _userIds[index]);
                                    },
                                    child: ListTile(
                                      title: Text(
                                        _userIds[index],
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.BLUE,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () =>
                                            _confirmDeleteUser(_userIds[index]),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
        // Bottom Navigation Bar
        bottomNavigationBar: NavigationBarAdmin(currentIndex: 0),
      ),
    );
  }
}
