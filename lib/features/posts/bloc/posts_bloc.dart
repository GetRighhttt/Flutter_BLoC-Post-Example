import 'dart:async';
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
    try {
      var response =
          await client.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      developer.log(response.body);
    } catch (e) {
      developer.log(e.toString());
    }
  }
}
