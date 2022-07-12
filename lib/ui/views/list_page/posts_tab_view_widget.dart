import 'package:flutter/material.dart';
import 'package:flutter_tech_task/models/post.dart';
import 'package:flutter_tech_task/ui/views/list_page/post_tile_widget.dart';

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
