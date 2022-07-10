import 'package:flutter/material.dart';
import 'package:flutter_tech_task/ui/views/details_page/details_page_view.dart';
import 'package:flutter_tech_task/ui/views/list_page/list_page_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'list/',
      routes: {
        "list/": (context) => const ListPageView(),
        "details/": (context) => const DetailsPageView(),
      },
    );
  }
}
