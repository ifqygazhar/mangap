import 'package:flutter/material.dart';
import 'package:mangap/core/common/widget/button.dart';
import 'package:mangap/core/constants/color.dart';

class ErrorWidgetComponent extends StatefulWidget {
  const ErrorWidgetComponent({
    super.key,
    required this.errorMessage,
    required this.onTap,
  });

  final String errorMessage;
  final Function() onTap;

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
      width: 240,
      height: 240,
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
            style: const TextStyle(
              color: ColorConstant.whiteColor,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          ButtonWidget(
            onTap: widget.onTap,
            color: ColorConstant.kThird,
            text: "Refresh",
            circular: 8,
          )
        ],
      ),
    );
  }
}
