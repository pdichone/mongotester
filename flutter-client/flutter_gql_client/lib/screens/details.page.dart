import 'package:flutter/material.dart';
import 'package:flutter_gql_client/helpers/show_list.dart';
import 'package:flutter_gql_client/screens/users.page.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class DetailsPage extends StatefulWidget {
  final dynamic user;

  const DetailsPage({Key? key, required this.user}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool _visible = false;
  List _hobbies = [];
  List _posts = [];
  bool _isPost = false;
  bool _isHobby = false;

  void _togglePostBtn() {
    setState(() {
      _isPost = true;
      _isHobby = false;
    });
  }

  void _toggleHobbyBtn() {
    setState(() {
      _isHobby = true;
      _isPost = false;
    });
  }

  void _toggle() {
    setState(() {
      _visible = !_visible;
    });
  }

  String getUserData = """
  query getUserData(\$id: String!) {
  
  user(id:\$id){
     name
     hobbies{
       id
      title
      description
    }
    posts{
      id
      comment
      }
    }
    }
     """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.user['name'],
          style: TextStyle(
              color: Colors.grey, fontSize: 19, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: Container(
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: TextButton(
                  onPressed: () {
                    //_toggle();
                    _toggleHobbyBtn();

                    /*
                         Get all hobbies and show them
                    */
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 36, vertical: 12),
                    child: Text(
                      "Hobbies",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.greenAccent)),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: TextButton(
                  onPressed: () {
                    //_toggle();
                    _togglePostBtn();
                    /*
                         Get all posts and show them
                    */
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 36, vertical: 12),
                    child: Text(
                      "Posts",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.greenAccent)),
                ),
              ),
            ],
          ),
          Query(
            options: QueryOptions(
                document: gql(getUserData),
                variables: {'id': widget.user['id']}),
            builder: (result, {fetchMore, refetch}) {
              //setState(() {
              _hobbies = result.data!['user']['hobbies'] ??
                  []; //https://stackoverflow.com/questions/64278595/null-check-operator-used-on-a-null-value
              _posts = result.data!['user']['posts'] ?? [];
              //});

              // print("user==> ${result.data!['user']['name']}");
              //print("Hobbies: ${result.data!['user']['hobbies']}");
              //print("Posts: ${result.data!['user']['posts']}");
              return Visibility(
                visible: true,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: (_hobbies.length > 0 || _posts.length > 0)
                      ? _isHobby
                          ? ShowListView(
                              isHobby: true, list: _hobbies, widget: widget)
                          : ShowListView(
                              isHobby: false, list: _posts, widget: widget)
                      : Container(
                          child: Center(
                            child: Text(
                              "No data Available",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
