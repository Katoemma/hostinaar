import 'package:flutter/material.dart';

class MyCustomInput extends StatelessWidget {
  const MyCustomInput(
      {super.key,
      required this.inPutLabelText,
      required this.inPutHintText,
      required this.inputCotroller});

  final String inPutLabelText;
  final String inPutHintText;
  final TextEditingController inputCotroller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(inPutLabelText),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          controller: inputCotroller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            hintText: inPutHintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                18,
              ),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}
