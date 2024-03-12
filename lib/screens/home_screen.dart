import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


import 'package:get/get.dart';
import 'package:vpn_basic_project/controller/home_controller.dart';
import 'package:vpn_basic_project/screens/location_screen.dart';
import 'package:vpn_basic_project/screens/network_test_screen.dart';
import 'package:vpn_basic_project/widgets/count_down_timer.dart';
import 'package:vpn_basic_project/widgets/home_card.dart';

import '../main.dart';

import '../models/vpn_status.dart';
import '../services/vpn_engine.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});
  
  final _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    ///Add listener to update vpn state
    VpnEngine.vpnStageSnapshot().listen((event) {
       _controller.vpnState.value = event;
    });
    return Scaffold(
    
      appBar: AppBar(
        leading: Icon(CupertinoIcons.home), title: Text('Free VPN'), actions: [
        
          IconButton(
            padding: EdgeInsets.only(left: 8),
            onPressed: (){
              Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
            }, 
            icon: Icon(
              Icons.brightness_medium,
              size: 26,
            ),
            ),

          IconButton(
            padding: EdgeInsets.only(right: 8),
            onPressed: () => Get.to(() => NetworkTestScreen()), 
            icon: Icon(
              CupertinoIcons.info,
              size: 27,
            ),
            ),
        ],),


          body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                SizedBox(height: mq.height* .02, width: double.maxFinite,),
                Obx(() => _vpnButton()),

               SizedBox(height: mq.height* .05,),

                Obx(
                  () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HomeCard(title: _controller.vpn.value.countrylong.isEmpty ? 'COUNTRY' : _controller.vpn.value.countrylong,
                     subtitle: 'FREE',
                      icon: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.purple,
                        child:_controller.vpn.value.countrylong.isEmpty ?  Icon(Icons.vpn_key_rounded,
                          size: 30,
                          color: Colors.white
                          ) : null,
                           backgroundImage: _controller.vpn.value.countrylong.isEmpty ? null : AssetImage('assets/flags/${_controller.vpn.value.countryshort.toLowerCase()}.png')),
                  ),
                  

                  HomeCard(title: _controller.vpn.value.countrylong.isEmpty ? '0 ms' : '${_controller.vpn.value.ping} ms',
                     subtitle: 'PING',
                      icon: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.equalizer,
                          size: 30,
                          color: Colors.white,
                          ),
                    ),
                  )
                ],
                )),

                SizedBox(height: mq.height* .03,),

                StreamBuilder<VpnStatus?>(
                  initialData: VpnStatus(),
                  stream: VpnEngine.vpnStatusSnapshot(),
                  builder: (context, snapshot) => 
                  
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HomeCard(
                      title: '${snapshot.data?.byteIn ?? '0 kbps'}',
                     subtitle: 'DOWNLOAD',
                      icon: CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 30,
                        child: Icon(
                          Icons.arrow_downward,
                          size: 30,
                          color: Colors.white,
                          ),
                    ),
                  ),

                  HomeCard(
                    title: '${snapshot.data?.byteOut ?? '0 kbps'}',
                     subtitle: 'UPLOAD',
                      icon: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.pink,
                        child: Icon(
                          Icons.arrow_upward,
                          size: 30,
                          color: Colors.white,
                          ),
                    ),
                  )
                ],
                )
                
                ),
                
              ]),
              bottomNavigationBar: _changeLocation(),
    );
  }




Widget _vpnButton() => Column(children: [
SizedBox(
  height: mq.height* .03,
),
InkWell(
onTap: () {
   _controller.connectToVpn();
} ,
borderRadius: BorderRadius.circular(100),
child: Container(
 padding: EdgeInsets.all(16),
 decoration: BoxDecoration(shape: BoxShape.circle, color: _controller.getButtonColor.withOpacity(.1)),
child: Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(shape: BoxShape.circle, color:_controller.getButtonColor.withOpacity(.3)),
 child: Container(
  width: mq.height* .14,
  height: mq.height* .14,
  decoration: BoxDecoration(shape: BoxShape.circle, color:_controller.getButtonColor),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,

    children: [
    Icon(
      Icons.power_settings_new,
      size: 30,
      color: Colors.white,
    ),

    SizedBox(height: 4,),

    Text(
      _controller.getText.toString(),
      style: TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.bold),
    )
  ]),
)
)
)
),

Container(
  margin: EdgeInsets.only(top: mq.height* .015, bottom: mq.height* .015),
  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
  decoration: BoxDecoration(
    color: Colors.blue, borderRadius: BorderRadius.circular(15)
  ),
  child: Text(

    _controller.vpnState.value == VpnEngine.vpnDisconnected
    ?  'Not Connected' : _controller.vpnState.replaceAll('_', '').toUpperCase(),
      style: TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.bold),
    ),
),

Obx(() => CountDownTimer(startTimer: _controller.vpnState.value == VpnEngine.vpnConnected))

]);

Widget _changeLocation() => SafeArea(
  child: Semantics(
    button: true,
  child: InkWell(
    onTap: () => Get.to( () => LocationScreen()),
  child:  Container(
  color: Colors.blue,
  height: 80,
  margin: EdgeInsets.only(bottom: 25),
  padding: EdgeInsets.symmetric(horizontal: 15),
  child: Row(
    children: [
      Icon(CupertinoIcons.globe, color: Colors.white,size: 38),
      SizedBox(width: 10,),
      Text('Change Location', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),),
      Spacer(),
      CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(Icons.keyboard_arrow_right_rounded, color: Colors.blue, size: 35, ))
    ],
  ),
),
)
)
);

}
    