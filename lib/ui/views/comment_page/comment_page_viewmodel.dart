import 'package:flutter_tech_task/models/comment.dart';
import 'package:flutter_tech_task/services/api_service.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

class CommentPageViewModel extends BaseViewModel {
  final APIService _apiService = GetIt.instance.get<APIService>();

  List<Comment> _comments = [];
  List<Comment> get comments => _comments;

  Future<void> fetchCommentsForPost(int postId) async {
    setBusy(true);
    _comments = await _apiService.fetchCommentsForPost(postId);
    setBusy(false);
  }
}
