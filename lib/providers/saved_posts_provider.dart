import 'package:flutter/material.dart';
import 'package:flutter_tech_task/models/post.dart';
import 'package:flutter_tech_task/services/shared_prefs_service.dart';
import 'package:get_it/get_it.dart';

class SavedPosts with ChangeNotifier {
  final SharedPrefsService _sharedPrefsService =
      GetIt.instance.get<SharedPrefsService>();

  List<Post> _savedPosts = [];
  List<Post> get savedPosts => _savedPosts;

  // Load saved posts from shared preferences service
  Future<void> loadSavedPosts() async {
    _savedPosts = await _sharedPrefsService.loadSavedPosts();
    notifyListeners();

    print('SavedPosts - loadSavedPosts');
    for (Post p in _savedPosts) {
      print(p.toJson().toString());
    }
  }

  // Add a [post] to [_savedPosts]
  void addSavedPost(Post post) async {
    // Check that this post has not already been saved
    if (isPostAlredySaved(post.id)) return;
    _savedPosts.add(post);
    _sharedPrefsService.saveSavedPosts(_savedPosts);
    notifyListeners();
  }

  bool isPostAlredySaved(int? id) {
    if (_savedPosts.where((e) => e.id == id).isNotEmpty) {
      return true;
    }
    return false;
  }

  void delete() {
    _savedPosts.clear();
    _sharedPrefsService.delete();
    notifyListeners();
  }
}
