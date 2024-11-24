import 'dart:math';
import 'package:flutter/material.dart';
import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/models/store_list.dart'; // Import the model file

class HomeSearchScreen extends StatefulWidget {
  @override
  _HomeSearchScreenState createState() => _HomeSearchScreenState();
}

class _HomeSearchScreenState extends State<HomeSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<StoreList> popularStores = [];
  List<StoreList> displayedStores = [];

  @override
  void initState() {
    super.initState();
    _randomizePopularStores();
    displayedStores = popularStores;
  }

  void _randomizePopularStores() {
    setState(() {
      popularStores = [...store]..shuffle(Random());
      popularStores =
          popularStores.take(3).toList();
    });
  }

  void _filterStores(String query) {
    final lowerCaseQuery = query.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        displayedStores = popularStores;
      } else {
        // Show all matching stores
        displayedStores = store
            .where((storeItem) =>
                storeItem.name.toLowerCase().contains(lowerCaseQuery))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text(
            "Browse for Stores",
            style: TextStyle(
              fontSize: screenWidth * 0.05,
              color: AppColors.BLUE,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: TextStyle(color: AppColors.BLUE),
                      decoration: InputDecoration(
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search, color: AppColors.BLUE),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.YELLOW),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (query) =>
                          _filterStores(query), // Trigger filtering
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: AppColors.BLUE),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: displayedStores.isNotEmpty
                    ? ListView.builder(
                        itemCount: displayedStores.length,
                        itemBuilder: (context, index) {
                          final storeItem = displayedStores[index];
                          return ListTile(
                            title: Text(
                              storeItem.name,
                              style: TextStyle(color: AppColors.BLUE),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, storeItem.routeName);
                            },
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          "No results found",
                          style: TextStyle(color: AppColors.BLUE, fontSize: 16),
                        ),
                      ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _randomizePopularStores();
            displayedStores = popularStores;
          },
          child: Icon(Icons.refresh),
          backgroundColor: AppColors.YELLOW,
        ),
      ),
    );
  }
}
