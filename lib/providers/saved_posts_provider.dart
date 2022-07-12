import 'package:flutter/material.dart';
import 'package:flutter_tech_task/models/post.dart';
import 'package:flutter_tech_task/services/api_service.dart';
import 'package:flutter_tech_task/services/shared_prefs_service.dart';
import 'package:get_it/get_it.dart';

class SavedPosts with ChangeNotifier {
  final SharedPrefsService _sharedPrefsService =
      GetIt.instance.get<SharedPrefsService>();

  final APIService _apiService = GetIt.instance.get<APIService>();

  List<Post> _savedPosts = [];
  List<Post> get savedPosts => _savedPosts;

  // Load saved posts from shared preferences service
  Future<void> loadSavedPosts() async {
    _savedPosts = await _sharedPrefsService.loadSavedPosts();
    notifyListeners();
  }

  // Add a [post] to [_savedPosts]
  void addSavedPost(Post post) async {
    // Check that this post has not already been saved
    if (isPostAlredySaved(post.id)) return;
    // Fetch comments for this post
    post.comments = await _apiService.fetchCommentsForPost(post.id);
    _savedPosts.add(post);
    // Save posts in local storage
    _sharedPrefsService.saveSavedPosts(_savedPosts);
    notifyListeners();
  }

  bool isPostAlredySaved(int? id) {
    if (_savedPosts.where((e) => e.id == id).isNotEmpty) {
      return true;
    }
    return false;
  }
}
