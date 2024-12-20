
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graduan_test/ClassAndServices/ErrorHandler.dart';
import 'package:graduan_test/ClassAndServices/PageNavigatorService.dart';
import 'package:graduan_test/ClassAndServices/Post/Post.dart';
import 'package:graduan_test/UserInterface/PostPages/CreatePostPage.dart';
import 'package:graduan_test/UserInterface/PostPages/ViewAllPostsPage.dart';
import 'package:graduan_test/UserInterface/UserPages/SignInPage.dart';
import 'package:http/http.dart' as http;

class PostServices{

  void goToCreatePostPage(BuildContext context,) {
    PageNavigatorService.navigateTo(context, CreatePostPage());
  }

  void goToViewAllPostsPage(BuildContext context,) {
    PageNavigatorService.navigateTo(context, ViewAllPostsPage());
  }

  Future<ReturnListOfPosts?> getPosts() async {
    const String apiUrl = "https://flutter-api-demo.graduan.xyz/api/post";
    bool success = false;
    String text ="";
    Object? error;
    ReturnListOfPosts? returnListOfPosts;
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $authTokenGlobal',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> decodedData = jsonDecode(response.body);
        List<Post> listOfPosts = decodedData.map((val) => Post.fromJson(val as Map<String, dynamic>)).toList();
        success = true;
        text = "Get Posts Successful";

        returnListOfPosts = ReturnListOfPosts(text: text, success: success, posts: listOfPosts);

      } else {
        success = false;
        text = "Failed To Get Posts [${response.statusCode}]";
      }
    } catch (e) {
      success = false;
      text = "Failed To Get Posts: $e";
      error = e;
    }
    print(text);
    ErrorHandler().logSuccessOrError(success: success, text: text, error: error);
    return returnListOfPosts;
  }

  Future<ReturnPost?> createPost({required String title}) async {
    const String apiUrl =  "https://flutter-api-demo.graduan.xyz/api/dashboard/post";

    bool success = false;
    String text ="";
    Object? error;
    ReturnPost? returnPost;

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $authTokenGlobal',
        },
        body: {
          'title': title,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print(data);
        success = true;
        text = "Create Post Successful";
        returnPost = ReturnPost(text: text, success: success, post:  Post.fromJson(data));

      } else {
        success = false;
        text = "Failed To Create Post [${response.statusCode}]";
      }
    } catch (e) {
      success = false;
      text = "Failed To Create Post: $e";
      error = e;
    }
    ErrorHandler().logSuccessOrError(success: success, text: text, error: error);
    return returnPost;
  }


}