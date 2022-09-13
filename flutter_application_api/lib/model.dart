import 'package:flutter/material.dart';
import 'package:flutter_application_api/blog.dart';
import 'package:flutter_application_api/home_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddUpdateModal extends GetView<HomeController> {
  const AddUpdateModal({Key? key, this.blog}) : super(key: key);
  final Blog? blog;
  @override
  Widget build(BuildContext context) {
    if (blog != null) {
      controller.titleController.text = blog!.title;
      controller.descriptionController.text = blog!.description;
    }

    return AlertDialog(
      title: Text(blog != null ? "Update" : "Add"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller.titleController,
            decoration: InputDecoration(
              hintText: "Enter Title",
              hintStyle: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
              )),
            ),
          ),
          TextField(
            controller: controller.descriptionController,
            decoration: InputDecoration(
              hintText: "Enter Description",
              hintStyle: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
              )),
            ),
          ),
        ],
      ),
      actions: [
        MaterialButton(
          onPressed: (() {
            if (blog == null) {
              controller.addBlog(controller.getTitle, controller.getDesc);
            } else {
              controller.updateBlog(blog!.id, controller.getTitle, controller.getDesc);
            }
            Get.back();
            Get.snackbar(
              "Successful",
              blog == null ? "added" : "edited",
              duration: Duration(milliseconds: 750),
              titleText: Row(
                children: [
                  Text(
                    "Succesful",
                    style: TextStyle(color: Colors.green),
                  ),
                  Icon(
                    Icons.check,
                    color: Colors.green,
                  )
                ],
              ),
              messageText: Text(
                blog == null ? "Added" : "Edited",
                style: TextStyle(color: Colors.white),
              ),
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.green,
              backgroundColor: Colors.grey[600],
            );
            controller.titleController.clear();
            controller.descriptionController.clear();
          }),
          elevation: 5.0,
          child: Text(
            blog == null ? "Add" : "Edit",
          ),
        )
      ],
    );
  }
}
