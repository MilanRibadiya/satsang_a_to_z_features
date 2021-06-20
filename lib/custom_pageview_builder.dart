import 'package:flutter/material.dart';

class CustomPageViewBuilder extends StatefulWidget {
  // const CustomPageViewBuilder({Key key}) : super(key: key);
  final int itemCount;

  CustomPageViewBuilder(this.itemCount);

  @override
  _CustomPageViewBuilderState createState() => _CustomPageViewBuilderState();
}

class _CustomPageViewBuilderState extends State<CustomPageViewBuilder> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        itemCount: widget.itemCount, itemBuilder: (context, index) {});
  }
}
