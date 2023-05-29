// ignore_for_file: prefer_const_constructors, must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_application/Constant.dart';

class ADSLWidget extends StatefulWidget {
  String? name;
  Function()? function;
  ImageProvider? provider;

  ADSLWidget({
    Key? key,
    this.name,
    this.function,
  }) : super(key: key);

  @override
  _ADSLWidgetState createState() => _ADSLWidgetState();
}

class _ADSLWidgetState extends State<ADSLWidget> {
  String getImageLink() {
    switch (widget.name) {
      case "يارا":
        return "images/يارا.png";
      case "MTN ADSL":
        return "images/ام اي ان.png";
      case "HiFi":
        return "images/هايفاي.png";
      case "هايبر نت":
        return "images/هايبر نت.png";
      case "ناس":
        return "images/ناس.png";
      case "ليما":
        return "images/ليما.png";
      case "لاين نت":
        return "images/لاين نت.png";
      case "ليزر نت":
        return "images/لايبر نت.png";
      case "VIEW":
        return "images/فيو.png";
      case "سوا":
        return "images/سوا.png";
      case "سما نت":
        return "images/سما نت.png";
      case "زاد":
        return "images/زاد.png";
      case "رن نت":
        return "images/رن نت.png";
      case "دنيا":
        return "images/دنيا.png";
      case "تكامل":
        return "images/تكامل.png";
      case "بطاقات":
        return "images/بطاقات.png";
      case "برونت":
        return "images/برونت.png";
      case "INET":
        return "images/آي نت.png";
      case "أمواج":
        return "images/أمواج.png";
      case "أمنية":
        return "images/أمنية.png";
      case "MTS":
        return "images/ام كي اس.png";
      case "إلكم":
        return "images/إلكم.png";
      case "الجمعية العلمية":
        return "images/الجمعية العلمية.png";
      case "اَية":
        return "images/آية.png";
      default:
        return 'images/error.gif';
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.provider = AssetImage(getImageLink());
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: widget.function,
          child: Container(
            width: (GetPlatform.isAndroid
                    ? (MediaQuery.of(context).size.width / 8) + 29
                    : 80) *
                2,
            height: (GetPlatform.isAndroid
                    ? (MediaQuery.of(context).size.width / 8) + 29
                    : 80) *
                2,
            decoration: BoxDecoration(
                // shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                  image: widget.provider!,
                  onError: (exception, stackTrace) => setState(() {
                    widget.provider =AssetImage("images/error.gif");
                  }),
                ),
                borderRadius: BorderRadiusDirectional.circular(18),
                boxShadow: [
                  BoxShadow(color: blueColor, spreadRadius: 5, blurRadius: 10)
                ]),
            // child:
            // Image(
            //   errorBuilder: (context, error, stackTrace) => Image(
            //     image: AssetImage("images/error.gif"),
            //     fit: BoxFit.contain,
            //   ),
            //   fit: BoxFit.cover,
            //   image: AssetImage(getImageLink()),
            // ),
          ),
        ),
      ),
    );
  }
}
