
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../const.dart';


class OperationController extends GetxController{
  @override

  var token = ''.obs;
  void onInit() async{
    super.onInit();
  }

  moveToPay(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('token')!;
    final url=Uri.parse('https://cars-ksa.tech/api/accept-pay-client');
    http.Response response = await http.post(url,headers: {
      'api_password': api_password,
      'auth_token': token.value.toString(),
    },body: {
      'id': id.toString()
    });
  }
  reStateBarText(addtion,pay){
    if(pay==0 && addtion==0) {
      return 'لم يتم انشاء الفاتورة بعد';
    }
    if(pay==0 && addtion==1){
      return 'تم انشاء الفاتورة ولم يتم الدفع';
    }
    if(pay==1 && addtion==1){
      return 'جاري العمل علي الطلب';
    }
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

  getDataPage(int num) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('token')!;
    final url = Uri.parse('https://cars-ksa.tech/api/data-home-client');
    http.Response response_data = await http.get(url,headers: {
      'api_password': api_password,
      'auth_token': token.value.toString()
    });
    switch(num){
      case 1:
        return jsonDecode(response_data.body)['data']['waiting'];
      case 2:
        return jsonDecode(response_data.body)['data']['containe'];
      case 3:
        return jsonDecode(response_data.body)['data']['complete'];
    }
  }

}