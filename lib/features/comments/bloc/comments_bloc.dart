import 'dart:async';
import 'dart:developer';
import 'package:api_request_bloc/features/comments/models/comments_data_model.dart';
import 'package:api_request_bloc/features/comments/repo/comments_repo.dart';
import 'package:bloc/bloc.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsBloc() : super(CommentsInitial()) {
    on<CommentsInitialFetchEvent>(commentssInitialFetchEvent);
    on<CommentsAddEvent>(addComment);
  }

  FutureOr<void> commentssInitialFetchEvent(
      CommentsInitialFetchEvent event, Emitter<CommentsState> emit) async {
    emit(CommentsLoadingState());

    List<CommentsDataModel> comments = await CommentsRepo.fetchPosts();
    emit(CommentFetchSuccessfulState(comments: comments));
  }

  FutureOr<void> addComment(
      CommentsAddEvent event, Emitter<CommentsState> emit) async {
    bool success = await CommentsRepo.addComments();

    if (success) {
      emit(CommentAdditionSuccessState());
      log(CommentAdditionSuccessState().toString());
    } else {
      emit(CommentAdditionFailureState());
      log(CommentAdditionFailureState().toString());
    }
  }
}
