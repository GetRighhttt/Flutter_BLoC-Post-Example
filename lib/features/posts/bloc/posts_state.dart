part of 'posts_bloc.dart';

abstract class PostsState {}

abstract class PostsActionState extends PostsState {}

class PostsInitial extends PostsState {}

class PostFetchSuccessfulState extends PostsState {
  final List<PostDataModel> posts;
  PostFetchSuccessfulState({
    required this.posts,
  });
}
