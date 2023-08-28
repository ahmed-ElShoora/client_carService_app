import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:client_carservice/view/screens/auth/login_screen.dart';

import '../../const.dart';

class NewPasswordController extends GetxController{
  @override
  var email;
  void onInit(){
    // Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    // prefs.then(
    //         (pref)
    //     {
    //       email = pref.getString('email');
    //     }
    // );

    super.onInit();
  }
  RxBool obscureText = true.obs;

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController password = new TextEditingController();


  updatePassword(context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
    if (formKey.currentState!.validate()) {
      final url=Uri.parse('https://cars-ksa.tech/api/update-password-tec');
      http.Response response = await http.post(url,headers: {
        'api_password': api_password
      },body: {
        'email':email,
        'password':password.text.toString(),
      });
      if(response.statusCode==200)
      {
        if(jsonDecode(response.body)['status'] == true){
          Get.to(LoginScreen());
        }else{
          return Alert(
            context: context,
            type: AlertType.error,
            title: "برجاء المحاولة في وقت اخر",
            desc: "حدث خطأ اثناء عملية تعديل كلمة المرور برجاء المحاولة مره اخري",
            buttons: [
              DialogButton(
                child: Text(
                  "الانتقال لصفحة التسجيل",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Get.to(LoginScreen()),
                width: 120,
              )
            ],
          ).show();
        }
      }else{
        return Alert(
          context: context,
          type: AlertType.error,
          title: "برجاء المحاولة في وقت اخر",
          desc: "حدث خطأ اثناء عملية تعديل كلمة المرور برجاء المحاولة مره اخري",
          buttons: [
            DialogButton(
              child: Text(
                "الانتقال لصفحة التسجيل",
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