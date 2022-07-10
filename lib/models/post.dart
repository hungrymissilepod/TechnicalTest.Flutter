class Post {
  Post(this.title, this.body, this.id);

  String? title;
  String? body;
  int? id;

  factory Post.fromJson(dynamic data) {
    return Post(data['title'] ?? '', data['body'] ?? '', data['id'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'body': body, 'id': id};
  }
}
