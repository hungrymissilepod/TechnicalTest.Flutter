import 'package:flutter_tech_task/models/post.dart';
import 'package:flutter_tech_task/services/api_service.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

class DetailsPageViewModel extends BaseViewModel {
  final APIService _apiService = GetIt.instance.get<APIService>();

  Post? _post;
  Post? get post => _post;

  Future<void> fetchPost(int id) async {
    setBusy(true);
    _post = await _apiService.fetchPost(id);
    setBusy(false);
  }
}
