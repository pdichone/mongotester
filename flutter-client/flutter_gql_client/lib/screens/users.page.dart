import 'package:flutter/material.dart';
import 'package:flutter_gql_client/screens/home.dart';
import 'package:flutter_gql_client/screens/update.user.page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../main.dart';
import 'details.page.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  List users = [];
  List postsList = [];
  List hobbiesList = [];
  List<dynamic> hobbiesIDsToDelete = [];
  List<dynamic> postsIDsToDelete = [];
  final String _query = """
  query {
  users {
      id
      name
      age
      profession
    posts{
      id
      comment
      userId
    }
    hobbies{
      id
      description
      userId
    }
  }
}
""";

  //final removeUserMutationKey = GlobalKey<MutationState>();
  //final removeHobbyMutationKey = GlobalKey<MutationState>();

  bool _isDoneRemovingHobby = false;
  bool _isDoneRemovingPost = false;
  String removeUser() {
    return """
    mutation RemoveUser(\$id: String!) {
      RemoveUser(id: \$id){
         name
      }   
    }
    """;
  }

  String removeHobbies() {
    return """
    mutation RemoveHobbies(\$ids: [String]) {
      RemoveHobbies(ids: \$ids){
         
      }   
    }
    """;
  }

  String removePosts() {
    return """
    mutation removePosts(\$ids: [String]) {
      RemovePosts(ids: \$ids){
         
      }   
    }
    """;
  }

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql(_query)),
      builder: (result, {fetchMore, refetch}) {
        // print(result.data.toString());
        if (result.isLoading) {
          return CircularProgressIndicator();
        }
        users = result.data!["users"];
        //print("\nUsers:::: ${users.toList().toString()}\n\n");

        //print("===> Hobbies: ${hobbiesList.toList().toString()}\n");
        //print("===> Posts: ${postsList.toList().toString()}");
        // hobbiesList = result.data!["users"];

        if (users.isEmpty) {
          return Container(
            child: Center(
              child: Text('No items found'),
            ),
          );
        } else {
          //return Text(users[2]['name'].toString());
          //print("postList ==> ${postsList.toString()}");
          // print("HobbiesList ==> ${hobbiesList.toString()}");
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              //print(" ==> \n");
              //  print("User ${user['name']} ==> ${user.toString()}");
              hobbiesList = user['hobbies'];
              postsList = user['posts'];
              // for (var i = 0; i < users.length; i++) {
              //   hobbiesList = users[i]["hobbies"];

              //   postsList = users[i]["posts"];
              // }

              // print(
              //     "${user['name']} Hobbie List ==> ${hobbiesList.toString()}");
              // print("${user['name']} Posts List ==> ${postsList.toString()}");

              // for (var i = 0; i < user['hobbies'].length; i++) {
              //   hobbiesIDsToDelete.add(user['hobbies'][i]["id"]);
              // }
              // for (var j = 0; j < user['posts'].length; j++) {
              //   postsIDsToDelete.add(user['posts'][j]["id"]);
              // }
              // print(
              //     "${user['name']} Hobbies ToDelete ==> ${hobbiesIDsToDelete.toString()}");
              // print(
              //     "${user['name']}  Posts to Delete  ==> ${postsIDsToDelete.toString()}");

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
                                  Row(
                                    children: [
                                      InkWell(
                                        child: Container(
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.greenAccent,
                                          ),
                                        ),
                                        onTap: () async {
                                          final route = MaterialPageRoute(
                                            builder: (context) => UpdateUser(
                                                id: user["id"],
                                                name: user["name"],
                                                age: user["age"],
                                                profession: user["profession"]),
                                          );
                                          final result = await Navigator.push(
                                              context, route);

                                          if (result != null && result) {
                                            /// TODO: Have a better way of notifying this dashboard screen to fetch new data
                                            // setState(() {});
                                          }
                                        },
                                      ),
                                      Mutation(
                                        // key: removeUserMutationKey,
                                        options: MutationOptions(
                                          document: gql(removeUser()),
                                          onCompleted: (data) {
                                            if (mounted)
                                              setState(() {
                                                _isDoneRemovingHobby = true;
                                                //_isDoneRemovingPost = true;
                                              });
                                            // ScaffoldMessenger.of(context)
                                            //     .showSnackBar(SnackBar(
                                            //   content: Text(
                                            //       "Deleted user id: ${data!['RemoveUser']['name']}"),
                                            // ));
                                          },
                                        ),
                                        builder: (runMutation, result) {
                                          return InkWell(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0, left: 14),
                                              child: Container(
                                                child: Icon(
                                                  Icons.delete_forever,
                                                  color: Colors.redAccent,
                                                ),
                                              ),
                                            ),
                                            onTap: () async {
                                              hobbiesIDsToDelete.clear();
                                              postsIDsToDelete.clear();
                                              // print(
                                              //     "***${user['name']} Hobbies Ids: ${user['hobbies']} ");
                                              // print(
                                              //     "***${user['name']} Posts Ids:${user['posts']} ");

                                              for (var i = 0;
                                                  i < user['hobbies'].length;
                                                  i++) {
                                                hobbiesIDsToDelete.add(
                                                    user['hobbies'][i]['id']);
                                              }

                                              for (var i = 0;
                                                  i < user['posts'].length;
                                                  i++) {
                                                postsIDsToDelete.add(
                                                    user['posts'][i]['id']);
                                              }

                                              print(
                                                  "***${user['name']} Hobbies TO Delete: ${hobbiesIDsToDelete.toString()} ");
                                              print(
                                                  "***${user['name']} Posts TO Delete: ${postsIDsToDelete.toString()} ");

                                              if (mounted)
                                                setState(() {
                                                  _isDoneRemovingHobby = true;
                                                  _isDoneRemovingPost = true;
                                                });
                                              runMutation({'id': user['id']});

                                              Navigator.pushAndRemoveUntil(
                                                  context, MaterialPageRoute(
                                                builder: (context) {
                                                  return HomeScreen();
                                                },
                                              ),
                                                  (route) =>
                                                      false); //.then((value) => {setState(() {})});
                                            },
                                          );
                                        },
                                      ),
                                      _isDoneRemovingHobby
                                          ? Mutation(
                                              options: MutationOptions(
                                                document: gql(removeHobbies()),
                                                onCompleted: (data) {
                                                  if (mounted)
                                                    setState(() {
                                                      _isDoneRemovingHobby =
                                                          false;
                                                      _isDoneRemovingPost =
                                                          true;
                                                    });
                                                },
                                              ),
                                              builder: (runMutation, result) {
                                                print("Calling deleteHobby...");
                                                if (hobbiesIDsToDelete
                                                    .isNotEmpty) {
                                                  Future.delayed(
                                                      Duration(milliseconds: 6),
                                                      () {
                                                    runMutation(
                                                        // {'userId': user['id']}
                                                        {
                                                          'ids':
                                                              hobbiesIDsToDelete
                                                        });
                                                  });
                                                }

                                                return Container();
                                              },
                                            )
                                          : Container(),
                                      _isDoneRemovingPost
                                          ? Mutation(
                                              options: MutationOptions(
                                                document: gql(removePosts()),
                                                onCompleted: (data) {
                                                  if (mounted)
                                                    setState(() {
                                                      _isDoneRemovingHobby =
                                                          false;
                                                      _isDoneRemovingPost =
                                                          false;
                                                    });
                                                },
                                              ),
                                              builder: (runMutation, result) {
                                                print("Calling removePost...");
                                                if (postsIDsToDelete
                                                    .isNotEmpty) {
                                                  runMutation(
                                                      // {'userId': user['id']}
                                                      {
                                                        'ids': postsIDsToDelete
                                                      });
                                                }

                                                return Container();
                                              },
                                            )
                                          : Container(),
                                    ],
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
