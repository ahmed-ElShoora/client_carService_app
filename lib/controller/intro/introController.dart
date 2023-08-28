
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:client_carservice/const.dart';
import 'package:client_carservice/model/Intro.dart';

class IntroController extends GetxController{
  getData()async{
    final url=Uri.parse('https://cars-ksa.tech/api/images-start');
    http.Response response = await http.get(url,headers: {
      'api_password': api_password
    });

    if(response.statusCode==200)
    {
      try{
        return Intro.fromJson(jsonDecode(response.body));
      }catch(e)
      {
        Get.snackbar("error", e.toString());
      }
    }
  }
}