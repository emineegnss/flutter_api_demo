import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'blog.dart';

class HomeController extends GetxController {
  final blogs = <Blog>[].obs;
  final isLoading = true.obs;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String get getTitle => titleController.text.trim();
  String get getDesc => descriptionController.text.trim();

  @override
  void onInit() {
    blog();
    super.onInit();
  }

  Future<void> blog() async {
    isLoading.value = true;
    try {
      final result = await Dio().get("http://78.189.154.147/blog");
      List<dynamic> items = result.data;
      blogs.value = items.map((e) => Blog.fromMap(e)).toList();
    } catch (_) {}
    isLoading.value = false;
  }

  Future<void> addBlog(String title, String description) async {
    isLoading.value = true;
    try {
      final result = await Dio().post("http://78.189.154.147/blog", data: {"title": title, "description": description});
      blogs.add(Blog.fromMap(result.data));
    } catch (_) {}
    isLoading.value = false;
  }

  Future<void> deleteBlog(int id) async {
    isLoading.value = true;
    try {
      await Dio().delete("http://78.189.154.147/blog", queryParameters: {"id": id});
      blogs.removeWhere((element) => element.id == id);
    } catch (_) {}
    isLoading.value = false;
  }

  Future<void> updateBlog(int id, String title, String description) async {
    isLoading.value = true;
    try {
      final result =
          await Dio().put("http://78.189.154.147/blog", data: {"id": id, "title": title, "description": description});

      final index = blogs.indexWhere((element) => element.id == id);
      blogs[index] = Blog.fromMap(result.data);
    } catch (_) {}
    isLoading.value = false;
  }
}
