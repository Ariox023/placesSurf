import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormFiel extends StatefulWidget {
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final TextStyle? style;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const MyTextFormFiel({
    Key? key,
    this.controller,
    this.decoration = const InputDecoration(),
    this.style,
    this.onFieldSubmitted,
    this.validator,
    this.keyboardType = TextInputType.multiline,
    this.inputFormatters,
  }) : super(key: key);

  @override
  State<MyTextFormFiel> createState() => _MyTextFormFielState();
}

class _MyTextFormFielState extends State<MyTextFormFiel> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: widget.decoration,
      style: widget.style,
      onFieldSubmitted: widget.onFieldSubmitted,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
    );
  }
}
