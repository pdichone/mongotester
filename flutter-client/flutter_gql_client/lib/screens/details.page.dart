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
    return Material(
      child: Container(
        child: Center(child: Text(widget.user["name"])),
      ),
    );
  }
}
