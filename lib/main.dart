import 'package:api_request_bloc/features/posts/ui/posts_page.dart';
import 'package:api_request_bloc/notifier/notifiers.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isDarkNotifier,
        builder: (context, isDark, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                brightness: isDark ? Brightness.dark : Brightness.light,
                primarySwatch: Colors.blue,
                useMaterial3: true),
            home: const PostPage(),
          );
        });
  }
}
