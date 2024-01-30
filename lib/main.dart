import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dio_retrofit/core/api/post_api.dart';
import 'package:flutter_dio_retrofit/core/models/post.dart';
import './feature/get_api_example/dio_get_example';
import './feature/post_api_example/dio_post_example';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API example with Dio'),
      ),
      body: _buildBody(context),
    );
  }

  FutureBuilder<List<Post>> _buildBody(
    BuildContext context,
  ) {
    final PostApi client = PostApi(
      Dio(
        BaseOptions(
            contentType: "application/json",
            baseUrl: 'https://jsonplaceholder.typicode.com'),
      ),
    );

    return FutureBuilder<List<Post>>(
      future: client.getPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<Post> posts = snapshot.data ?? <Post>[];
          return _buildPosts(context, posts);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildPosts(BuildContext context, List<Post> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final Post item = posts[index];
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            item.title ?? '',
          ),
        );
      },
    );
  }
}

