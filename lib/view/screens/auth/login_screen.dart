import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client_carservice/controller/auth/loginController.dart';
import 'package:client_carservice/view/screens/auth/forget_password.dart';
import 'package:client_carservice/view/screens/auth/signUp_screen.dart';
import 'package:client_carservice/view/wedgits/custom_button.dart';
import 'package:client_carservice/view/wedgits/custome_text.dart';
import 'package:client_carservice/view/wedgits/custome_text_form_faild.dart';

class LoginScreen extends StatelessWidget {
  LoginController controller = Get.put(LoginController());
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
                    text: 'مرحبا بعودتك',
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
                  GestureDetector(
                    onTap: (){
                      Get.to(ForgetPassword());
                    },
                    child: CustomText(
                      text: 'هل نسيت كلمة المرور',
                      alignment: Alignment.topLeft,
                      fontSize: 15,
                      fontweight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CustomButton(
                    text: 'دخول',
                    onPress: ()async{
                      controller.loginForm(context);
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
                        Get.to(SignUpScreen());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: 'حساب جديد',
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
