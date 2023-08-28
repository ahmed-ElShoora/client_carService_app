import 'package:client_carservice/const.dart';
import 'package:client_carservice/view/wedgits/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_fatoorah/my_fatoorah.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../controller/home/chooseLocationController.dart';
import '../../wedgits/bottom_nav.dart';
import 'home_screen.dart';

class ChooseLocatonScreen extends StatelessWidget {
  final data;
  final image;
  final note;
  final tec_id;

  ChooseLocatonScreen({super.key, required this.data, required this.image, required this.note, required this.tec_id});
  ChooseLocationController controller = Get.put(ChooseLocationController());

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
          future: controller.getPostion(),
          builder: (context,AsyncSnapshot snapShot){
            if(snapShot.hasData){
              return CustomButton(onPress: () async{
                var response = await MyFatoorah.startPayment(
                  context: context,
                  request: MyfatoorahRequest.live(
                    currencyIso: Country.SaudiArabia,
                    successUrl: 'https://www.shutterstock.com/image-vector/accepted-rubber-stamp-seal-red-260nw-1284578644.jpg',
                    errorUrl: 'https://www.shutterstock.com/image-vector/caution-exclamation-mark-white-red-260nw-1055269061.jpg',
                    invoiceAmount: double.parse(data['price'].toString()),
                    language: ApiLanguage.Arabic,
                    token: token_pay.toString(),
                  ),
                );
                if(response.status.toString() == 'PaymentStatus.Success'){
                  await controller.createOrder(tec_id,note,image,data,snapShot.data);
                  Get.offAll(HomeScreen());
                }else{
                  Alert(
                    context: context,
                    type: AlertType.error,
                    title: "خطأ",
                    desc: "حدث خطأ اثناء العملية برجاء المحاولة مره اخره",
                  ).show();
                }
              },text: 'الدفع و التأكيد',);
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
