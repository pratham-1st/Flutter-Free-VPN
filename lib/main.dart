import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:vpn_basic_project/helper/pref.dart';

import 'screens/splash_screen.dart';

late Size mq;
Future<void> main() async {
 
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  await Pref.initializeHive();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((v){
            runApp(const MyApp());
  });

 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Free VPN',
      home: SplashScreen(),

      theme: ThemeData(appBarTheme: AppBarTheme(centerTitle: true, elevation: 3)),

      themeMode: ThemeMode.light,

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(centerTitle: true, elevation: 3)),
    );
  }
}
