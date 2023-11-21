import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsDetailsScreen extends StatefulWidget {

  final String newsImage, newsTitle, newsDate, author, description, content, source ;

  const NewsDetailsScreen({Key? key,
    required this.newsImage,
    required this.newsTitle,
    required this.newsDate,
    required this.author,
    required this.description,
    required this.content,
    required this.source,

  }) : super(key: key);

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {

  final format = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1 ;
    final height = MediaQuery.sizeOf(context).height * 1 ;

    DateTime dateTime = DateTime.parse(widget.newsDate);

    return Scaffold(
      appBar: AppBar(
        title: Text('News Details Screen'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: Stack(
        children: [
          Container(
            height: height * 0.45,
            child : ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(40),
              ),
            child: CachedNetworkImage(
              imageUrl: widget.newsImage,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
            ),
            ),
          ),

          Container(
            height: height * 0.6,
            margin: EdgeInsets.only(top: height * 0.4),
            padding: EdgeInsets.only(top: 20, right: 20, left: 20,),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(40),
                ),
              color: Colors.white
            ),

            child: ListView(
              children: [
                Text(widget.newsTitle,
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w700),
                ),

                SizedBox(height: height * 0.0,),

                Row(
                  children: [
                    Expanded(
                      child: Text(widget.source,
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600),
                      ),
                    ),

                    Text(format.format(dateTime),
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),

                SizedBox(height: height * 0.1,),

                Text(widget.description,
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500),
                ),


              ],
            ),
          ),
        ],
      ),


    );
  }
}
