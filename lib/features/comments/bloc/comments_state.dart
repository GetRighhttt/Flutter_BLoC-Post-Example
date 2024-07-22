part of 'comments_bloc.dart';

// regular comment states

abstract class CommentsState {}
class CommentsInitial extends CommentsState {}
class CommentsFailureState extends CommentsState {}
class CommentsLoadingState extends CommentsState {}

class CommentFetchSuccessfulState extends CommentsState {
  final List<CommentsDataModel> comments;
  CommentFetchSuccessfulState({
    required this.comments,
  });
}

// action states used for listeners
abstract class CommentsActionState extends CommentsState {}
class CommentAdditionSuccessState extends CommentsActionState {}
class CommentAdditionFailureState extends CommentsActionState {}
