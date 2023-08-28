import 'package:client_carservice/view/screens/home/all_category_screen.dart';
import 'package:client_carservice/view/screens/home/details_screen.dart';
import 'package:client_carservice/view/screens/home/wallet.dart';
import 'package:client_carservice/view/screens/operations/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/home/home_screen.dart';
import '../screens/home/profile_screen.dart';
import '../screens/operations/containue.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type : BottomNavigationBarType.fixed,
      backgroundColor: Color(0xff1C74BC),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home,color: Colors.white,),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category,color: Colors.white,),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.wallet,color: Colors.white,),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_outlined,color: Colors.white,),
          label: '',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person,color: Colors.white,),
            label: ''
        ),
      ],
      currentIndex: 0,
      onTap: (index) {
        switch(index){
          case 0 :
            Get.offAll(HomeScreen());
            break;
          case 1 :
            Get.offAll(AllCategoryScreen());
            break;
          case 2 :
            Get.offAll(WalletScreen());
            break;
          case 3 :
            Get.offAll(WaitingScreen());
            break;
          case 4 :
            Get.offAll(ProfileScreen());
            break;
        }
      },
    );
  }
}
