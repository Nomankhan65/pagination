import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view_model/home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PostController postController = Get.put(PostController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postController.fetchPosts();
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Posts with Pagination'),
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                !postController.isLoading.value &&
                postController.hasMore.value) {
              postController.fetchPosts();
            }
            return false;
          },
          child: Obx(
                () => ListView.builder(
              itemCount: postController.posts.length +
                  (postController.hasMore.value ? 1 : 0), // Show loader if there are more posts
              itemBuilder: (context, index) {
                if (index == postController.posts.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                final post = postController.posts[index];
                return Card(
                  child: ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.body),
                  ),
                );
              },
            ),
          ),
        ),
      );
    }
  }
