import 'dart:async';
import 'package:api_request_bloc/features/posts/models/post_data_model.dart';
import 'package:api_request_bloc/features/posts/repo/posts_repo.dart';
import 'package:bloc/bloc.dart';
import 'dart:developer';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
    on<PostAddEvent>(postAddEvent);
  }

  FutureOr<void> postsInitialFetchEvent(
      PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
    emit(PostsLoadingState());

    List<PostDataModel> posts = await PostsRepo.fetchPosts();
    emit(PostFetchSuccessfulState(posts: posts));
    log(posts.toString());
  }

  FutureOr<void> postAddEvent(
      PostAddEvent event, Emitter<PostsState> emit) async {
    bool success = await PostsRepo.addPost();

    if (success) {
      emit(PostAdditionSuccessState());
    } else {
      emit(PostAdditionFailureState());
    }
  }
}
