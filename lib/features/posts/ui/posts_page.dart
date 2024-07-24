// ignore_for_file: type_literal_in_constant_pattern

import 'dart:developer';

import 'package:api_request_bloc/features/comments/bloc/comments_bloc.dart';
import 'package:api_request_bloc/features/comments/ui/comments_page.dart';
import 'package:api_request_bloc/notifier/notifiers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_request_bloc/features/posts/bloc/posts_bloc.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final PostsBloc postsBloc = PostsBloc();
  final CommentsBloc commentsBloc = CommentsBloc();
  static const platform = MethodChannel('stefan.samples/battery');

  String _batteryLevel = 'Loading..';

  @override
  void initState() {
    postsBloc.add(PostsInitialFetchEvent());
    // only run when on android and need battery life. Will crash with iOS...
    // getBatteryLevel();
    log(_batteryLevel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
        leading: IconButton(
          onPressed: () {
            showDialog<String>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Get Battery Level'),
                content: Text(_batteryLevel),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text(
                      'cancel',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'ok'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
          icon: const Icon(Icons.battery_0_bar),
        ),
        actions: [
          IconButton(
              onPressed: () {
                isDarkNotifier.value = !isDarkNotifier.value;
              },
              icon: const Icon(Icons.light))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            // add comments to log
            commentsBloc.add(CommentsInitialFetchEvent());
            log(CommentsInitialFetchEvent().toString());

            // show Bottom sheet
            showModalBottomSheet<void>(
              context: context,
              enableDrag: true,
              isScrollControlled: true,
              useSafeArea: true,
              builder: (BuildContext context) {
                return const CommentPage();
              },
            );
          }),
      body: BlocConsumer<PostsBloc, PostsState>(
          bloc: postsBloc,
          listenWhen: (previous, current) => current is PostsActionState,
          buildWhen: (previous, current) => current is! PostsActionState,
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {
              case PostsLoadingState:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case PostFetchSuccessfulState:
                final successState = state as PostFetchSuccessfulState;
                return ListView.builder(
                  itemCount: successState.posts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Post Title:'),
                          Text(successState.posts[index].title),
                          const Text('Body:'),
                          Text(successState.posts[index].body),
                        ],
                      ),
                    );
                  },
                );

              case PostsFailureState:
                final failureState = state as PostsFailureState;
                return Text(failureState.toString());

              default:
                return const SizedBox();
            }
          }),
    );
  }

  // method to call android method
  Future getBatteryLevel() async {
    String batteryLevel;
    try {
      final result = await platform.invokeMethod<int>('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
}
