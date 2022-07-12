import 'package:flutter_tech_task/providers/saved_posts_provider.dart';
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
    final postId = args!['id'];
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
          body: model.post != null
              ? Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.post?.title ?? '',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        model.post?.body ?? '',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              child: const Text('View Comments'),
                              onPressed: () {
                                Navigator.of(context).pushNamed('comments/',
                                    arguments: {'id': postId ?? 0});
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: const BorderSide(color: Colors.blue),
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              child: const Text('delete'),
                              onPressed: () {
                                context.read<SavedPosts>().delete();
                              },
                            ),
                            Consumer<SavedPosts>(
                              builder: (context, prefs, child) {
                                bool? hasPost =
                                    prefs.isPostAlredySaved(model.post?.id);
                                return TextButton(
                                  child: Text(
                                    hasPost! ? 'Saved' : 'Save For Offline',
                                    style: const TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                  onPressed: () {
                                    context
                                        .read<SavedPosts>()
                                        .addSavedPost(model.post!);
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side:
                                            const BorderSide(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
