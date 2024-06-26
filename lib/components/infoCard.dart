import 'package:Hostinaar/helpers/constants.dart';
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
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 45,
                color: kSemiPrimaryColor,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 18,color: Colors.grey[300]),
              ),
              Text(
                info,
                style: TextStyle(fontSize: 16,color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
