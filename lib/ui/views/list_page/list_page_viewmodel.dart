import 'package:flutter_tech_task/models/post.dart';
import 'package:flutter_tech_task/services/api_service.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

class ListPageViewModel extends BaseViewModel {
  final APIService _apiService = GetIt.instance.get<APIService>();

  List<Post> _posts = [];
  List<Post> get posts => _posts;

  Future<void> fetchAllPosts() async {
    _posts = await _apiService.fetchAllPosts();
    notifyListeners();
  }
}
