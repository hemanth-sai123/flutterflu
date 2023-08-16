// To parse this JSON data, do
//
//     final myPostModal = myPostModalFromJson(jsonString);

import 'dart:convert';

MyPostModal myPostModalFromJson(String str) => MyPostModal.fromJson(json.decode(str));

String myPostModalToJson(MyPostModal data) => json.encode(data.toJson());

class MyPostModal {
  List<Post> posts;
  int total;
  int skip;
  int limit;

  MyPostModal({
    required this.posts,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory MyPostModal.fromJson(Map<String, dynamic> json) => MyPostModal(
    posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
    total: json["total"],
    skip: json["skip"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
    "total": total,
    "skip": skip,
    "limit": limit,
  };
}

class Post {
  int id;
  String title;
  String body;
  int userId;
  List<String> tags;
  int reactions;

  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    required this.tags,
    required this.reactions,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    title: json["title"],
    body: json["body"],
    userId: json["userId"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    reactions: json["reactions"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "body": body,
    "userId": userId,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "reactions": reactions,
  };
}
