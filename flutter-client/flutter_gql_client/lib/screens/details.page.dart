import 'package:flutter/material.dart';
import 'package:flutter_gql_client/screens/users.page.dart';

class DetailsPage extends StatefulWidget {
  final dynamic user;

  const DetailsPage({Key? key, required this.user}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text(
          widget.user['name'],
          style: TextStyle(
              color: Colors.grey, fontSize: 19, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  color: Colors.grey.shade300,
                  blurRadius: 30,
                ),
              ],
            ),
            child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${widget.user['name'].toUpperCase() ?? 'N/A'}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8),
                      child: Text(
                          "Occupation: ${widget.user['profession'] ?? 'N/A'}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("age: ${widget.user['age'] ?? 'N/A'}"),
                    )
                  ]),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  //all we do here is query the userType
                  /*
                    query {
  user(id:"611c3585395b880016d8d157"){
     name
     hobbies{
      title
      description
    }
    posts{
      comment
    }
  }
}
                  */
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
                  child: Text(
                    "Hobbies",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.greenAccent)),
              ),
              TextButton(
                onPressed: () {},
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
                  child: Text(
                    "Posts",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.greenAccent)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
