import 'package:flutter/material.dart';
import 'package:flutter_gql_client/screens/add.users.page.dart';
import 'package:flutter_gql_client/screens/home.dart';
import 'package:flutter_gql_client/screens/users.page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();

  final HttpLink link = HttpLink('https://mytest-app-pa.herokuapp.com/graphql'
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
    final textTheme = Theme.of(context).textTheme;
    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: '',
            theme: ThemeData(
              primarySwatch: Colors.blueGrey,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textTheme: textTheme,
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(
                  color: Colors.black87,
                ),
                textTheme: textTheme,
              ),
            ),
            home: HomeScreen()),
      ),
    );
  }
}
