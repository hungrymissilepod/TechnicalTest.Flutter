import 'package:flutter_tech_task/models/post.dart';
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
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: const Text("List of posts"),
              bottom: const TabBar(
                tabs: [Text('Posts'), Text('Offline Posts')],
              ),
            ),
            body: Consumer<SavedPosts>(
              builder: (context, prefs, child) {
                return TabBarView(
                  children: [
                    PostsTabView(
                      posts: model.posts,
                    ),
                    PostsTabView(
                      posts: prefs.savedPosts,
                      isOfflineTab: true,
                    )
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class PostsTabView extends StatelessWidget {
  const PostsTabView({required this.posts, this.isOfflineTab = false, Key? key})
      : super(key: key);

  final List<Post> posts;
  final bool isOfflineTab;

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return Center(
        child: Text(
          isOfflineTab
              ? 'No posts available offline.\n\nSaved posts will be displayed here.'
              : 'Failed to load posts.',
          textAlign: TextAlign.center,
        ),
      );
    }
    return ListView.separated(
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) {
        return PostTile(post: posts[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Column(
          children: const [
            Divider(
              thickness: 1,
              color: Colors.grey,
            ),
          ],
        );
      },
    );
  }
}

class PostTile extends StatelessWidget {
  const PostTile({required this.post, Key? key}) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed('details/', arguments: {'id': post.id ?? 0});
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title ?? 'Title',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              post.body ?? 'Body',
            ),
          ],
        ),
      ),
    );
  }
}
