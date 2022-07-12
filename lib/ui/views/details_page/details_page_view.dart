import 'package:flutter_tech_task/providers/saved_posts_provider.dart';
import 'package:flutter_tech_task/ui/views/details_page/save_button_widget.dart';
import 'package:flutter_tech_task/ui/views/details_page/view_comments_button_widget.dart';
import 'package:flutter_tech_task/ui/views/list_page/post_tile_widget.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_task/ui/views/details_page/details_page_viewmodel.dart';

class DetailsPageView extends StatefulWidget {
  const DetailsPageView({Key? key}) : super(key: key);

  @override
  State<DetailsPageView> createState() => _DetailsPageViewState();
}

class _DetailsPageViewState extends State<DetailsPageView> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final int postId = args!['id'] ?? 0;
    return ViewModelBuilder<DetailsPageViewModel>.reactive(
      viewModelBuilder: () => DetailsPageViewModel(),
      onModelReady: (model) {
        model.fetchPost(postId);
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Post details'),
          ),
          body: !model.isBusy
              ? model.post != null
                  ? Container(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PostTile(
                            post: model.post,
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ViewCommentsButton(postId: postId),
                                Consumer<SavedPosts>(
                                  builder: (context, prefs, child) {
                                    bool? hasPost =
                                        prefs.isPostAlredySaved(model.post?.id);
                                    return SaveButton(
                                      post: model.post,
                                      hasPost: hasPost,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : const Center(
                      child: Text('Post failed to load'),
                    )
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
