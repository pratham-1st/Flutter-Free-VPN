

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn_basic_project/controller/location_controller.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/widgets/vpn_card.dart';

import '../main.dart';

class LocationScreen extends StatelessWidget {
  LocationScreen({super.key});

  final _controller = LocationController();

  @override
  Widget build(BuildContext context) {
    if(_controller.vpnList.isEmpty) _controller.getVpnData();
    return Obx(
    () => Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Free VPNs (${_controller.vpnList.length})', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),), actions: []
        ),

        floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20, right:20),
         child: FloatingActionButton(onPressed: () {
           _controller.getVpnData();
         }, child: Icon(CupertinoIcons.refresh),),

        ),
        
        body:  _controller.isLoading.value ?
         _loadingWidget() : _controller.vpnList.isEmpty ?
         -_noVpnFound() :  _vpnData()));
  }

_vpnData() => ListView.builder(
  itemCount: _controller.vpnList.length, 
  physics: BouncingScrollPhysics(),
padding: EdgeInsets.only(top: mq.width* .014, bottom: mq.width* .02, right: mq.width* .03, left: mq.width* .03),
itemBuilder: (ctx, i) => VpnCard(vpn: _controller.vpnList[i]));

_loadingWidget() => SizedBox(
  height: double.infinity,
  width: double.infinity,
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      LottieBuilder.asset('assets/lottie/loading.json', width: mq.width* .3),
      Text('Loading Servers... :)', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),)
    ],
  ),
);

_noVpnFound() => Center(
  child: Text('VPN not found... :(', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),),
);
}

