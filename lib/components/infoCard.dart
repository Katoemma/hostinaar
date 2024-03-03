import 'package:Hostinaar/utilities/constants.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final IconData icon;
  final String info;


  const InfoCard({super.key, required this.title, required this.onTap, required this.icon, required this.info});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: InkWell(
        onTap: onTap,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 45,
                color: kPrimaryColor,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 18),
              ),
              Text(
                info,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
