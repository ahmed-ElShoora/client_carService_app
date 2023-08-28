
import 'package:client_carservice/view/screens/operations/complete.dart';
import 'package:client_carservice/view/screens/operations/containue.dart';
import 'package:client_carservice/view/screens/operations/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custome_text.dart';

class BarState extends StatelessWidget {
  const BarState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0,right: 15,left: 15),
      child: Container(
        //color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 70,
              width: 100,
              decoration: BoxDecoration(
                color: Color(0xffd6d9d9),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: GestureDetector(
                onTap: (){
                  Get.offAll(CompleteScreen());
                },
                child: CustomText(
                  text: 'مكتمله',
                  color: Colors.black,
                  alignmentText: TextAlign.center,
                  fontSize: 25,
                ),
              ),
            ),
            SizedBox(width: 10,),
            Container(
              height: 70,
              width: 100,
              decoration: BoxDecoration(
                color: Color(0xffd6d9d9),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: GestureDetector(
                onTap: (){
                  Get.offAll(ContainueScreen());
                },
                child: CustomText(
                  text: 'جارية',
                  color: Colors.black,
                  alignmentText: TextAlign.center,
                  fontSize: 25,
                ),
              ),
            ),
            SizedBox(width: 10,),
            Container(
              height: 70,
              width: 100,
              decoration: BoxDecoration(
                color: Color(0xffd6d9d9),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: GestureDetector(
                onTap: (){
                  Get.offAll(WaitingScreen());
                },
                child: CustomText(
                  text: 'قيد الانتظار',
                  color: Colors.black,
                  alignmentText: TextAlign.center,
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
