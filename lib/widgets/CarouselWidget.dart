// ignore_for_file: file_names, sized_box_for_whitespace, prefer_const_constructors

import 'package:carousel_pro/carousel_pro.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CarouselWidget extends StatefulWidget {
  List<Widget>? items;

  CarouselWidget({Key? key, this.items}) : super(key: key);

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    
    return Container(
      height: 200,
      width: 500,
      child: Carousel(
        borderRadius: true,
        dotBgColor: Colors.transparent,
        dotColor: Theme.of(context).primaryColor,
        dotVerticalPadding: -20,
        dotSize: 10,
        images: widget.items,
        radius: Radius.circular(20),
        animationCurve: Curves.easeInCirc,
        noRadiusForIndicator: true,
      ),
    );
  }
}
