import 'package:flutter/material.dart';
import 'package:flutter_tech_task/providers/saved_posts_provider.dart';
import 'package:flutter_tech_task/services/locator.dart';
import 'package:flutter_tech_task/ui/views/comment_page/comment_page_view.dart';
import 'package:flutter_tech_task/ui/views/details_page/details_page_view.dart';
import 'package:flutter_tech_task/ui/views/list_page/list_page_view.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SavedPosts(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: 'list/',
        routes: {
          "list/": (context) => const ListPageView(),
          "details/": (context) => const DetailsPageView(),
          "comments/": (context) => const CommentPageView(),
        },
      ),
    );
  }
}
