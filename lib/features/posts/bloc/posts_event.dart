part of 'posts_bloc.dart';

abstract class PostsEvent {

  PostsEvent();
}

class PostsInitialFetchEvent extends PostsEvent {}
