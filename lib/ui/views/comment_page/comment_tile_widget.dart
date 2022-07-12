import 'package:flutter/material.dart';
import 'package:flutter_tech_task/models/comment.dart';

class CommentTile extends StatelessWidget {
  const CommentTile({required this.comment, Key? key}) : super(key: key);

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          comment.email ?? 'Email',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        Text(
          comment.name ?? 'Name',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(comment.body ?? 'Body'),
      ],
    );
  }
}
