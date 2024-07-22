part of 'comments_bloc.dart';

abstract class CommentsEvent {

  CommentsEvent();
}

class CommentsInitialFetchEvent extends CommentsEvent {}
class CommentsAddEvent extends CommentsEvent {}
