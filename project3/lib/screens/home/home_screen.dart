import 'package:flutter/material.dart';
import 'package:project3/models/post_model.dart';
import 'package:project3/screens/home/post_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PostViewModel>().fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PostViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.refresh),
          //   onPressed: () => context.read<PostViewModel>().fetchPosts(),
          // ),
        ],
      ),
      body:
          provider.isLoading
              ? Center(child: CircularProgressIndicator())
              : provider.error != null
              ? _ErrorView(error: provider.error!)
              : _PostListView(posts: provider.posts),
    );
  }
}

class _PostListView extends StatelessWidget {
  final List<PostModel> posts;

  const _PostListView({required this.posts});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        context.read<PostViewModel>().fetchPosts(forceUpdate: true);
      },
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: posts.length,
        separatorBuilder: (context, index) => const Divider(height: 32),
        itemBuilder: (context, index) {
          final post = posts[index];
          return Card(
            elevation: 2,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                post.title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  post.body,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                ),
              ),
              onTap: () {
                // Post detay sayfasına gidebilir
              },
            ),
          );
        },
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String error;

  const _ErrorView({required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            error,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.read<PostViewModel>().fetchPosts(),
            child: const Text('Tekrar Dene'),
          ),
        ],
      ),
    );
  }
}
