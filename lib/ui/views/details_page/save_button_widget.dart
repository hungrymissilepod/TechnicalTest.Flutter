import 'package:flutter/material.dart';
import 'package:flutter_tech_task/models/post.dart';
import 'package:flutter_tech_task/providers/saved_posts_provider.dart';
import 'package:provider/provider.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({required this.post, required this.hasPost, Key? key})
      : super(key: key);

  final Post? post;
  final bool hasPost;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            hasPost ? 'Saved' : 'Save For Offline',
            style: const TextStyle(
              color: Colors.red,
            ),
          ),
          const SizedBox(width: 5),
          Icon(
            hasPost ? Icons.check : Icons.download,
            color: Colors.red,
          ),
        ],
      ),
      onPressed: () {
        if (post == null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Error saving post')));
        } else if (hasPost) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Post alredy downloaded')));
        }
        context.read<SavedPosts>().addSavedPost(post!);
      },
      style: ButtonStyle(
        overlayColor: MaterialStateColor.resolveWith(
            (states) => Colors.red.withOpacity(0.2)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
