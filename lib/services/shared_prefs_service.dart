import 'dart:convert' show json;
import 'package:flutter_tech_task/models/post.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  SharedPrefsService();

  SharedPreferences? _sharedPreferences;

  Future<List<Post>> loadSavedPosts() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    String? str = _sharedPreferences?.getString('saved-posts');
    if (str != null) {
      Iterable iterable = json.decode(str!);
      return List<Post>.from(iterable.map((e) => Post.fromJson(e)));
    }
    return <Post>[];
  }

  void saveSavedPosts(List<Post?>? savedPosts) async {
    print('${json.encode(savedPosts)}');
    await _sharedPreferences?.setString('saved-posts', json.encode(savedPosts));
  }

  void delete() async {
    await _sharedPreferences?.clear();
  }
}
