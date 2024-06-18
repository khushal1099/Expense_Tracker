import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Button extends StatelessWidget {
  final String text;
  final double bRadius;
  final double height;
  final double width;
  final Color bColor;
  final Color? textColor;
  final bool isLoading;
  final void Function() onTap;

  const Button({
    super.key,
    required this.text,
    required this.onTap,
    required this.bRadius,
    required this.bColor,
    required this.height,
    required this.width,
    this.textColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: InkWell(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        onTap: isLoading ? null : onTap,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: bColor,
            borderRadius: BorderRadius.circular(bRadius),
          ),
          child: Center(
            child: isLoading
                ? const SizedBox(
              height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                )
                : Text(
                    text,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: textColor ?? Colors.black,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
