import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/controller/home_controller.dart';
import 'package:vpn_basic_project/helper/my_details.dart';
import 'package:vpn_basic_project/helper/pref.dart';
import 'package:vpn_basic_project/models/vpn.dart';
import 'package:vpn_basic_project/services/vpn_engine.dart';

import '../main.dart';

class VpnCard extends StatelessWidget {
  final VPN vpn;
  const VpnCard({super.key, required this.vpn});

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<HomeController>();

    return  Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: mq.height* .01),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      child:InkWell(
      onTap: () {
        controller.vpn.value = vpn;
        Pref.vpn = vpn;
        Get.back();

        MyDialogs.success(msg: 'Connection VPN....');

        if(controller.vpnState.value == VpnEngine.vpnConnected){
          VpnEngine.stopVpn();
          Future.delayed(
            Duration(seconds: 2), () =>  controller.connectToVpn()
          );
        }
        else{
        controller.connectToVpn();
        }
      },
      borderRadius: BorderRadius.circular(13),
    child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),

        leading: Container(
        padding: EdgeInsets.all(.5),
        decoration: BoxDecoration(border: Border.all(color: Colors.black12), borderRadius: BorderRadius.circular(10)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset('assets/flags/${vpn.countryshort.toLowerCase()}.png', height: 40, width: mq.width* .15, fit: BoxFit.cover,),
        )
        
        ),
        
        //title
        title:
          Text(vpn.countrylong,style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
        

        //subtitle
        subtitle: Row(
          children: [
            Icon(Icons.speed_rounded, color: Colors.blue, ),
            SizedBox(height: 4,),
            Text(_formatBytes(vpn.speed, 1),style: TextStyle(color: Colors.black54, fontSize: 12, fontWeight: FontWeight.bold))
          ],
        ),

        //trailing
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(vpn.numvpnsessions.toString(), style: TextStyle(color: Colors.black54, fontSize: 12, fontWeight: FontWeight.bold),),
                    SizedBox(width: 5,),
            Icon(CupertinoIcons.person_3_fill, color: Colors.blue, ),
          ],
        ),
        
      ),
    ));
  }

    String _formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ['Bps', "Kbps", "Mbps", "Gbps", "Tbps"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}