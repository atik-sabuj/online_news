import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:online_news/models/news_channels_headlines_model.dart';
import 'package:online_news/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  NewsViewModel newsViewModel = NewsViewModel();

  final format = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1 ;
    final height = MediaQuery.sizeOf(context).height * 1 ;
    
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

      body: ListView(
        children: [
          SizedBox(
            height: height * 0.55,
            width: width,
            child: FutureBuilder<NewsChannelsHeadlinesModel>(
              future: newsViewModel.fetchNewsChannelsHeadlinesApi(),
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
                    itemCount: snapshot.data!.articlesList!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {

                      DateTime dateTime = DateTime.parse(snapshot.data!.articlesList![index].publishedAt.toString());

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
                                  imageUrl: snapshot.data!.articlesList![index].urlToImage.toString(),

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
                                    padding: EdgeInsets.all(15),
                                    height: height * 0.22,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: width * 0.6,

                                          child: Text(snapshot.data!.articlesList![index].title.toString(),
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
                                                Text(snapshot.data!.articlesList![index].source!.name.toString(),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
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
          )
        ],
      ),
    );
  }

}


const spinKit2 = SpinKitCircle(
  color: Colors.amber,
  size: 50,
);
