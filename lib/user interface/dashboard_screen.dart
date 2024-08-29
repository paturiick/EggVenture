// import 'package:flutter/material.dart';

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});

//   @override
//   _DashboardScreenState createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
  

//   static const List<Widget> _widgetOptions = <Widget>[
//     Text(
//       'Home',
//       style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
//     ),
//     Text(
//       'Order',
//       style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
//     ),
//     Text(
//       'Chats',
//       style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
//     ),
//     Text(
//       'Tray',
//       style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
//     ),
//     Text(
//       'Profile',
//       style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
//     ),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       'assets/Eggventure.png', // Update the path to your logo image
//                       height:
//                           50, // Adjust the height according to your requirement
//                     ),
//                     SizedBox(width: 10),
//                     RichText(
//                       text: TextSpan(
//                         children: [
//                           TextSpan(
//                             text: 'E',
//                             style: TextStyle(
//                               fontFamily: 'AvenirNextCyr',
//                               fontWeight: FontWeight.w700,
//                               fontSize: 32,
//                               color: Color(0xFFF9B514),
//                             ),
//                           ),
//                           TextSpan(
//                             text: 'GG',
//                             style: TextStyle(
//                               fontFamily: 'AvenirNextCyr',
//                               fontWeight: FontWeight.w700,
//                               fontSize: 25,
//                               color: Color(0xFF353E55),
//                             ),
//                           ),
//                           TextSpan(
//                             text: 'V',
//                             style: TextStyle(
//                               fontFamily: 'AvenirNextCyr',
//                               fontWeight: FontWeight.w700,
//                               fontSize: 32,
//                               color: Color(0xFFF9B514),
//                             ),
//                           ),
//                           TextSpan(
//                             text: 'ENTURE',
//                             style: TextStyle(
//                               fontFamily: 'AvenirNextCyr',
//                               fontWeight: FontWeight.w700,
//                               fontSize: 25,
//                               color: Color(0xFF353E55),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 if (_selectedIndex == 0)
//                   TextField(
//                     decoration: InputDecoration(
//                       prefixIcon: Icon(Icons.search),
//                       hintText: 'Search',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Center(
//               child: _widgetOptions.elementAt(_selectedIndex),
//             ),
//           ),
//         ],
//       ),
//       // bottomNavigationBar: 
//     );
//   }
// }

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: DashboardScreen(),
//     );
//   }
// }
