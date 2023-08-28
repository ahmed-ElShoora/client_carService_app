import 'dart:ffi';

import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../controller/auth/signUpController.dart';
import '../../../model/Category.dart';
import '../../wedgits/custom_button.dart';
import '../../wedgits/custome_text.dart';
import '../../wedgits/custome_text_form_faild.dart';
import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpController controller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1C74BC),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/pattern-background.jpg'),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 35.0,
                  ),
                  //Image.asset('assets/images/wifi-error.png',width: 100,height: 100,),
                  //SizedBox(
                  //  height: 20.0,
                  //),
                  CustomText(
                    text: 'انشاء حساب جديد',
                    alignment: Alignment.topRight,
                    color: Color(0xff1C74BC),
                    fontSize: 30,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CustomTextFormField(
                      text: 'الاسم الثلاثي',
                      hint: 'احمد محمد حمد',
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'هذا الحقل اجباري';
                      }
                      if (value.length < 7) {
                        return 'اقل عدد احرف او علامات 7';
                      }
                      return null;
                    },
                    controller: controller.name,
                    textDire: TextDirection.ltr,
                    textAlign: TextAlign.right,
                    sufficIcon: Icon(Icons.account_circle),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CustomTextFormField(
                      text: 'البريد الالكتروني',
                      hint: 'example@example.com',
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'هذا الحقل اجباري';
                      }
                      if (value.length < 7) {
                        return 'اقل عدد احرف او علامات 7';
                      }
                      if(!GetUtils.isEmail(value)){
                        return 'يجب ادخل ايميل صحيح';
                      }
                      return null;
                    },
                    controller: controller.email,
                    textDire: TextDirection.ltr,
                    textAlign: TextAlign.right,
                    sufficIcon: Icon(Icons.email),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CustomTextFormField(
                      text: 'رقم الهاتف',
                      hint: '05*********',
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'هذا الحقل اجباري';
                      }
                      if (value.length < 5) {
                        return 'اقل عدد احرف او علامات 5';
                      }
                      return null;
                    },
                    controller: controller.phone,
                    textDire: TextDirection.ltr,
                    textAlign: TextAlign.right,
                    sufficIcon: Icon(Icons.phone),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CustomTextFormField(
                      text: 'المدينة',
                      hint: 'اسم مدينتك',
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'هذا الحقل اجباري';
                      }
                      return null;
                    },
                    controller: controller.town,
                    textDire: TextDirection.ltr,
                    textAlign: TextAlign.right,
                    sufficIcon: Icon(Icons.location_city),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(enabledBorder: InputBorder.none),
                    items: ["ذكر", "انثي"].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(value, style: TextStyle(fontSize: 16))),
                      );
                    }).toList(),
                    isDense: true,
                    isExpanded: true,
                    hint: Align(
                        alignment: Alignment.center,
                        child: Text('النوع', style: TextStyle(fontSize: 18))),
                    onChanged: (value) {
                      controller.gender = value!;
                    },
                    validator: (value){
                      if (value == null) {
                        return 'هذا الحقل اجباري';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    child: Column(
                      children: [
                        CustomText(
                          text: 'كلمة المرور',
                          fontSize: 14,
                          color: Colors.grey.shade900,
                          alignment: Alignment.topRight,
                        ),
                        Obx(()=>TextFormField(
                              controller: controller.password,
                              validator: (value){
                                if (value == null || value.isEmpty) {
                                  return 'هذا الحقل اجباري';
                                }
                                if (value.length < 7) {
                                  return 'اقل عدد احرف او علامات 7';
                                }
                                return null;
                              },
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.right,
                              obscureText: controller.obscureText.value,
                              decoration: InputDecoration(
                                hintText: '************',
                                prefixIcon: GestureDetector(
                                  child: Icon(controller.obscureText.value?Icons.visibility:Icons.visibility_off),
                                  onTap: (){
                                    controller.obscureText.value =! controller.obscureText.value;
                                  },
                                ),
                                suffixIcon: Icon(Icons.password),
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    color: Colors.black,
                                    fontSize: 18
                                ),
                                fillColor: Colors.white,
                              ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CustomButton(
                      text: 'تسجيل',
                      onPress: (){
                        controller.signUpForm(context);
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: (){
                        Get.to(LoginScreen());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: 'تسجيل دخول',
                            color: Color(0xff1C74BC),
                            fontSize: 18,
                            fontweight: FontWeight.w300,
                          ),
                          CustomText(
                            text: 'ليس لديك حساب ؟',
                            fontSize: 18,
                            fontweight: FontWeight.w300,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
