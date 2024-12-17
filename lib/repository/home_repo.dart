import 'package:dio/dio.dart';

import '../model/post_model.dart';

class HomeRepo{
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com/posts';
  Dio dio=Dio();
  Future<List<PostModel>> fetchPosts(int page, int limit) async {
    final response = await dio.get('$_baseUrl?_page=$page&_limit=$limit');

    if (response.statusCode == 200) {
      // Map the response data into List<PostModel>
      return (response.data as List)
          .map((json) => PostModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

}