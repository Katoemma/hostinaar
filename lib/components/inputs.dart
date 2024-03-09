import 'package:flutter/material.dart';

class MyCustomInput extends StatefulWidget {
  const MyCustomInput(
      {super.key,
      required this.inPutLabelText,
      required this.inPutHintText,
      required this.inputCotroller, required this.isPassword});

  final String inPutLabelText;
  final String inPutHintText;
  final TextEditingController inputCotroller;
  final bool isPassword;

  @override
  State<MyCustomInput> createState() => _MyCustomInputState();
}

class _MyCustomInputState extends State<MyCustomInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.inPutLabelText),
        if (widget.inPutLabelText.isNotEmpty)
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          obscureText: widget.isPassword,
          controller: widget.inputCotroller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            hintText: widget.inPutHintText,
            hintStyle: TextStyle(
              color: Colors.grey[400],
            ),
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
