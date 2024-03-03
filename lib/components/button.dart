import 'package:flutter/material.dart';


class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.onPressed, required this.btnText, required this.btnColour});

  final VoidCallback onPressed;
  final String btnText;
  final Color btnColour; // Add this line to add a color property

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding:  EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: btnColour,
          borderRadius:
              BorderRadius.circular(18), // Adjust the border radius as needed
        ),
        child:Text(
          btnText,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
