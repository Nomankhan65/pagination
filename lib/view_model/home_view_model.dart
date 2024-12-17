
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pagination/repository/home_repo.dart';
import '../model/post_model.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  final HomeRepo _postService = HomeRepo();

   var posts = <PostModel>[].obs;
  var isLoading = false.obs;
  var hasMore = true.obs;
  var page = 1.obs;
  final int limit = 10;

  // Fetch posts method
  Future<void> fetchPosts() async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;
    try {
      List<PostModel> newPosts = await _postService.fetchPosts(page.value, limit);
      if (newPosts.isEmpty) {
        hasMore.value = false; // No more posts to load
      } else {
        posts.addAll(newPosts);
        page.value++; // Increment the page for the next fetch
      }
    } catch (e) {
      print("Error fetching posts: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
