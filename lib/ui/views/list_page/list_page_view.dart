import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_task/ui/views/list_page/list_page_viewmodel.dart';

class ListPageView extends StatelessWidget {
  const ListPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListPageViewModel>.reactive(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("List of posts"),
            ),
            body: ListView(
              children: model.posts.map((post) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed('details/', arguments: {'id': post.id ?? 0});
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.title ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(post.body ?? ''),
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
        viewModelBuilder: () => ListPageViewModel(),
        onModelReady: (model) {
          model.fetchPosts();
        });
  }
}
