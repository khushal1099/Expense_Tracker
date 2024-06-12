import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;
  final String text;
  final Color iconcolor;
  final IconData icon;
  final List<Color> colors;

  const ContainerWidget({
    super.key,
    required this.height,
    required this.width,
    required this.borderRadius,
    required this.text,
    required this.iconcolor,
    required this.icon,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(fontSize: 25),
              ),
              Icon(
                icon,
                color: iconcolor,
                size: 30,
              )
            ],
          ),
          Text(
            "1000.60",
            style: TextStyle(color: iconcolor),
          ),
        ],
      ),
    );
  }
}
