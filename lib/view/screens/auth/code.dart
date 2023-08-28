import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth/loginController.dart';
import '../../../controller/auth/verifyCodeController.dart';
import '../../wedgits/custom_button.dart';
import '../../wedgits/custome_text.dart';
import '../../wedgits/custome_text_form_faild.dart';

class VerifyCodeAuth extends StatelessWidget {
  VerifyCodeController controller = Get.put(VerifyCodeController());
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
                    text: 'أدخل رمز مكون من 4 أرقام تم إرساله تم ارساله الي بريدك الالكتروني',
                    alignment: Alignment.topRight,
                    color: Color(0xff1C74BC),
                    fontSize: 35,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CustomTextFormField(
                    text: 'الكود',
                    hint: 'XXX XXX',
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'هذا الحقل اجباري';
                      }
                      if (value.length < 6) {
                        return 'اقل عدد احرف او علامات 6';
                      }
                      return null;
                    },
                    controller: controller.code,
                    textDire: TextDirection.ltr,
                    textAlign: TextAlign.right,
                    sufficIcon: Icon(Icons.code),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CustomButton(
                      text: 'تأكيد',
                      onPress: ()async{
                        controller.verify(context);
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}