
import 'package:client_carservice/view/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client_carservice/view/screens/errorConectionScreen.dart';
import 'package:client_carservice/view/screens/intro/intro_screen.dart';

import 'controller/mainController.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ClaintAPP());
}

class ClaintAPP extends StatelessWidget {
  MainController controller = Get.put(MainController());//0xffF7F7F7
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Client App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Obx((){
          if(controller.connectivityStatus.value != 0){
            return controller.login_status.value ? HomeScreen() : IntroScreen();
          }else{
            return ErrorConectionScreen();
          }
        })
      ),
    );
  }
}
