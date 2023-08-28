import 'package:carousel_slider/carousel_slider.dart';
import 'package:client_carservice/controller/home/chooseTecController.dart';
import 'package:client_carservice/view/screens/home/home_screen.dart';
import 'package:client_carservice/view/screens/home/profile_screen.dart';
import 'package:cross_file/src/types/interface.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/home/homeController.dart';
import '../../../model/Ad.dart';
import '../../wedgits/bottom_nav.dart';
import '../../wedgits/custom_button.dart';
import '../../wedgits/custome_text.dart';
import 'choose_location_screen.dart';
import 'details_screen.dart';

class ChooseTecScreen extends StatelessWidget {
  final data;
  final image;
  final note;
  ChooseTecScreen({super.key, required this.data, required this.image, required this.note});
  ChooseTecController controller = Get.put(ChooseTecController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1C74BC),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/pattern-background.jpg'),
              fit: BoxFit.cover),
        ),
        child: FutureBuilder(
          future: controller.getTecs(data['id']),
          builder: (context, AsyncSnapshot<dynamic> snapshot){
            if(snapshot.hasData){
              var datas = snapshot.data;
              return ListView.builder(
                itemCount: datas['data'].length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Get.to(ChooseLocatonScreen(data: data, image: image, note: note, tec_id: datas['data'][index]['id'],));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(0xffFFFFFF),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              child: ClipOval(
                                child: Image.network(
                                  'https://cars-ksa.tech/' + datas['data'][index]['photo'],
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
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CustomText(
                                    text: 'الاسم : ${controller.getName(datas['data'][index]['name'])}',
                                    fontSize: 20,
                                    fontweight: FontWeight.w500,
                                    alignment: Alignment.topRight,
                                    alignmentText: TextAlign.right,
                                  ),
                                  CustomText(
                                    text: 'النوع : ${datas['data'][index]['gender']=='ذكر'?'ذكر':'انثي'}',
                                    fontSize: 20,
                                    fontweight: FontWeight.w500,
                                    alignment: Alignment.topRight,
                                    alignmentText: TextAlign.right,
                                  ),
                                  CustomText(
                                    text: 'الخبرة : ${datas['data'][index]['exeperince']}',
                                    fontSize: 20,
                                    fontweight: FontWeight.w500,
                                    alignment: Alignment.topRight,
                                    alignmentText: TextAlign.right,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
