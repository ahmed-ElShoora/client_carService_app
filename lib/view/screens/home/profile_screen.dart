
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/home/profileController.dart';
import '../../wedgits/bottom_nav.dart';
import '../../wedgits/custom_button.dart';
import '../../wedgits/custome_text.dart';
import '../../wedgits/custome_text_form_faild.dart';
import 'home_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileController controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1C74BC),
        title: Center(
          child: CustomText(text: 'تعديل الملف الشخصي',color: Colors.white,),
        ),
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
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: FutureBuilder(
                    future: controller.getDataUser(),
                    builder: (context,AsyncSnapshot snapshot) {
                      if(snapshot.hasData){
                        var data = snapshot.data;
                        controller.name.text = data['data']['name'];
                        controller.phone.text = data['data']['phone'];
                        controller.email.text = data['data']['email'];
                        controller.town.text = data['data']['town'];
                        controller.password.text = data['data']['password_hash'];
                        return Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: ()=>controller.uploudImage(),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xff4EA8F1),
                                    shape: BoxShape.circle,
                                  ),
                                  height: 150,
                                  width: 150,
                                  child: ClipOval(
                                    child: Image.network(
                                      'https://cars-ksa.tech/'+data['data']['photo'],
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context, Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress.expectedTotalBytes != null
                                                ? loadingProgress.cumulativeBytesLoaded /
                                                loadingProgress.expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
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
                                  text: 'حفظ التعديلات',
                                  onPress: (){
                                    controller.saveChange(context);
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }),
                              SizedBox(
                                height: 25.0,
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  )),
                                  backgroundColor: MaterialStateProperty.all(Color(0xffFC1A16)),
                                  padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                                ),
                                onPressed: (){
                                  controller.logOut();
                                },
                                child: CustomText(
                                  alignment: Alignment.center,
                                  text: 'تسجيل الخروج',
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                              ),
                              // SizedBox(
                              //   height: 25,
                              // ),
                              // ElevatedButton(
                              //   style: ButtonStyle(
                              //     shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(10.0),
                              //     )),
                              //     backgroundColor: MaterialStateProperty.all(Color(0xffFC1A16)),
                              //     padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                              //   ),
                              //   onPressed: (){
                              //     controller.deleteAcount();
                              //   },
                              //   child: CustomText(
                              //     alignment: Alignment.center,
                              //     text: 'حذف الحساب',
                              //     color: Colors.white,
                              //     fontSize: 22,
                              //   ),
                              // )
                            ],
                          ),
                        );
                      }else{
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

  }
                  ),
                ),
              ),
            ),
            ),
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
