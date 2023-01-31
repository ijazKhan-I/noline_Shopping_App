import 'package:flutter/material.dart';

class Tile extends StatelessWidget {

  final String text;
  final String url;
  VoidCallback? onPressed;

  Tile({
    super.key,
    required this.text,
    required this.url,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.only(top: 12),
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              Image.asset(
                url,
                width: 60,
              ),
              Center(child: Text(text)),
            ],
          ),
        ));
  }
}
//SizedBox Custom Widget
class Box extends StatelessWidget{
  final double height;
  final double width;
  const Box({super.key, required this.height,required this.width});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }


}