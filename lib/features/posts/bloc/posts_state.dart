part of 'posts_bloc.dart';

// regular post states
abstract class PostsState {}
class PostsInitial extends PostsState {}
class PostsFailureState extends PostsState {}
class PostsLoadingState extends PostsState {}

class PostFetchSuccessfulState extends PostsState {
  final List<PostDataModel> posts;
  PostFetchSuccessfulState({
    required this.posts,
  });
}

// action states used for listeners
abstract class PostsActionState extends PostsState {}
class PostAdditionSuccessState extends PostsActionState {}
class PostAdditionFailureState extends PostsActionState {}
