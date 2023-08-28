import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:client_carservice/const.dart';
import 'package:client_carservice/model/Category.dart';
import 'package:client_carservice/view/screens/auth/login_screen.dart';
import 'package:client_carservice/view/screens/auth/signUp_screen.dart';

class SignUpController extends GetxController{
  @override

  RxBool obscureText = true.obs;

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController phone = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController town = new TextEditingController();
  TextEditingController password = new TextEditingController();

  late String gender;

  signUpForm(context) async{
    if (formKey.currentState!.validate()) {
      final url=Uri.parse('https://cars-ksa.tech/api/signup-client');
      http.Response response = await http.post(url,headers: {
        'api_password': api_password
      },body: {
        'gender':gender.toString(),
        'name':name.text.toString(),
        'email':email.text.toString(),
        'phone':phone.text.toString(),
        'password':password.text.toString(),
        'town':town.text.toString(),
      });
      //print('ok');
      //print(jsonDecode(response.body));
      if(response.statusCode==200)
      {
        if(jsonDecode(response.body)['status'] == true){
          return Alert(
            context: context,
            type: AlertType.success,
            title: "تم التسجيل بنجاح",
            desc: "سيتم مراجعة البيانات ثم السماح لك بتسجيل الدخول",
            buttons: [
              DialogButton(
                child: Text(
                  "حسنا",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Get.to(LoginScreen()),
                width: 120,
              )
            ],
          ).show();
        }else{
          if(jsonDecode(response.body)['error-code'] == 6006){
            return Alert(
              context: context,
              type: AlertType.error,
              title: "خطأ بالبيانات",
              desc: "رقم الهاتف او الاميل مستخدم من قبل برحاء تعديل البيانات ثم المحاولة مجددا",
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
                  onPressed: () => Get.to(SignUpScreen()),
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
              onPressed: () => Get.to(SignUpScreen()),
              width: 120,
            )
          ],
        ).show();
      }
    }
  }
}