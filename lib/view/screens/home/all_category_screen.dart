import 'package:carousel_slider/carousel_slider.dart';
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

class AllCategoryScreen extends StatelessWidget {
  HomeController controller = Get.put(HomeController());
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
          future: controller.getProducts(),
          builder: ( context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.hasData) {
              var data = snapshot.data['data'];
              //print(data);
              return Container(
                //height: 200,
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Get.to(DetailsScreen(data: data[index],));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffFFFFFF),
                          borderRadius: BorderRadius.circular(15)
                        ),
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey.shade100,
                              ),
                              height: 60,
                              width: 60,
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
                              width: 20,
                            ),
                            Column(
                              children: [
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
                            )
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
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
