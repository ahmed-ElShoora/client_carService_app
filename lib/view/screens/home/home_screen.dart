import 'package:carousel_slider/carousel_slider.dart';
import 'package:client_carservice/view/screens/home/details_screen.dart';
import 'package:client_carservice/view/screens/home/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/home/homeController.dart';
import '../../../model/Ad.dart';
import '../../wedgits/bottom_nav.dart';
import '../../wedgits/custom_button.dart';
import '../../wedgits/custome_text.dart';
import '../notify/notify.dart';
import 'all_category_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff1C74BC),
          leading: GestureDetector(
              onTap: (){
                //notify page
                Get.to(NotifyScreen());
              },
              child: Icon(Icons.notification_important_rounded)
          ),
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
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/pattern-background.jpg'),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(25),
                    child: FutureBuilder(
                      future: controller.getDataAds(),
                      builder: (context,AsyncSnapshot snapShot){
                        if(snapShot.hasData){
                          Ad data = snapShot.data;
                          return CarouselSlider.builder(
                            options: CarouselOptions(
                              height: 200,
                              aspectRatio: 16/9,
                              viewportFraction: 1,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration: Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                            ),
                            itemCount: data.data!.length,
                            itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                              return Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xffD0E1F0),
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 15.0),
                                              child: CustomText(
                                                text: data.data![itemIndex].title.toString(),
                                                color: Color(0xff1C74BC),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 15.0),
                                              child: CustomButton(
                                                  text: 'المزيد',
                                                  onPress: () async{
                                                    await controller.funLaunchUrl(data.data![itemIndex].link.toString());
                                                  }
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xff4EA8F1),
                                          shape: BoxShape.circle,
                                        ),
                                        height: 125,
                                        width: 130,
                                        child: Image.network(
                                          'https://cars-ksa.tech/'+data.data![itemIndex].image.toString(),
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
                                    ],
                                  ),
                                ),
                              );
                            }
                          );
                        }else{
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                Get.to(AllCategoryScreen());
              },
              child: Padding(
                padding: EdgeInsets.all(15),
                child: CustomText(
                  text:'.... الخدمات الشائعة',
                  color: Color(0xff1C74BC),
                  alignment: Alignment.topRight,
                  fontSize: 22,
                  fontweight: FontWeight.bold,
                ),
              ),
            ),
            FutureBuilder(
              future: controller.getProducts(),
              builder: ( context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.hasData) {
                  var data = snapshot.data['data'];
                  //print(data);
                  return Container(
                    height: 200,
                    child: ListView.builder(
                      itemCount: data.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Get.to(DetailsScreen(data: data[index],));
                          },
                          child: Container(
                            color: Color(0xffFFFFFF),
                            margin: EdgeInsets.all(15),
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.grey.shade100,
                                  ),
                                  height: 60,
                                  width: 80,
                                  child: ClipOval(
                                    child: Image.network(
                                      'https://cars-ksa.tech/' + data[index]['image'],
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
                                  height: 20,
                                ),
                                CustomText(
                                  text: data[index]['name'].toString(),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomText(
                                  text: '${data[index]['price'].toString() + ' ' + ' SAR'}',
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      // separatorBuilder: (context, index) =>
                      //     SizedBox(
                      //       width: 20,
                      //     ),
                    ),
                  );
                }else{
                  return Center(child: CircularProgressIndicator());
                }
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
