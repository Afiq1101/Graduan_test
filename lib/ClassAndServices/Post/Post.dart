
class Post {
  int id;
  String title;
  DateTime createdAt;
  DateTime updatedAt;

  Post({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      title: json['title'] as String,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }


}


class ReturnPost {
  final String text;
  final bool success;
  final Post? post;

  ReturnPost({
    required this.text,
    required this.success,
    required this.post,
  });

}

class ReturnListOfPosts {
  final String text;
  final bool success;
  final List<Post>? posts;

  ReturnListOfPosts({
    required this.text,
    required this.success,
    required this.posts,
  });

}

