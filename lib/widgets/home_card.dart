import 'package:flutter/material.dart';

import '../main.dart';

class HomeCard extends StatelessWidget {

  final title, subtitle;
  final Widget icon;

  const HomeCard({super.key, this.title, this.subtitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
        width: mq.width* .45,
        child: Column(children: [
          icon,
          SizedBox(height: 6,),
          Text(title, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
          SizedBox(height: 6,),
          Text(subtitle, style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54),)
        ])
    );
  
  }
}