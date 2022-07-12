import 'package:flutter_tech_task/models/comment.dart';

class Post {
  Post(this.title, this.body, this.id, {this.comments});

  String? title;
  String? body;
  int? id;
  List<Comment>? comments;

  factory Post.fromJson(dynamic data) {
    return Post(data['title'], data['body'], data['id'],
        comments: data['comments'] == null
            ? null
            : (data['comments'] as List)
                .map((e) => Comment.fromJson(e))
                .toList());
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>>? commentMap =
        comments?.map((e) => e.toJson()).toList();
    return {'title': title, 'body': body, 'id': id, 'comments': commentMap};
  }
}
