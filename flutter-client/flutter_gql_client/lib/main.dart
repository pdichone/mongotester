import 'package:flutter/material.dart';
import 'package:flutter_gql_client/screens/users.page.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();

  final HttpLink link = HttpLink('https://hobbies-tesp.herokuapp.com/graphql'
      //'https://api.spacex.land/graphql/',
      );

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(link: link, cache: GraphQLCache(store: HiveStore())),
  );

  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;

  const MyApp({Key? key, required this.client}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: HomeScreen()),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    Widget content = UsersPage();

    // if (_currentIndex == 1) {
    //   content = LaunchUpcomingPage();
    // } else if (_currentIndex == 2) {
    //   content = LaunchHistoryPage();
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text("Hobbies"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: content,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.grey.shade500,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "Users",
            icon: Icon(
              Icons.group,
              size: 16,
            ),
          ),
          BottomNavigationBarItem(
            label: ("Upcoming"),
            icon: Icon(
              Icons.track_changes,
              size: 16,
            ),
          ),
          BottomNavigationBarItem(
            label: 'History',
            icon: Icon(
              Icons.history,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}
