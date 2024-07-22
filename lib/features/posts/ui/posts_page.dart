import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_request_bloc/features/posts/bloc/posts_bloc.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final PostsBloc postsBloc = PostsBloc();

  @override
  void initState() {
    postsBloc.add(PostsInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API - Post Example'),
      ),
      body: BlocConsumer<PostsBloc, PostsState>(
          bloc: postsBloc,
          listenWhen: (previous, current) => current is PostsActionState,
          buildWhen: (previous, current) => current is! PostsActionState,
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {
              case PostFetchSuccessfulState:
                final successState = state as PostFetchSuccessfulState;
                return Container(
                  child: ListView.builder(
                    itemCount: successState.posts.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.blueGrey.shade100,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Title:'),
                            Text(successState.posts[index].title),
                            const Text('Body:'),
                            Text(successState.posts[index].body),
                            ],
                        ),
                      );
                    },
                  ),
                );
              case const (PostsFailure):
                final failureState = state as PostsFailure;
                return Text(failureState.toString());
              default:
              return const SizedBox();
            }
          }),
    );
  }
}
