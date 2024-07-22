import 'dart:convert';
import 'dart:developer';
import 'package:api_request_bloc/features/posts/models/post_data_model.dart';
import 'package:http/http.dart' as http;

class PostsRepo {
  static Future<List<PostDataModel>> fetchPosts() async {
    var client = http.Client();
    List<PostDataModel> posts = [];
    try {
      var response = await client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      List result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        PostDataModel post =
            PostDataModel.fromMap(result[i] as Map<String, dynamic>);
        posts.add(post);
        log(post.id.toString());
        log(post.title);
      }

      return posts;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

// post to server example
  static Future<bool> addPost() async {
    var client = http.Client();
    try {
      var response = await client.post(
          Uri.parse('https://jsonplaceholder.typicode.com/posts'),
          body: {"title": "Title", "body": "Body", "userId": "22"});
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }


// delete from server
  static Future<bool> deletePost() async {
    var client = http.Client();
    try {
      var response = await client.delete(
          Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
