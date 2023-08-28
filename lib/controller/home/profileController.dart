
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const.dart';
import '../../view/screens/home/home_screen.dart';
import '../../view/screens/intro/intro_screen.dart';

class ProfileController extends GetxController{
  @override

  var token = ''.obs;
  final ImagePicker _picker = ImagePicker();
  uploudImage() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('token')!;
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      var headers = {
        'api_password': api_password,
        'auth_token': token.value.toString(),
      };
      var request = http.MultipartRequest('POST', Uri.parse('https://cars-ksa.tech/api/update-profile-client-photo'));
      request.files.add(await http.MultipartFile.fromPath('photo',image.path));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      //print(response.statusCode);
      if (response.statusCode == 200) {
        Get.offAll(HomeScreen());
      }
    }
  }
  void onInit() async{
    // Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    // await prefs.then(
    //         (pref)
    //      {
    //       token.value = pref.getString('token')!;
    //     }
    // );

    super.onInit();
  }

  getDataUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('token')!;
    final url = Uri.parse('https://cars-ksa.tech/api/get-data-client');
    http.Response response_data = await http.get(url,headers: {
      'api_password': api_password,
      'auth_token': token.value.toString()
    });
    return jsonDecode(response_data.body);
  }

  RxBool obscureText = true.obs;

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController phone = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController town = new TextEditingController();
  TextEditingController password = new TextEditingController();

  saveChange(context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('token')!;
    if (formKey.currentState!.validate()) {
      final url=Uri.parse('https://cars-ksa.tech/api/update-profile-client');
      http.Response response = await http.post(url,headers: {
        'api_password': api_password,
        'auth_token': token.value.toString()
      },body: {
        'name':name.text.toString(),
        'email':email.text.toString(),
        'password':password.text.toString(),
        'phone':phone.text.toString(),
        'town':town.text.toString(),
      });
      if(response.statusCode==200)
      {
        if(jsonDecode(response.body)['status'] == true){
          final url=Uri.parse('https://cars-ksa.tech/api/login-client');
          http.Response response = await http.post(url,headers: {
            'api_password': api_password
          },body: {
            'phone':phone.text.toString(),
            'password':password.text.toString(),
          });
          token.value = jsonDecode(response.body)['data'].toString();
          Future<SharedPreferences> prefs = SharedPreferences.getInstance();
          prefs.then(
                  (pref)
              {
                pref.setString('token',token.value);
              }
          );
          Get.offAll(HomeScreen());
        }else{
          return Alert(
              context: context,
              type: AlertType.error,
              title: "برجاء المحاولة في وقت اخر",
              desc: "حدث خطأ اثناء عملية التحديث برجاء المحاولة مره اخري",
              buttons: [
                DialogButton(
                  child: Text(
                    "الانتقال لصفحة الرئيسية",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => Get.offAll(HomeScreen()),
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
          desc: "حدث خطأ اثناء عملية التحديث برجاء المحاولة مره اخري",
          buttons: [
            DialogButton(
              child: Text(
                "الانتقال لصفحة الرئيسية",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Get.offAll(HomeScreen()),
              width: 120,
            )
          ],
        ).show();
      }
    }
  }

  logOut() async{
    // Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    // prefs.then(
    //         (pref)
    //     {
    //       pref.remove('token');
    //     }
    // );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    Get.offAll(IntroScreen());
  }

  deleteAcount() async{
    // Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    // prefs.then(
    //         (pref)
    //     {
    //       pref.remove('token');
    //     }
    // );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    final url = Uri.parse('https://cars-ksa.tech/api/delete-client');
    http.Response response = await http.get(url,headers: {
      'api_password': api_password,
      'auth_token': token.toString()
    });
    if(response.statusCode==200)
    {
      try{
        Get.offAll(IntroScreen());
      }catch(e)
      {
        //Get.snackbar("error", e.toString());
      }
    }

  }
}