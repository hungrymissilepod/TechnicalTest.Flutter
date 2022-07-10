import 'dart:convert' show json;
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tech_task/ui/views/details_page/details_page_viewmodel.dart';

class DetailsPageView extends StatefulWidget {
  const DetailsPageView({Key? key}) : super(key: key);

  @override
  State<DetailsPageView> createState() => _DetailsPageViewState();
}

class _DetailsPageViewState extends State<DetailsPageView> {
  dynamic post;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DetailsPageViewModel>.reactive(
      builder: (context, model, child) {
        final args =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

        return FutureBuilder<dynamic>(
            future: http.get(Uri.parse(
                'https://jsonplaceholder.typicode.com/posts/${args?['id']}')),
            builder: (post, response) {
              if (response.hasData) {
                dynamic data = json.decode(response.data!.body);
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Post details'),
                  ),
                  body: Container(
                      padding: const EdgeInsets.all(15),
                      child: Column(children: [
                        Text(
                          data['title'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Container(height: 10),
                        Text(data['body'], style: const TextStyle(fontSize: 16))
                      ])),
                );
              } else {
                return Container();
              }
            });
      },
      viewModelBuilder: () => DetailsPageViewModel(),
    );
  }
}
