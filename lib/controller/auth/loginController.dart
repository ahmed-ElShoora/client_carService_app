import 'dart:convert';

import 'package:client_carservice/view/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:client_carservice/view/screens/auth/login_screen.dart';

import '../../const.dart';
import '../../view/screens/auth/signUp_screen.dart';
import '../../view/screens/intro/intro_screen.dart';

class LoginController extends GetxController{
  @override
  void onInit(){
    super.onInit();
  }
  RxBool obscureText = true.obs;

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController phone = new TextEditingController();
  TextEditingController password = new TextEditingController();

  var token;

  loginForm(context) async{
    if (formKey.currentState!.validate()) {
      final url=Uri.parse('https://cars-ksa.tech/api/login-client');
      http.Response response = await http.post(url,headers: {
        'api_password': api_password
      },body: {
        'phone':phone.text.toString(),
        'password':password.text.toString(),
      });
      if(response.statusCode==200)
      {
        if(jsonDecode(response.body)['status'] == true){
          token = jsonDecode(response.body)['data'].toString();
          // Future<SharedPreferences> prefs = SharedPreferences.getInstance();
          // prefs.then(
          //         (pref)
          //     {
          //       pref.setString('token',token);
          //     }
          // );
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token',token);
          Get.offAll(HomeScreen());
        }else{
          if(jsonDecode(response.body)['error-code'] == 6007){
            return Alert(
              context: context,
              type: AlertType.error,
              title: "خطأ",
              desc: "رقم الهاتف غير موجود او لم يتم تأكيده بعد",
              buttons: [
                DialogButton(
                  child: Text(
                    "الانتقال لصفحة التسجيل",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => Get.to(SignUpScreen()),
                  width: 120,
                )
              ],
            ).show();
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