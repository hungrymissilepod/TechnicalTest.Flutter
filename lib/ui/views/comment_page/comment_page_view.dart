import 'package:flutter/material.dart';
import 'package:flutter_tech_task/models/comment.dart';
import 'package:flutter_tech_task/ui/views/comment_page/comment_page_viewmodel.dart';
import 'package:stacked/stacked.dart';

class CommentPageView extends StatelessWidget {
  const CommentPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CommentPageViewModel>.reactive(
      viewModelBuilder: () => CommentPageViewModel(),
      onModelReady: (model) {
        final args =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
        final postId = args!['id'];
        model.fetchCommentsForPost(postId);
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            // TODO: could show post title in app bar title?
            title: Text('Comments'),
          ),
          // TODO: display all comments in listview.builder
          body: model.comments.isNotEmpty
              ? Container(
                  padding: const EdgeInsets.all(15),
                  child: ListView.separated(
                    itemCount: model.comments.length,
                    itemBuilder: (BuildContext context, int index) {
                      // return Text(model.comments[index].name ?? '');
                      return CommentTile(comment: model.comments[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Container(height: 10),
                          const Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                        ],
                      );
                    },
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

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
