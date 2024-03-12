
import 'dart:convert';
import 'dart:developer';

import 'package:csv/csv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:vpn_basic_project/helper/my_details.dart';
import 'package:vpn_basic_project/helper/pref.dart';
import 'package:vpn_basic_project/models/vpn.dart';

import '../models/ip_details.dart';

class APIs{
  static Future<List<VPN>> getVpnServers() async{

    final List<VPN> vpnlist = [];

   try {
      final res = await get(Uri.parse('http://www.vpngate.net/api/iphone/'));
    final csvString = res.body.split("#")[1].replaceAll('*', '');

    List<List<dynamic>> list = const CsvToListConverter().convert(csvString);

    final header = list[0];

    for(int i=1; i<list.length -1; i++){
       Map<String, dynamic> tempJson = {};
      for(int j=0; j<header.length; j++){
        tempJson.addAll({header[j].toString():list[i][j]});
    }
    vpnlist.add(VPN.fromJson(tempJson));
    }
   } catch (e) {
      MyDialogs.error(msg: e.toString());
     log('Exeception: $e');
   }
   // log(res.body);
   vpnlist.shuffle();
   if(vpnlist.isNotEmpty) Pref.vpnList = vpnlist;
   return vpnlist;
}

  static Future<void> getIpDetails({required Rx<IPdetails> ipData}) async{
   try {
      final res = await get(Uri.parse('http://ip-api.com/json/'));
      final data = jsonDecode(res.body);
      log(data.toString());
      ipData.value = IPdetails.fromJson(data);
    }
    catch (e) {
     MyDialogs.error(msg: e.toString());
     log('/nExeception: $e');
   }
  }
}