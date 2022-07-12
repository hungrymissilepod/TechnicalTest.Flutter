import 'package:badges/badges.dart';
import 'package:flutter_tech_task/providers/saved_posts_provider.dart';
import 'package:flutter_tech_task/ui/views/list_page/posts_tab_view_widget.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_task/ui/views/list_page/list_page_viewmodel.dart';

class ListPageView extends StatelessWidget {
  const ListPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SavedPosts>().loadSavedPosts();
    return ViewModelBuilder<ListPageViewModel>.reactive(
      viewModelBuilder: () => ListPageViewModel(),
      onModelReady: (model) async {
        model.fetchAllPosts();
      },
      builder: (context, model, child) {
        return DefaultTabController(
          length: 2,
          child: Consumer<SavedPosts>(
            builder: (context, prefs, child) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("List of posts"),
                  bottom: TabBar(
                    tabs: [
                      const _TabBarText('Posts'),
                      Badge(
                        badgeContent: Text(
                          prefs.savedPosts.length.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        child: const _TabBarText('Offline Posts'),
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    PostsTabView(
                      posts: model.posts,
                    ),
                    PostsTabView(
                      posts: prefs.savedPosts,
                      isOfflineTab: true,
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _TabBarText extends StatelessWidget {
  const _TabBarText(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 20,
      ),
    );
  }
}
