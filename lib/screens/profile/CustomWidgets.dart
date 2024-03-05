import 'package:Hostinaar/utilities/constants.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key, required this.screenTitle});
  final String screenTitle;

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          style: ButtonStyle(
            side: MaterialStateProperty.all(
              const BorderSide(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(
          width: 100,
        ),
        Text(
          widget.screenTitle,
          style: const TextStyle(color: Colors.white, fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class OptionsListWidget extends StatefulWidget {
   OptionsListWidget(
      {super.key,
      required this.icon,
      required this.title,
      required this.onPressed,
      this.color});
  final IconData icon;
  final String title;
  final VoidCallback onPressed;
  Color? color;

  @override
  State<OptionsListWidget> createState() => _OptionsListWidgetState();
}

class _OptionsListWidgetState extends State<OptionsListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: widget.color ?? Colors.orange[100],
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              widget.icon,
              color: kSecondaryColor,
            ),
          ),
          title: Text(
            widget.title,
            style: const TextStyle(fontSize: 18),
          ),
          trailing: const Icon(
            Icons.navigate_next,
            color: Colors.grey,
          ),
          onTap: widget.onPressed,
        ),
        const SizedBox(
          height: 14,
        )
      ],
    );
  }
}
