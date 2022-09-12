import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final Function? clickButton;
  final double? width;

  const CustomButton({Key? key, this.title, this.clickButton, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      height: 45,
      width: width,
      child: ElevatedButton(
        onPressed: () {
          if (clickButton != null) clickButton!();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.blue),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        child: Text("$title",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            )),
      ),
    );
  }
}
