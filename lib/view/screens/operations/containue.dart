import 'package:client_carservice/view/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_fatoorah/my_fatoorah.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../const.dart';
import '../../../controller/operation/operation_controller.dart';
import '../../wedgits/bar.dart';
import '../../wedgits/bottom_nav.dart';
import '../../wedgits/custome_text.dart';
import 'package:http/http.dart'as http;

class ContainueScreen extends StatelessWidget {
  OperationController controller = Get.put(OperationController());
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
              BarState(),
              SizedBox(
                height: 15,
              ),
              FutureBuilder(
                future: controller.getDataPage(2),
                builder: (context,AsyncSnapshot snapShot){
                  if(snapShot.hasData){
                    var data = snapShot.data;
                    //print(data);
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context,int index) {
                        return GestureDetector(
                          onTap: () async {
                            if(data[index]['pay-invoice']==0 && data[index]['add-addtions']==0) {
                              Get.defaultDialog(
                                  title: 'لم يتم انشاء الفاتورة بعد',
                                  middleText: '');
                            }
                            if(data[index]['pay-invoice']==0 && data[index]['add-addtions']==1){

                              var response = await MyFatoorah.startPayment(
                                context: context,
                                request: MyfatoorahRequest.live(
                                  currencyIso: Country.SaudiArabia,
                                  successUrl: 'https://www.shutterstock.com/image-vector/accepted-rubber-stamp-seal-red-260nw-1284578644.jpg',
                                  errorUrl: 'https://www.shutterstock.com/image-vector/caution-exclamation-mark-white-red-260nw-1055269061.jpg',
                                  invoiceAmount: double.parse(data[index]['price']),
                                  language: ApiLanguage.Arabic,
                                  token: token_pay.toString(),
                                ),
                              );
                              if(response.status.toString() == 'PaymentStatus.Success'){
                                await controller.moveToPay(data[index]['id']);
                                Get.offAll(HomeScreen());
                              }else{
                                Alert(
                                  context: context,
                                  type: AlertType.error,
                                  title: "خطأ",
                                  desc: "حدث خطأ اثناء العملية برجاء المحاولة مره اخره",
                                ).show();
                              }
                            }
                            if(data[index]['pay-invoice']==1 && data[index]['add-addtions']==1){
                              Get.defaultDialog(title: 'جاري العمل علي الطلب',middleText: '');
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 16,left: 16,bottom: 16),
                            padding: EdgeInsets.all(20),
                            width: double.infinity,
                            height: 178,
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
                                CustomText(text: 'رقم الخدمه '+data[index]['id'].toString(),alignment: Alignment.topLeft,fontSize: 17,fontweight: FontWeight.normal,),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.topRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      CustomText(
                                        text: data[index]['name_user'].toString(),
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
                                            'https://cars-ksa.tech/'+data[index]['image_user'].toString(),
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
                                SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                  text: controller.reStateBarText(data[index]['add-addtions'],data[index]['pay-invoice']),
                                  fontSize: 18,
                                  fontweight: FontWeight.w600,
                                ),
                              ],
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
