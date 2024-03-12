import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:vpn_basic_project/models/vpn.dart';

class Pref{

  static late Box _box;

  static Future<void> initializeHive() async{
    await Hive.initFlutter();
    _box = await Hive.openBox('data');
  }

//for storing single vpn details
  static VPN get vpn => VPN.fromJson(jsonDecode(_box.get('vpn') ?? '{}'));
  static set vpn(VPN v) => _box.put('vpn', jsonEncode(v)); 


  //for storing vpn server details
  static List<VPN> get vpnList {
    List<VPN> temp = [];

    final data = jsonDecode(_box.get('vpnList' ) ?? '[]');
    for (var i in data){
      temp.add(VPN.fromJson(i));
    }
 
  return temp;
  }
  static set vpnList(List<VPN> v) => _box.put('vpnList', jsonEncode(v));
}