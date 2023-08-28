import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client_carservice/controller/auth/forgetPassowrdController.dart';

import '../../wedgits/custom_button.dart';
import '../../wedgits/custome_text.dart';
import '../../wedgits/custome_text_form_faild.dart';


class ForgetPassword extends StatelessWidget {
  ForgetPasswordController controller = Get.put(ForgetPasswordController());
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
                   text: 'تعديل كلمة المرور',
                   alignment: Alignment.topRight,
                   color: Color(0xff1C74BC),
                   fontSize: 35,
                  ),
                  SizedBox(
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
                  SizedBox(
                    height: 25.0,
                  ),
                  CustomButton(
                      text: 'ارسال الرمز',
                      onPress: ()async{
                        controller.sendEmail(context);
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
