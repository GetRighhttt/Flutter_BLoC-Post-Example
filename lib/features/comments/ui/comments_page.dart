// ignore_for_file: type_literal_in_constant_pattern

import 'package:api_request_bloc/features/comments/bloc/comments_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final CommentsBloc commentsBloc = CommentsBloc();

  @override
  void initState() {
    commentsBloc.add(CommentsInitialFetchEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments Page'),
      ),
      floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {}),
      body: BlocConsumer<CommentsBloc, CommentsState>(
          bloc: commentsBloc,
          listenWhen: (previous, current) => current is CommentsActionState,
          buildWhen: (previous, current) => current is! CommentsActionState,
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {

              case CommentsLoadingState():
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case CommentFetchSuccessfulState:
                final successState = state as CommentFetchSuccessfulState;
                return ListView.builder(
                  itemCount: successState.comments.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: const Color.fromARGB(255, 75, 195, 247),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Title:'),
                          Text(successState.comments[index].name),
                          const Text('Body:'),
                          Text(successState.comments[index].body),
                        ],
                      ),
                    );
                  },
                );

              case CommentsFailureState:
                final failureState = state as CommentsFailureState;
                return Text(failureState.toString());

              default:
                return const SizedBox();
            }
          }),
    );
  }
}
