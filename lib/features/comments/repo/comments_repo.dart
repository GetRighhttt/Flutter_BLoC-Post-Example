import 'dart:convert';
import 'dart:developer';
import 'package:api_request_bloc/features/comments/models/comments_data_model.dart';
import 'package:http/http.dart' as http;

class CommentsRepo {
  static Future<List<CommentsDataModel>> fetchPosts() async {
    var client = http.Client();
    List<CommentsDataModel> comments = [];
    try {
      var response = await client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));

      List result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        CommentsDataModel comment =
            CommentsDataModel.fromMap(result[i] as Map<String, dynamic>);
        comments.add(comment);
        log(comment.id.toString());
        log(comment.name);
      }

      return comments;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
