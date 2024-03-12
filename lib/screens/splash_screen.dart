import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 1500), (){

      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      Get.off(() => HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
   mq = MediaQuery.of(context).size;
    return Scaffold(
       body: Stack(children: [
        Positioned(
        left: mq.width * .3,
        top: mq.height* .2,
        width: mq.width * .5,
        child: Image.asset('assets/images/vpn.png'),
        ),

        Positioned(
        bottom: mq.height* .15,
        width: mq.width,
        child: Text('Made in India with :)',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black87, letterSpacing: 1.25)
        ),
        ),
      ],
      ),
    );
  }
}