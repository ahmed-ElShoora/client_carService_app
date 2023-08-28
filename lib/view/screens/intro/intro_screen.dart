
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client_carservice/view/screens/intro/intro_two_screen.dart';
import '../../../controller/intro/introController.dart';
import '../../../model/Intro.dart';
import '../../wedgits/custome_text.dart';

class IntroScreen extends StatelessWidget {
  IntroController controller = Get.put(IntroController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1C74BC),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/pattern-background.jpg'),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: controller.getData(),
            builder: (context,AsyncSnapshot snapShot){
              if(snapShot.hasData){
              Intro data = snapShot.data;
              return Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://cars-ksa.tech/'+data.data.appPhaneIntro.one.image.toString(),
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: 200,
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
                    SizedBox(
                      height: 20,
                    ),
                    CustomText(
                      text: data.data.appPhaneIntro.one.title.toString(),
                      fontSize: 22,
                      alignment: Alignment.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomText(
                      text:
                      data.data.appPhaneIntro.one.desc.toString(),
                      fontweight: FontWeight.w400,
                      alignmentText: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MaterialButton(
                      onPressed: () {
                        Get.to(IntroTwoScreen());
                      },
                      color: Color(0xff1C74BC),
                      textColor: Colors.white,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 24,
                      ),
                      padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
                    )
                  ],
                ),
            );}else{
                return Center(child: CircularProgressIndicator());
              }}
          ),
        ),
      ),
    );
  }
}
