
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../const.dart';
import '../../model/Ad.dart';


class HomeController extends GetxController{
  @override

  var token = ''.obs;
  void onInit() async{
    // Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    // await prefs.then(
    //         (pref)
    //     {
    //       token.value = pref.getString('token')!;
    //     }
    // );

    super.onInit();
  }

  Future<void> funLaunchUrl(url) async {
    if (!await launchUrl(Uri.parse(url))) {
      Get.snackbar(
          'لم يتم التحويل',
          'برجاء المحاولة مجددا',
          duration: Duration(seconds: 7),
      );
    }
  }

  getProducts() async {
    final url = Uri.parse('https://cars-ksa.tech/api/get-category');
    http.Response response_data = await http.get(url,headers: {
      'api_password': api_password,
    });
    return jsonDecode(response_data.body);
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

  getDataAds() async{
    final url=Uri.parse('https://cars-ksa.tech/api/re-adds-client');
    http.Response response = await http.get(url,headers: {
      'api_password': api_password
    });

    if(response.statusCode==200)
    {
      try{
        return Ad.fromJson(jsonDecode(response.body));
      }catch(e)
      {
        Get.snackbar("error", e.toString());
      }
    }
  }
}