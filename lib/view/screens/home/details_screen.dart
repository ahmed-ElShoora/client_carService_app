import 'package:carousel_slider/carousel_slider.dart';
import 'package:client_carservice/controller/home/detailsController.dart';
import 'package:client_carservice/view/screens/home/choose_tecnical_screen.dart';
import 'package:client_carservice/view/screens/home/home_screen.dart';
import 'package:client_carservice/view/screens/home/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:readmore/readmore.dart';
import '../../../controller/home/homeController.dart';
import '../../../model/Ad.dart';
import '../../wedgits/bottom_nav.dart';
import '../../wedgits/custom_button.dart';
import '../../wedgits/custome_text.dart';

class DetailsScreen extends StatelessWidget {
  final data;

  DetailsScreen({super.key, required this.data});
  DetailsController controller = Get.put(DetailsController());

  @override

  Widget build(BuildContext context) {
    controller.note = '';
    controller.image = null;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff1C74BC),
        title: CustomText(
          text: 'تفاصيل الخدمه',
          color: Colors.white,
          fontSize: 20,
          fontweight: FontWeight.bold,
          alignment: Alignment.topRight,
          alignmentText: TextAlign.center,
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/pattern-background.jpg'),
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                //height: 270,
                width: double.infinity,
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey.shade100,
                        ),
                        height: 100,
                        width: 100,
                        child: ClipOval(
                          child: Image.network(
                            'https://cars-ksa.tech/' + data['image'],
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
                      height: 15,
                    ),
                    CustomText(
                      text: data['name'].toString(),
                      color: Color(0xff1C74BC),
                      alignment: Alignment.topRight,
                      fontSize: 22,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ReadMoreText(
                      data['desc'].toString(),
                      trimLines: 2,
                      colorClickableText: Colors.pink,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'عرض المزيد',
                      trimExpandedText: 'عرض اقل',
                      moreStyle: TextStyle(
                          fontSize: 20,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomText(
                      text: '${data['price'].toString() + ' ' + ' SAR'}',
                      alignment: Alignment.bottomLeft,
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: TextField(
                  onChanged: (value){

                    controller.note = value;
                  },
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'الرجاء إدخال ملاحظاتك',
                    contentPadding: EdgeInsets.all(0),
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    color: Colors.grey.shade50,
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                      backgroundColor: MaterialStateProperty.all(Color(0xff1C74BC)),
                      padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                    ),
                    onPressed: ()async{

                      controller.image = await controller.picker.pickImage(source: ImageSource.gallery);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.image),
                        SizedBox(
                          width: 100,
                        ),
                        CustomText(
                          text: 'ارفاق صور',
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                child: CustomButton(
                    text: 'التالي',
                    onPress: (){
                      Get.to(ChooseTecScreen(data: data, image: controller.image, note: controller.note,));
                    }
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
