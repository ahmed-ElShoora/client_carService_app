
import 'package:carousel_slider/carousel_slider.dart';
import 'package:client_carservice/controller/home/chooseTecController.dart';
import 'package:client_carservice/view/screens/home/home_screen.dart';
import 'package:client_carservice/view/screens/home/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/home/homeController.dart';
import '../../../model/Ad.dart';
import '../../wedgits/bottom_nav.dart';
import '../../wedgits/custom_button.dart';
import '../../wedgits/custome_text.dart';
import 'details_screen.dart';

class WalletScreen extends StatelessWidget {

  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff1C74BC),
          actions: [
            FutureBuilder(
                future: controller.getDataUser(),
                builder: (context,AsyncSnapshot snapshot) {
                  if(snapshot.hasData)
                  {
                    var data = snapshot.data;
                    return Row(
                      children: [
                        CustomText(
                          text: 'مرحبا '+data['data']['name'].toString(),
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xff4EA8F1),
                            shape: BoxShape.circle,
                          ),
                          height: 30,
                          width: 30,
                          child: ClipOval(
                            child: Image.network(
                              'https://cars-ksa.tech/' + data['data']['photo'],
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
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    );
                  }else{
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
            )
          ]
      ),
      body: Container(
        width: double.infinity,
        //height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/pattern-background.jpg'),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: FutureBuilder(
              future: controller.getDataUser(),
              builder: (context,AsyncSnapshot snapshot) {
                if(snapshot.hasData)
                {
                  var data = snapshot.data;
                  return Container(
                    width: double.infinity,
                    height: 130,
                    decoration: BoxDecoration(
                      color: Color(0xff1C74BC),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CustomText(
                            text: data['data']['name'],
                            fontSize: 17,
                            color: Colors.white,
                            alignment: Alignment.topRight,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: data['data']['earn'] == null ? '0'+' SAR': data['data']['earn'] +' SAR',
                                fontSize: 20,
                                color: Colors.white,
                              ),
                              CustomText(
                                text: ' : الرصيد',
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        )
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
      bottomNavigationBar: BottomNav(),
    );
  }
}
