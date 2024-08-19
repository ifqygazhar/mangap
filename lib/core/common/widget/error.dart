import 'package:flutter/material.dart';
import 'package:mangap/core/common/widget/button.dart';
import 'package:mangap/core/constants/color.dart';

class ErrorWidgetComponent extends StatefulWidget {
  const ErrorWidgetComponent({
    super.key,
    required this.errorMessage,
    required this.onTap,
    this.widthImage = 240,
    this.heightImage = 240,
    this.textSize = 18,
    this.textButton = "Refresh",
  });

  final String errorMessage;
  final Function() onTap;
  final double widthImage, heightImage;
  final double textSize;
  final String textButton;

  @override
  State<ErrorWidgetComponent> createState() => _ErrorWidgetComponentState();
}

class _ErrorWidgetComponentState extends State<ErrorWidgetComponent> {
  late Image errorImage;

  @override
  void initState() {
    super.initState();
    errorImage = Image.asset(
      "assets/images/error.gif",
      width: widget.widthImage,
      height: widget.heightImage,
    );
  }

  @override
  void didChangeDependencies() {
    precacheImage(errorImage.image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          errorImage,
          const SizedBox(height: 12),
          Text(
            widget.errorMessage,
            style: TextStyle(
              color: ColorConstant.whiteColor,
              fontSize: widget.textSize,
            ),
          ),
          const SizedBox(height: 8),
          ButtonWidget(
            icon: null,
            onTap: widget.onTap,
            color: ColorConstant.kThird,
            text: widget.textButton,
            circular: 8,
            foregroundColor: ColorConstant.whiteColor,
            fontSize: widget.textSize,
          )
        ],
      ),
    );
  }
}
