import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color? color;
  final GestureTapCallback? func;
  const BottomButton({
    Key? key,
    required this.text,
    this.style,
    this.color,
    this.func,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.transparent,
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: func,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: color,
          ),
          child: Center(
            child: Text(
              text.toUpperCase(),
              style: style,
            ),
          ),
        ),
      ),
    );
  }
}
