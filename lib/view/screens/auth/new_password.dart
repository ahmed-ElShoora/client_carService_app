import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth/newPasswordController.dart';
import '../../wedgits/custom_button.dart';
import '../../wedgits/custome_text.dart';

class NewPasswordScreen extends StatelessWidget {
  NewPasswordController controller = Get.put(NewPasswordController());
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
                    text: 'برجاء ادخال كلمة سر قوية',
                    alignment: Alignment.topRight,
                    color: Color(0xff1C74BC),
                    fontSize: 35,
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
                                color: Color(0xff676464FF),
                                fontSize: 14
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
                      text: 'تأكيد',
                      onPress: ()async{
                        controller.updatePassword(context);
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
