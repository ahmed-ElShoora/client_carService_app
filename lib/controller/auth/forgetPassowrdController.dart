
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const.dart';
import '../../view/screens/auth/code.dart';
import '../../view/screens/auth/login_screen.dart';

class ForgetPasswordController extends GetxController{
  @override

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController phone = new TextEditingController();

  var email;
  var intigarNum;
  sendEmail(context) async{
    if (formKey.currentState!.validate()) {
      final url=Uri.parse('https://cars-ksa.tech/api/re-email-client');
      http.Response response = await http.post(url,headers: {
        'api_password': api_password
      },body: {
        'phone':phone.text.toString(),
      });
      if(response.statusCode==200)
      {
        if(jsonDecode(response.body)['status'] == true){
          email = jsonDecode(response.body)['data'].toString();
          int random(int min, int max) {
            return min + Random().nextInt(max - min);
          }
          intigarNum = random(111111, 999999);
          http.Response respons = await http.post(Uri.parse('https://cars-ksa.tech/api/send-mail'),headers: {
            'api_password': api_password
          },body: {
            'email':email,
            'msg':'الكود هوه ${intigarNum}'
          });
          // Future<SharedPreferences> prefs = SharedPreferences.getInstance();
          // prefs.then(
          //         (pref)
          //     {
          //       pref.setString('email',email);
          //       pref.setInt('code',intigarNum);
          //     }
          // );
          //print(intigarNum);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('email',email);
          prefs.setInt('code',intigarNum);
          Get.to(VerifyCodeAuth());
        }else{
          return Alert(
            context: context,
            type: AlertType.error,
            title: "برجاء المحاولة في وقت اخر",
            desc: "حدث خطأ اثناء عملية التسجيل برجاء المحاولة مره اخري",
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
          desc: "حدث خطأ اثناء عملية التسجيل برجاء المحاولة مره اخري",
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