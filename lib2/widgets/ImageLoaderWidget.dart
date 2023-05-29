// ignore_for_file: file_names, must_be_immutable

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker_for_web/image_picker_for_web.dart';
// import 'package:image_picker_web/image_picker_web.dart';
import 'package:web_application/widgets/MyText.dart';

class ImageLoaderWidget extends StatefulWidget {
  String? name;
  File? file;
  String? hintText;
  Uint8List? web_file;

  String getFileName() {
    if (web_file != null) {
      return "file from web version" + DateTime.now().microsecond.toString();
    }
    String temp = '';
    temp = file!.path
        .toString()
        .substring(file!.path.toString().lastIndexOf('/') + 1);
    return temp + DateTime.now().microsecond.toString();
  }

  String? getFile() {
    if (file == null && web_file == null) return null;
    if (GetPlatform.isWeb) return base64Encode(web_file!);
    List<int> imageBytes = file!.readAsBytesSync();
    String baseimage = base64Encode(imageBytes);
    return baseimage;
  }

  ImageLoaderWidget({Key? key, this.name, this.file, this.hintText})
      : super(key: key);

  @override
  _ImageLoaderWidgetState createState() => _ImageLoaderWidgetState();
}

class _ImageLoaderWidgetState extends State<ImageLoaderWidget> {
  Future getImagefromgallery() async {
    XFile? pickedFile = null;
    widget.web_file = null;
    if (defaultTargetPlatform != TargetPlatform.android && defaultTargetPlatform != TargetPlatform.iOS) {
      // if(defaultTargetPlatform != TargetPlatform.android && defaultTargetPlatform != TargetPlatform.iOS)
      // await ImagePickerPlugin().pickImage(source: ImageSource.gallery).then((value) => widget.web_file = File(value.path).readAsBytesSync());
      // widget.web_file = await ImagePickerWeb.getImageAsBytes();
      print("here is web app");
    } else {
      pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    }

    setState(() {
      if (pickedFile != null) {
        // print(widget.web_file!.length);
        widget.file = File(pickedFile.path);
      } else {}
    });
  }

  Future getImagefromcamera() async {
    XFile? pickedFile;
    widget.web_file = null;
    if (defaultTargetPlatform != TargetPlatform.android && defaultTargetPlatform != TargetPlatform.iOS) {
      // if(defaultTargetPlatform != TargetPlatform.android && defaultTargetPlatform != TargetPlatform.iOS)
      // await ImagePickerPlugin().pickImage(source: ImageSource.gallery).then((value) => widget.web_file = File(value.path).readAsBytesSync());
      // widget.web_file = await ImagePickerWeb.getImageAsBytes();
      print("here is web app");
    } else {
      pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    }
    print("here is where we arrived");
    setState(() {
      if (pickedFile != null) {
        widget.file = File(pickedFile.path);
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: Theme.of(context).primaryColor,
          indent: 30,
          endIndent: 30,
          thickness: 1,
        ),
        Container(
          child: widget.file == null && widget.web_file == null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyText(
                      content: widget.hintText ??= "لا يوجد صورة مختارة",
                    ),
                  ),
                )
              : GetPlatform.isWeb
                  ? Image.memory(widget.web_file!)
                  : Image.file(widget.file!),
          width: double.infinity,
          height: 250,
          color: Colors.grey,
        ),
        Divider(
          color: Theme.of(context).primaryColor,
          indent: 30,
          endIndent: 30,
          thickness: 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: getImagefromgallery,
              child: Row(
                children: [
                  IconButton(
                    onPressed: getImagefromgallery,
                    icon: const Icon(
                      Icons.image_outlined,
                      size: 35,
                    ),
                  ),
                  MyText(
                    content: "المعرض",
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: getImagefromcamera,
              child: Row(
                children: [
                  IconButton(
                      onPressed: getImagefromcamera,
                      icon: const Icon(
                        Icons.camera,
                        size: 35,
                      )),
                  MyText(
                    content: "الكاميرا",
                  ),
                ],
              ),
            )
          ],
        ),
        Divider(
          color: Theme.of(context).primaryColor,
          indent: 30,
          endIndent: 30,
          thickness: 1,
        ),
      ],
    );
  }
}
