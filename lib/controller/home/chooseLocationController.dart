
import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../const.dart';
import '../../view/screens/home/home_screen.dart';



class ChooseLocationController extends GetxController{
  @override

  var token = ''.obs;

  Future getPostion() async{
    bool services;
    LocationPermission permission;
    services = await Geolocator.isLocationServiceEnabled();
    if(services == false){
      Get.defaultDialog(title: 'خدمة تحديدالمواقع غير مفعله',middleText: '');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.defaultDialog(title: 'الصلاحيات اجبارية',middleText: '');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      Get.defaultDialog(title:'Location permissions are permanently denied, we cannot request permissions.',middleText: '');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition().then((value) => value);
  }
  createOrder(tec_id,note,image,data,Position snapdata) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('token')!;
    var headers = {
      'api_password': api_password,
      'auth_token': token.value.toString(),
    };
    var body = {
      'tec_id': tec_id.toString(),
      'desc': note.toString(),
      'lat': snapdata.latitude.toString(),
      'lng': snapdata.latitude.toString(),
      'category_id': data['id'].toString(),
      'category_price': data['price'].toString(),
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://cars-ksa.tech/api/add-order'));
    if(image != null){
      request.files.add(await http.MultipartFile.fromPath('image',image.path));
    }
    request.headers.addAll(headers);
    request.fields.addAll(body);
    http.StreamedResponse response = await request.send();
    return true;
  }
}