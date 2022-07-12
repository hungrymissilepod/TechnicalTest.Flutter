import 'package:flutter_tech_task/providers/saved_posts_provider.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_task/ui/views/list_page/list_page_viewmodel.dart';

class ListPageView extends StatelessWidget {
  const ListPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SavedPosts>().loadSavedPosts();
    return ViewModelBuilder<ListPageViewModel>.reactive(
      viewModelBuilder: () => ListPageViewModel(),
      onModelReady: (model) async {
        model.fetchAllPosts();
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("List of posts"),
          ),
          body: Consumer<SavedPosts>(
            builder: (context, prefs, child) {
              return ListView(
                children: model.posts.map((post) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('details/',
                          arguments: {'id': post.id ?? 0});
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            post.title ?? '',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            post.body ?? '',
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            thickness: 1,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        );
      },
    );
  }
}
