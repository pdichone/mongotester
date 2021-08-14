import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
//   final String _query = """
//   query users {
//       id
//       name
//       age
//       profession
//   }
// """;
  final String _query = """
  query users {
    users {
      id
      name
      rocket
      twitter
    }
  }
""";
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql(_query)),
      builder: (result, {fetchMore, refetch}) {
        print(result.data.toString());
        if (result.isLoading) {
          return CircularProgressIndicator();
        }
        final List users = result.data!["users"];
        if (users.isEmpty) {
          return Container(
            child: Center(
              child: Text('No items found'),
            ),
          );
        } else {
          //return Text(users[2]['name'].toString());
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];

              return Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 23),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 10),
                              color: Colors.grey.shade300,
                              blurRadius: 30)
                        ]),
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          child: Text(user['name'] ?? 'N/A'),
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          );
        }
      },
    );
  }
}
