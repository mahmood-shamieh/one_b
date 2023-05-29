// ignore_for_file: prefer_const_constructors, must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_application/Constant.dart';

class ADSLWidget extends StatefulWidget {
  String? name;
  Function()? function;
  ADSLWidget({
    Key ?key,
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
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: InkWell(
          onTap:widget.function,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: greenColor, spreadRadius: 5, blurRadius: 10)
                  ]),
              child: CircleAvatar(
                child:
                 Padding(
                   padding: const EdgeInsets.all(18.0),
                   child: ClipRRect(
                     borderRadius: BorderRadius.circular(20),
                     child: Image(
                        errorBuilder: (context, error, stackTrace) => Image(
                          image: AssetImage("images/error.gif"),
                          fit: BoxFit.contain,
                        ),
                        fit: BoxFit.cover,
                        image: AssetImage(getImageLink()),
                      ),
                   ),
                 ),
                backgroundColor: Colors.grey.withOpacity(0.3),
                maxRadius: GetPlatform.isAndroid ? (MediaQuery.of(context).size.width / 8) + 29:  80,
                
              ),
            ),
          ),
        ),
      ),
    );
  }
}
