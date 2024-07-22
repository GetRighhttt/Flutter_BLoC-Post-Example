import 'dart:async';
import 'dart:convert';
import 'package:api_request_bloc/features/posts/models/post_data_model.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
  }

  FutureOr<void> postsInitialFetchEvent(
      PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
    // create http client
    var client = http.Client();
    List<PostDataModel> posts = [];
    try {
      var response = await client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

          List result = jsonDecode(response.body);

      // loop through response and append
      for (int i = 0; i < result.length; i++) {
        PostDataModel post =
            PostDataModel.fromMap(result[i] as Map<String, dynamic>);
        posts.add(post);
      }
      developer.log(posts.toString());
      emit(PostFetchSuccessfulState(posts: posts));

    } catch (e) {
      developer.log(e.toString());
    }
  }
}
