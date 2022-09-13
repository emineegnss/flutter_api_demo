import 'package:flutter/material.dart';
import 'package:flutter_application_api/home_controller.dart';
import 'package:flutter_application_api/model.dart';
import 'package:get/get.dart';

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: controller.blog,
              child: ListView(
                children: controller.blogs
                    .map((e) => ListTile(
                          title: Text(e.title),
                          subtitle: Text(e.description),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    await Get.dialog(AddUpdateModal(blog: e));
                                    controller.titleController.clear();
                                    controller.descriptionController.clear();
                                  },
                                  icon: Icon(
                                    Icons.edit_outlined,
                                    color: Colors.black,
                                  )),
                              IconButton(
                                onPressed: () => controller.deleteBlog(e.id),
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.dialog(AddUpdateModal());
          controller.titleController.clear();
          controller.descriptionController.clear();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
