import 'package:flutter/material.dart';
import 'package:flutter_tech_task/models/post.dart';

class PostTile extends StatelessWidget {
  const PostTile({required this.post, Key? key}) : super(key: key);

  final Post? post;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed('details/', arguments: {'id': post?.id ?? 0});
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post?.title ?? 'Title',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              post?.body ?? 'Body',
            ),
          ],
        ),
      ),
    );
  }
}
