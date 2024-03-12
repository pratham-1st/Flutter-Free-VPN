import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/apis/apis.dart';
import 'package:vpn_basic_project/models/ip_details.dart';
import 'package:vpn_basic_project/models/network_card.dart';
import 'package:vpn_basic_project/widgets/network_card.dart';

import '../main.dart';

class NetworkTestScreen extends StatelessWidget {

  const NetworkTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final ipData = IPdetails.fromJson({}).obs;
  APIs.getIpDetails(ipData: ipData);

    return Scaffold(
      appBar: AppBar(title: Text('Network Test Screen')),

        floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20, right:20),
         child: FloatingActionButton(onPressed: () {
          ipData.value = IPdetails.fromJson({});
          APIs.getIpDetails(ipData: ipData);
         }, child: Icon(CupertinoIcons.refresh),),

        ),


      body: Obx (
        () => ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: mq.height* .01, horizontal: mq.height* .02),
        children: [

          //ip
          NetworkCard(
            data: NetworkData(
              title: 'IP address',
              subtitle: ipData.value.query, 
              icon: Icon(
                CupertinoIcons.location_solid, 
                color: Colors.blue,)
           ),
          ),     
          
          //isp
            NetworkCard(
            data: NetworkData(
              title: 'Internet Provider',
              subtitle: ipData.value.isp, 
              icon: Icon(
                Icons.business, 
                color: Colors.orange,)
           ),
          ),     

            NetworkCard(
            data: NetworkData(
              title: 'Location',
              subtitle: ipData.value.country.isEmpty ? 'Fetching..': ('${ipData.value.city}, ${ipData.value.regionName}, ${ipData.value.country}'), 
              icon: Icon(
                CupertinoIcons.location, 
                color: Colors.pink,)
           ),
          ),     

          //pincode
            NetworkCard(
            data: NetworkData(
              title: 'Pin Code',
              subtitle: ipData.value.zip, 
              icon: Icon(
                CupertinoIcons.location_solid, 
                color: Colors.cyan,)
           ),
          ),     

          //timezone
            NetworkCard(
            data: NetworkData(
              title: 'Timezone',
              subtitle: ipData.value.timezone, 
              icon: Icon(
                CupertinoIcons.time, 
                color: Colors.green,)
           ),
          )      
        ],
      ),
    ));
    
  }
}