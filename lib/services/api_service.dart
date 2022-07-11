import 'package:flutter_tech_task/models/comment.dart';
import 'package:flutter_tech_task/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert' show json;

class APIService {
  // Service for interacting with RESTful API
  APIService();

  Future<List<Post>> fetchAllPosts() async {
    Response response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/'));
    Iterable iterable = json.decode(response.body);
    return List<Post>.from(iterable.map((model) => Post.fromJson(model)));
  }

  Future<Post> fetchPost(int id) async {
    Response response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'));
    return Post.fromJson(json.decode(response.body));
  }

  Future<List<Comment>> fetchCommentsForPost(int postId) async {
    Response response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/posts/$postId/comments/'));
    Iterable iterable = json.decode(response.body);
    return List<Comment>.from(iterable.map((model) => Comment.fromJson(model)));
  }
}
