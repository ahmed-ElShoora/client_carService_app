import 'package:flutter/material.dart';

class ErrorConectionScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/pattern-background.jpg'),
            fit: BoxFit.cover),
      ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'تحقق من الاتصال بالانترنت',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
              ),
            ),
            Image.asset('assets/images/wifi-error.png',width: 50,height: 50,)
          ],
      ),
    );
  }
}
