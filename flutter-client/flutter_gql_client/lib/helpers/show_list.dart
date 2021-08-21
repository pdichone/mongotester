import 'package:flutter/material.dart';
import 'package:flutter_gql_client/screens/details.page.dart';

class ShowListView extends StatelessWidget {
  const ShowListView({
    Key? key,
    required bool isHobby,
    required List list,
    required this.widget,
  })  : _isHobby = isHobby,
        _list = list,
        super(key: key);

  final bool _isHobby;
  final List _list;
  final DetailsPage widget;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _list.length,
      itemBuilder: (context, index) {
        final data = _list[index];

        return Stack(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 23, left: 10, right: 10, top: 22),
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
              child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 1,
                            fit: FlexFit.loose,
                            child: Text(
                              _isHobby
                                  ? "Hobby: ${data['title']}"
                                  : "Post: ${data['comment']}",
                              style: TextStyle(
                                  fontSize: _isHobby ? 16 : 14,
                                  fontWeight: _isHobby
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 8),
                        child: Text(
                          _isHobby ? "Description: ${data['description']}" : "",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Author: ${widget.user['name']}",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      )
                    ]),
              ),
            ),
          ],
        );
      },
    );
  }
}
