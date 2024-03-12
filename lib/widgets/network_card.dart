

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:vpn_basic_project/models/network_card.dart';
import '../main.dart';

class NetworkCard extends StatelessWidget {
  final NetworkData data;
  const NetworkCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {

    return  Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: mq.height* .01),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      child:InkWell(
      onTap: () { },
      borderRadius: BorderRadius.circular(13),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),

        leading: Icon(data.icon.icon, color: data.icon.color, size: data.icon.size ?? 28,),
        
        //title
        title:
          Text(data.title),
        

        //subtitle
        subtitle: Text(data.subtitle),

      ),
    ));
  }
}