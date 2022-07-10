import 'dart:convert' show json;
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tech_task/ui/views/list_page/list_page_viewmodel.dart';

class ListPageView extends StatefulWidget {
  const ListPageView({Key? key}) : super(key: key);

  @override
  State<ListPageView> createState() => _ListPageViewState();
}

class _ListPageViewState extends State<ListPageView> {
  List<dynamic> posts = [];

  @override
  void initState() {
    super.initState();
    http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/'))
        .then((response) {
      setState(() {
        posts = json.decode(response.body);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListPageViewModel>.reactive(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("List of posts"),
            ),
            body: ListView(
              children: posts.map((post) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed('details/', arguments: {'id': post['id']});
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post['title'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(post['body']),
                        Container(height: 10),
                        const Divider(
                          thickness: 1,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
        viewModelBuilder: () => ListPageViewModel());
  }
}
