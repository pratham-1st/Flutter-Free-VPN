import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/helper/my_details.dart';
import 'package:vpn_basic_project/helper/pref.dart';
import 'package:vpn_basic_project/models/vpn.dart';
import 'package:vpn_basic_project/models/vpn_config.dart';
import 'package:vpn_basic_project/services/vpn_engine.dart';


class HomeController extends GetxController{

  final Rx<VPN> vpn = Pref.vpn.obs;

  final vpnState = VpnEngine.vpnDisconnected.obs;

    void connectToVpn() {
    ///Stop right here if user not select a vpn
    if (vpn.value.openvpnconfigdatabase64.isEmpty){
      MyDialogs.info(msg: 'Select a location by choosing \'Change Location\'');
    };

    if (vpnState.value == VpnEngine.vpnDisconnected) {
      
      final data = Base64Decoder().convert(vpn.value.openvpnconfigdatabase64);
      final config = Utf8Decoder().convert(data);
      final vpnConfig = VpnConfig(country: vpn.value.countrylong, username: 'vpn', password: 'vpn', config: config);

      ///Start if stage is disconnected

      VpnEngine.startVpn(vpnConfig);
    } else {
      ///Stop if stage is "not" disconnected
      
      VpnEngine.stopVpn();
    }
  }
  
  Color get getButtonColor{

        switch(vpnState.value){
          case VpnEngine.vpnDisconnected:
          return Colors.blue;

          case VpnEngine.vpnConnected:
          return Colors.green;

          default:
          return Colors.orangeAccent;
        }
  }

  String get getText{

        switch(vpnState.value){
          case VpnEngine.vpnDisconnected:
          return 'Tap to connect';

          case VpnEngine.vpnConnected:
          return 'Disconnect';

          default:
          return 'Connecting...';
        }
  }
}

