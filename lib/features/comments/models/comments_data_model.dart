import 'dart:convert';

class CommentsDataModel {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  CommentsDataModel(
      {required this.postId,
      required this.id,
      required this.name,
      required this.email,
      required this.body});

Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'id': id,
      'name': name,
      'email': email,
      'body': body,
    };
  }

  factory CommentsDataModel.fromMap(Map<String, dynamic> map) {
    return CommentsDataModel(
      postId: map['postId']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      body: map['body'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentsDataModel.fromJson(String source) =>
      CommentsDataModel.fromMap(json.decode(source));

}
