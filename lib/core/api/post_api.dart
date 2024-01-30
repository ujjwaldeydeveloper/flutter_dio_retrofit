import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_dio_retrofit/core/models/post.dart';

part 'post_api.g.dart';

@RestApi()
abstract class PostApi {
  factory PostApi(Dio dio, {String baseUrl}) = _PostApi;

  @GET('/posts')
  Future<List<Post>> getPosts();
}
