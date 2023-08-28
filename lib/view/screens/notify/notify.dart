import 'package:client_carservice/view/wedgits/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';


import '../../../controller/home/notifyController.dart';
import '../../wedgits/custome_text.dart';
import '../home/home_screen.dart';

class NotifyScreen extends StatelessWidget {
  NotifyController controller = Get.put(NotifyController());
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: FutureBuilder(
                  future: controller.getData(),
                  builder: (context, AsyncSnapshot snapShot) {
                    if(snapShot.hasData) {
                      var data = snapShot.data;
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: data['data'].length,
                        itemBuilder: (context,int index) {
                          return Container(
                            margin: EdgeInsets.only(right: 16,left: 16,bottom: 16),
                            padding: EdgeInsets.all(20),
                            width: double.infinity,
                            //height: 175,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0.0, 0.75),
                                    color: Color(0xff777777),
                                    blurRadius: 2.0,
                                  ),
                                ]
                            ),
                            child: Column(
                              children: [
                                CustomText(text: 'رقم الخدمه '+data['data'][index]['order_id'].toString(),alignment: Alignment.topLeft,fontSize: 17,fontweight: FontWeight.normal,),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.topRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      CustomText(
                                        text: data['data'][index]['name'].toString(),
                                        fontweight: FontWeight.normal,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xff4EA8F1),
                                          shape: BoxShape.circle,
                                        ),
                                        height: 70,
                                        width: 70,
                                        child: ClipOval(
                                          child: Image.network(
                                            'https://cars-ksa.tech/'+data['data'][index]['photo'].toString(),
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
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                ReadMoreText(
                                  data['data'][index]['desc'].toString(),
                                  trimLines: 2,
                                  colorClickableText: Colors.pink,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: 'عرض المزيد',
                                  trimExpandedText: 'عرض اقل',
                                  moreStyle: TextStyle(
                                    fontSize: 17,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ],
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
                )
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
