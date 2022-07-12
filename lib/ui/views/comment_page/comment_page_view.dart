import 'package:flutter/material.dart';
import 'package:flutter_tech_task/ui/views/comment_page/comment_page_viewmodel.dart';
import 'package:flutter_tech_task/ui/views/comment_page/comment_tile_widget.dart';
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
            title: const Text('Comments'),
          ),
          body: !model.isBusy
              ? model.comments.isNotEmpty
                  ? Container(
                      padding: const EdgeInsets.all(15),
                      child: ListView.separated(
                        itemCount: model.comments.length,
                        itemBuilder: (BuildContext context, int index) {
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
                  : const Center(
                      child: Text('No comments on this post'),
                    )
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
