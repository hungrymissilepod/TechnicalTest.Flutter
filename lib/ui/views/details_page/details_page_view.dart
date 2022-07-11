import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_task/ui/views/details_page/details_page_viewmodel.dart';

class DetailsPageView extends StatelessWidget {
  const DetailsPageView({Key? key}) : super(key: key);

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
                        child: TextButton(
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
