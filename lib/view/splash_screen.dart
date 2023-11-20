import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_news/view/categories_screen.dart';
import 'package:online_news/view/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  Timer(Duration(seconds: 3), () {
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CategoriesScreen()));
  });
}

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Online News'),
        centerTitle: true,
      ),

      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/splash_pic.jpg',
            fit: BoxFit.cover,
              height: height * .5,
            ),

            SizedBox(height: height * 0.2,),

            Text('TOP HEADLINES', style: GoogleFonts.anton(letterSpacing: 0.6, color: Colors.grey.shade700),),

            SizedBox(height: height * 0.1,),

            SpinKitChasingDots(
              color: Colors.blue,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}
