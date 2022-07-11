class Comment {
  Comment(this.postId, this.id, this.name, this.email, this.body);

  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  factory Comment.fromJson(dynamic data) {
    return Comment(
        data['postId'], data['id'], data['name'], data['email'], data['body']);
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'id': id,
      'name': name,
      'email': email,
      'body': body
    };
  }
}
