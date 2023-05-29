// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_conditional_assignment, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:web_application/widgets/MyText.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class MainMenuItem extends StatelessWidget {
  String? url;
  String? content;
  Function()? navigation;
  bool? useNetwork;
  String? urlFunction;

  MainMenuItem(
      {this.url,
      this.content,
      this.navigation,
      this.useNetwork,
      this.urlFunction});

  @override
  Widget build(BuildContext context) {
    if (useNetwork == null) useNetwork = false;
    
    return InkWell(
      onTap: navigation == null ?
          () async {
            await launch(urlFunction!);
          } : navigation!,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shadowColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              
              children: [
                Center(
                    child: Container(
                        width: 100,
                        height: 100,
                        child: Image(
                          image:
                              (useNetwork! ? NetworkImage(url!) : AssetImage(url!)) as ImageProvider,
                          fit: BoxFit.fill,
                          errorBuilder: (context , error , stackTrace)=> const Image(image: AssetImage("images/error.gif  "),fit: BoxFit.fill,),
                        ))),
                Center(
                  child: MyText(
                    content: content!,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
