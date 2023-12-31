
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../bloc/news_bloc.dart';
import '../../../bloc/news_event.dart';
import '../../cateogires_screen.dart';


enum FilterList { bbcNews, alJazeera, abcNews , cbsNews , reuters, cnn, espn}
FilterList? selectedMenu ;

class HomeAppBarWidget extends StatelessWidget {
   HomeAppBarWidget({Key? key}) : super(key: key);

  String name = 'bbc-news' ;

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      leading: IconButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesScreen()));
        },
        icon: Image.asset('images/category_icon.png' ,
          height: 30,
          width: 30,
        ),
      ),
      title: Text('News' , style: GoogleFonts.poppins(fontSize: 24 , fontWeight: FontWeight.w700),),
      actions: [
        PopupMenuButton<FilterList>(
            initialValue: selectedMenu,
            icon: Icon(Icons.more_vert , color: Colors.black,),
            onSelected: (FilterList item){

              if(FilterList.bbcNews.name == item.name){
                name = 'bbc-news' ;
              }

              if(FilterList.alJazeera.name ==item.name){
                name  = 'al-jazeera-english';
              }

              if(FilterList.abcNews.name ==item.name){
                name  = 'abc-news';
              }

              if(FilterList.cbsNews.name ==item.name){
                name  = 'cbs-news';
              }

              if(FilterList.reuters.name ==item.name){
                name  = 'reuters';
              }

              if(FilterList.cnn.name ==item.name){
                name  = 'cnn';
              }

              if(FilterList.espn.name ==item.name){
                name  = 'espn';
              }


              context.read<NewsBloc>()..add(FetchNewsChannelHeadlines(name));


            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterList>> [
              PopupMenuItem<FilterList>(
                value: FilterList.bbcNews ,
                child: Text('BBC News'),
              ),
              PopupMenuItem<FilterList>(
                value: FilterList.alJazeera ,
                child: Text('Al-Jazeera News'),
              ),
              PopupMenuItem<FilterList>(
                value: FilterList.abcNews ,
                child: Text('ABC News'),
              ),
              PopupMenuItem<FilterList>(
                value: FilterList.cbsNews ,
                child: Text('CBS News'),
              ),
              PopupMenuItem<FilterList>(
                value: FilterList.reuters ,
                child: Text('Reuters'),
              ),
              PopupMenuItem<FilterList>(
                value: FilterList.cnn ,
                child: Text('CNN'),
              ),
              PopupMenuItem<FilterList>(
                value: FilterList.espn ,
                child: Text('ESPN'),
              ),
            ]
        )
      ],
    );
  }
}
