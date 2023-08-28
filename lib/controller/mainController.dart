import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController extends GetxController{
  @override
  void onInit(){
    getData();
    initConnection();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.onInit();
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }

  var connectivityStatus = 0.obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  late RxBool login_status = false.obs;
  void getData() async{
    // Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    // prefs.then(
    //         (pref)
    //     {
    //       if(pref.getString('token') == null || pref.getString('token') == 'null'){
    //         login_status = false.obs;
    //       }else{
    //         login_status = true.obs;
    //       }
    //     }
    // );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('token') == null || prefs.getString('token') == 'null'){
      login_status = false.obs;
    }else{
      login_status = true.obs;
    }
  }

  Future<void> initConnection() async{
    ConnectivityResult result = ConnectivityResult.none;
    try{
      result = await _connectivity.checkConnectivity();
    }on PlatformException catch(e){
      result = ConnectivityResult.none;
    }
    return _updateConnectionStatus(result);
  }

  _updateConnectionStatus(ConnectivityResult result){
    switch(result){
      case ConnectivityResult.wifi:
        connectivityStatus.value=1;
        break;
      case ConnectivityResult.mobile:
        connectivityStatus.value=2;
        break;
      case ConnectivityResult.none:
        connectivityStatus.value=0;
        break;
      default:
        connectivityStatus.value=0;
        break;
    }
  }
}