import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  // final List<Post> posts;
  //  final posts = await ApiService().getPosts();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: Text("aaaaa"),
      //  ListView.builder(
      //   itemCount: posts.length,
      //   itemBuilder: (context, index) {
      //     final post = posts[index];
      //     return ListTile(title: Text(post.title), subtitle: Text(post.body));
      //   },
      // ),
    );
  }
}
