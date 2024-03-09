import 'package:Hostinaar/helpers/constants.dart';
import 'package:flutter/material.dart';


class MyCustomScreen extends StatelessWidget {
  const MyCustomScreen({super.key, required this.widgets, required this.screenTitle, required this.additionalHeight});

  final List<Widget> widgets;
  final String screenTitle;
  final double additionalHeight;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height + additionalHeight,
        color: kPrimaryColor,
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'images/bgImage.png',
                  ),
                ],
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      'images/icon.png',
                      width: MediaQuery.of(context).size.width*0.35,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      screenTitle,
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'NotoSan',
                          fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: widgets,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
