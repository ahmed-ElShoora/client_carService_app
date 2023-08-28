
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../const.dart';
import '../../model/Ad.dart';


class ChooseTecController extends GetxController{
  @override

  var token = ''.obs;

  Future getTecs(id) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('token')!;
    final url = Uri.parse('https://cars-ksa.tech/api/get-tecnical-$id');
    http.Response response_data = await http.get(url,headers: {
      'api_password': api_password,
      'auth_token': token.value.toString()
    });
    return jsonDecode(response_data.body);
  }
  List<String> splitStringByLength( String str, int length)
  {
    List<String> data = [];

    data.add( str.substring(0, length) );
    data.add( str.substring( length) );
    return data;
  }
  getName(name){
    if(name.toString().length <= 10){
      return name;
    }else{
      return splitStringByLength(name,10)[0];
    }
  }

}