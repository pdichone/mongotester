import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../main.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _formKey = GlobalKey<FormState>();
  final _hobbyFormKey = GlobalKey<FormState>();
  final _postFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _professionController = TextEditingController();
  final _ageController = TextEditingController();

  final _hobbyTitleController = TextEditingController();
  final _hobbyDescriptionController = TextEditingController();

  final _postController = TextEditingController();

  bool _isSaving = false;
  bool _isSavingHobby = false;
  bool _isSavingPost = false;

  var currUserId;

  bool _visible = false;

  void _toggle() {
    setState(() {
      _visible = !_visible;
    });
  }

  String insertUser() {
    return """
    mutation CreateUser(\$name: String!, \$profession: String!, \$age: Int!) {
      CreateUser(name: \$name, profession: \$profession, age: \$age){
         id
         name
      }   
    }
    """;
  }

  String insertHobby() {
    return """
    mutation CreateHobby(\$title: String!, \$description: String!, \$userId: String!) {
      CreateHobby(title: \$title, description: \$description, userId: \$userId){
         id
         title
      }   
    }
    """;
  }

  String insertPost() {
    return """
    mutation CreatePost(\$comment: String!, \$userId: String!) {
      CreatePost(comment: \$comment, userId: \$userId){
         id
         comment
      }   
    }
    """;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add a User',
          style: TextStyle(
              color: Colors.grey, fontSize: 19, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightGreen,
        elevation: 0,
      ),
      body: SingleChildScrollView(
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
          child: Column(
            children: [
              Mutation(
                options: MutationOptions(
                  document: gql(insertUser()),
                  fetchPolicy: FetchPolicy.noCache,
                  onCompleted: (data) {
                    setState(() {
                      _isSaving = false;
                      currUserId = data['CreateUser']['id'];
                    });

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text("added user id: ${data['CreateUser']['id']}"),
                    ));
                  },
                ),
                builder: (runMutation, result) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 12),
                        TextFormField(
                          controller: _nameController,
                          decoration: new InputDecoration(
                              labelText: "Name",
                              fillColor: Colors.white,
                              border:
                                  OutlineInputBorder(borderSide: BorderSide())),
                          validator: (v) {
                            if (v!.length == 0) {
                              return "Name cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          controller: _professionController,
                          decoration: new InputDecoration(
                              labelText: "Profession",
                              fillColor: Colors.white,
                              border:
                                  OutlineInputBorder(borderSide: BorderSide())),
                          validator: (v) {
                            if (v!.length == 0) {
                              return "Profession cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          controller: _ageController,
                          decoration: new InputDecoration(
                              labelText: "Age",
                              fillColor: Colors.white,
                              border:
                                  OutlineInputBorder(borderSide: BorderSide())),
                          validator: (v) {
                            if (v!.length == 0) {
                              return "Age cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 12),
                        _isSaving
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                ),
                              )
                            : TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _toggle();
                                    setState(() {
                                      _isSaving = true;
                                    });
                                    runMutation({
                                      'name': _nameController.text
                                          .toString()
                                          .trim(),
                                      'profession':
                                          _professionController.text.trim(),
                                      'age': int.parse(_ageController.text)
                                    });
                                  }
                                  _ageController.clear();
                                  _nameController.clear();
                                  _professionController.clear();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 36, vertical: 12),
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 16),
                                  ),
                                ),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.greenAccent)),
                              )
                      ],
                    ),
                  );
                },
              ),

              /*
             Add Hobby 
        */
              Visibility(
                visible: _visible,
                child: Mutation(
                  options: MutationOptions(
                    document: gql(insertHobby()),
                    fetchPolicy: FetchPolicy.noCache,
                    onCompleted: (data) {
                      setState(() {
                        _isSavingHobby = false;
                      });

                      Future.delayed(
                          Duration(
                            milliseconds: 12,
                          ), () {
                        //Navigator.pop(context, true);
                      });
                    },
                  ),
                  builder: (runMutation, result) {
                    return Form(
                      key: _hobbyFormKey,
                      child: Column(
                        children: [
                          SizedBox(height: 12),
                          TextFormField(
                            controller: _hobbyTitleController,
                            decoration: new InputDecoration(
                                labelText: "Hobby title",
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide())),
                            validator: (v) {
                              if (v!.length == 0) {
                                return "Enter a title";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: 12),
                          TextFormField(
                            controller: _hobbyDescriptionController,
                            decoration: new InputDecoration(
                                labelText: "Hobby description",
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide())),
                            validator: (v) {
                              if (v!.length == 0) {
                                return "Description cannot be empty";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: 12),
                          _isSavingHobby
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                  ),
                                )
                              : TextButton(
                                  onPressed: () {
                                    if (_hobbyFormKey.currentState!
                                        .validate()) {
                                      setState(() {
                                        _isSavingHobby = true;
                                      });
                                      runMutation({
                                        'title': _hobbyTitleController.text,
                                        'description':
                                            _hobbyDescriptionController.text,
                                        'userId': currUserId
                                      });
                                    }
                                    _hobbyTitleController.clear();
                                    _hobbyDescriptionController.clear();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 36, vertical: 12),
                                    child: Text(
                                      "Save",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 16),
                                    ),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.greenAccent)),
                                )
                        ],
                      ),
                    );
                  },
                ),
              ),

              /*
                    Add Post
                    */

              Visibility(
                visible: _visible,
                child: Mutation(
                  options: MutationOptions(
                    document: gql(insertPost()),
                    fetchPolicy: FetchPolicy.noCache,
                    onCompleted: (data) {
                      setState(() {
                        _isSavingPost = false;
                      });

                      Future.delayed(
                          Duration(
                            milliseconds: 12,
                          ), () {
                        // Navigator.pop(context, true);
                      });
                    },
                  ),
                  builder: (runMutation, result) {
                    return Form(
                      key: _postFormKey,
                      child: Column(
                        children: [
                          SizedBox(height: 12),
                          TextFormField(
                            controller: _postController,
                            decoration: new InputDecoration(
                                labelText: "Post Comment ",
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide())),
                            validator: (v) {
                              if (v!.length == 0) {
                                return "Post cannot be empty";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: 12),
                          _isSavingPost
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                  ),
                                )
                              : TextButton(
                                  onPressed: () {
                                    if (_postFormKey.currentState!.validate()) {
                                      setState(() {
                                        _isSavingPost = true;
                                      });
                                      runMutation({
                                        'comment': _postController.text,
                                        'userId': currUserId
                                      });
                                      //clear fields
                                      _postController.clear();
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 36, vertical: 12),
                                    child: Text(
                                      "Save",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 16),
                                    ),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.greenAccent)),
                                )
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Visibility(
                    visible: _visible,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return HomeScreen();
                          },
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 26, vertical: 12),
                        child: Text(
                          "Done",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.greenAccent)),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
