import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'details.page.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final String _query = """
  query {
    users {
      id
      name
      age
      profession
   }
  }
""";
//   final String _query = """
//   query users {
//     users {
//       id
//       name
//       rocket
//       twitter
//     }
//   }
// """;
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
                    margin: EdgeInsets.only(bottom: 23, left: 10, right: 10),
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
                    child: InkWell(
                      child: Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${user['name'].toUpperCase() ?? 'N/A'}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  InkWell(
                                    child: Container(
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.greenAccent,
                                      ),
                                    ),
                                    onTap: () async {
                                      // final route = MaterialPageRoute(
                                      //   builder: (context) => UpdateUser(
                                      //       id: user["id"],
                                      //       name: user["name"],
                                      //       age: user["age"],
                                      //       profession: user["profession"]),
                                      // );
                                      // final result =
                                      //     await Navigator.push(context, route);

                                      // if (result != null && result) {
                                      //   /// TODO: Have a better way of notifying this dashboard screen to fetch new data
                                      //   setState(() {});
                                      // }
                                    },
                                  )
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 8),
                                child: Text(
                                    "Occupation: ${user['profession'] ?? 'N/A'}"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("age: ${user['age'] ?? 'N/A'}"),
                              )
                            ]),
                      ),
                      onTap: () async {
                        final route = MaterialPageRoute(
                          builder: (context) => DetailsPage(
                            user: user,
                          ),
                        );
                        await Navigator.push(context, route);
                      },
                    ),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}
