


import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../const.dart';

class NotifyController extends GetxController{
  @override

  var token = ''.obs;

  getData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('token')!;
    final url = Uri.parse('https://cars-ksa.tech/api/get-notify-client');
    http.Response response_data = await http.get(url,headers: {
      'api_password': api_password,
      'auth_token': token.value.toString()
    });
    //print(jsonDecode(response_data.body));
    // print(token.value.toString());
    return jsonDecode(response_data.body);
  }
}