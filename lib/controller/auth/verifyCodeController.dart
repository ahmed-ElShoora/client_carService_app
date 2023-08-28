
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../view/screens/auth/login_screen.dart';
import '../../view/screens/auth/new_password.dart';

class VerifyCodeController extends GetxController{
  @override

  var intigarNum;
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController code = new TextEditingController();

  void onInit(){
    // Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    // prefs.then(
    //         (pref)
    //     {
    //       intigarNum = pref.getInt('code');
    //     }
    // );

    super.onInit();
  }

  verify(context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    intigarNum = prefs.getInt('code');
    if (formKey.currentState!.validate()) {

      if(code.text.toString() == intigarNum.toString()){
        Get.to(NewPasswordScreen());
      }else{
        return Alert(
          context: context,
          type: AlertType.error,
          title: "الكود خطأ",
          desc: "حدث خطأ اثناء عملية الاستعاده برجاء المحاولة مره اخري",
          buttons: [
            DialogButton(
              child: Text(
                "الانتقال لصفحة تسجيل الدخول",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Get.to(LoginScreen()),
              width: 120,
            )
          ],
        ).show();
      }
    }
  }
}