import 'package:flutter/material.dart';
import 'package:flutter_gql_client/screens/add.users.page.dart';
import 'package:flutter_gql_client/screens/users.page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Widget content = UsersPage();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Users & Hobbies",
          style: TextStyle(
              color: Colors.grey, fontSize: 19, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: content,
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.white,
      //   selectedItemColor: Colors.black87,
      //   unselectedItemColor: Colors.grey.shade500,
      //   currentIndex: _currentIndex,
      //   onTap: (index) {
      //     setState(() {
      //       _currentIndex = index;
      //     });
      //   },
      //   items: [
      //     BottomNavigationBarItem(
      //       label: "Users",
      //       icon: Icon(
      //         Icons.group,
      //         size: 16,
      //       ),
      //     ),
      //     BottomNavigationBarItem(
      //       label: ("Upcoming"),
      //       icon: Icon(
      //         Icons.track_changes,
      //         size: 16,
      //       ),
      //     ),
      //     BottomNavigationBarItem(
      //       label: 'History',
      //       icon: Icon(
      //         Icons.history,
      //         size: 16,
      //       ),
      //     ),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final route = MaterialPageRoute(
            builder: (context) => AddUserPage(),
          );
          await Navigator.push(context, route);
        },
        backgroundColor: Colors.lightGreen,
        child: Icon(Icons.group_add),
      ),
    );
  }
}
