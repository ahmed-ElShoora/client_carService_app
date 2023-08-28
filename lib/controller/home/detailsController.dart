
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


class DetailsController extends GetxController{
  @override

  var token = ''.obs;
  final ImagePicker picker = ImagePicker();

  XFile? image;
  String note = '';

}