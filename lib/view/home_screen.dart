import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_news/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  NewsViewModel newsViewModel = NewsViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){},
          icon: Image.asset('images/category_icon.png',
              height: 30,
              width: 30,
        ),
        ),
        title: Text('News 24/7', style: GoogleFonts.poppins(fontWeight: FontWeight.w700),),
        centerTitle: true,
      ),
    );
  }
}
