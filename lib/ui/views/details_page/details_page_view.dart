import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_task/ui/views/details_page/details_page_viewmodel.dart';

class DetailsPageView extends StatelessWidget {
  const DetailsPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DetailsPageViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Post details'),
          ),
          body: model.post != null
              ? Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(
                        model.post?.title ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Container(height: 10),
                      Text(
                        model.post?.body ?? '',
                        style: const TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
        );
      },
      viewModelBuilder: () => DetailsPageViewModel(),
      onModelReady: (model) {
        final args =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
        model.fetchPost(args!['id']);
      },
    );
  }
}
