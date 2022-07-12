import 'package:flutter/material.dart';

class ViewCommentsButton extends StatelessWidget {
  const ViewCommentsButton({required this.postId, Key? key}) : super(key: key);

  final int postId;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text('View Comments'),
      onPressed: () {
        Navigator.of(context).pushNamed('comments/', arguments: {'id': postId});
      },
      style: ButtonStyle(
        overlayColor: MaterialStateColor.resolveWith(
            (states) => Colors.blue.withOpacity(0.2)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
