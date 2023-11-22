import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:online_news/models/categories_news_model.dart';
import 'package:online_news/models/news_channels_headlines_model.dart';
import 'package:online_news/view/categories_screen.dart';
import 'package:online_news/view/news_details_screen.dart';
import 'package:online_news/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList {bbcNews,aljazeera, abcNews, cbsNews, reuters, cnn, espn}


class _HomeScreenState extends State<HomeScreen> {

  NewsViewModel newsViewModel = NewsViewModel();

  FilterList? selectedMenu;

  final format = DateFormat('MMMM dd, yyyy');

  String name = 'bbc-news';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1 ;
    final height = MediaQuery.sizeOf(context).height * 1 ;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('News 24/7', style: GoogleFonts.poppins(fontWeight: FontWeight.w700),),
        centerTitle: true,

        leading: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesScreen()));
          },

          icon: Image.asset('images/category_icon.png',
              height: 30,
              width: 30,
        ),
        ),

        actions: [
          PopupMenuButton<FilterList>(
            initialValue: selectedMenu,

              icon: Icon(Icons.more_vert, color: Colors.black,),

              onSelected: (FilterList item) {

              if(FilterList.bbcNews.name == item.name) {
                name = 'bbc-news';
              }

              if(FilterList.bbcNews.name == item.name) {
                name = 'al-jazeera-english';
              }

              if(FilterList.abcNews.name == item.name) {
                name = 'abc-news';
              }

              if(FilterList.cbsNews.name == item.name) {
                name = 'cbs-news';
              }

              if(FilterList.reuters.name == item.name) {
                name = 'reuters';
              }


              if(FilterList.cnn.name == item.name) {
                name = 'cnn';
              }

              if(FilterList.espn.name == item.name) {
                name = 'espn';
              }



              setState(() {
                selectedMenu = item;
              });

              },

              itemBuilder: (context) => <PopupMenuEntry<FilterList>> [
                PopupMenuItem<FilterList>(
                  value: FilterList.bbcNews,
                    child: Text('BBC News'),
                ),

                PopupMenuItem<FilterList>(
                  value: FilterList.aljazeera,
                  child: Text('Al Jazeera English'),
                ),

                PopupMenuItem<FilterList>(
                  value: FilterList.abcNews,
                  child: Text('ABC News'),
                ),

                PopupMenuItem<FilterList>(
                  value: FilterList.cbsNews,
                  child: Text('CBS News'),
                ),

                PopupMenuItem<FilterList>(
                  value: FilterList.reuters,
                  child: Text('Reuters'),
                ),

                PopupMenuItem<FilterList>(
                  value: FilterList.cnn,
                  child: Text('CNN'),
                ),

                PopupMenuItem<FilterList>(
                  value: FilterList.espn,
                  child: Text('ESPN'),
                ),



              ]
          ),

        ],

      ),

      body: ListView(
        children: [
          SizedBox(
            height: height * 0.40,
            width: width,
            child: FutureBuilder<NewsChannelsHeadlinesModel>(
              future: newsViewModel.fetchNewsChannelsHeadlinesApi(name),
              builder: (BuildContext context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: Colors.blue,
                    ),
                  );
                }else {
                  return ListView.builder(
                    itemCount: snapshot.data!.articles!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {

                      DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());

                      return SizedBox(
                        child: Container(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: height * 0.6,
                                width: width * 1,
                              padding: EdgeInsets.symmetric(
                                horizontal: height * 0.1,
                              ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data!.articles![index].urlToImage.toString(),

                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(child: spinKit2,),

                                  errorWidget: (context, url, error) => Icon(Icons.error_outline, color: Colors.red,),

                                ),
                                ),
                              ),

                              Positioned(
                                bottom: 20,
                                child: Card(
                                  elevation: 5,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    padding: EdgeInsets.all(8),
                                    height: height * 0.18,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: width * 0.6,

                                          child: Text(snapshot.data!.articles![index].title.toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w700),
                                          ),
                                    ),
                                          Spacer(),

                                          Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(snapshot.data!.articles![index].source!.name.toString(),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600,color: Colors.blue),
                                                ),

                                                Text(format.format(dateTime),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                      }
                  );
                }
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder<CategoriesNewsModel>(
              future: newsViewModel.fetchCategoriesNewsApi('General'),
              builder: (BuildContext context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: Colors.blue,
                    ),
                  );
                }else {
                  return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      shrinkWrap: true,
                      //scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {

                        DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());

                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                NewsDetailsScreen(
                                    newsImage: snapshot.data!.articles![index].urlToImage.toString(),
                                    newsTitle: snapshot.data!.articles![index].title.toString(),
                                    newsDate: snapshot.data!.articles![index].publishedAt.toString(),
                                    author: snapshot.data!.articles![index].author.toString(),
                                    description: snapshot.data!.articles![index].description.toString(),
                                    content: snapshot.data!.articles![index].content.toString(),
                                    source: snapshot.data!.articles![index].source!.name.toString()))
                            );
                          },

                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data!.articles![index].urlToImage.toString(),

                                      fit: BoxFit.cover,
                                      height : height * 0.2,
                                      width : width * 0.2,

                                      placeholder: (context, url) => Container(child: Center(
                                        child: SpinKitCircle(
                                          size: 50,
                                          color: Colors.blue,
                                        ),
                                      ),),

                                      errorWidget: (context, url, error) => Icon(Icons.error_outline, color: Colors.red,),

                                    ),
                                  ),

                                  Expanded(
                                    child: Container(
                                      height: height * 0.18,
                                      padding : EdgeInsets.only(left: 15),
                                      child: Column(
                                        children: [
                                          Text(snapshot.data!.articles![index].title.toString(),
                                            maxLines: 3,
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),

                                          Spacer(),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(snapshot.data!.articles![index].source!.name.toString(),
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),


                                              Text(format.format(dateTime),
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),


                                        ],
                                      ),
                                    ),

                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

}


const spinKit2 = SpinKitCircle(
  color: Colors.amber,
  size: 50,
);
