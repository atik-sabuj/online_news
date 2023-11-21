import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1 ;
    final height = MediaQuery.sizeOf(context).height * 1 ;

    return Scaffold(
      appBar: AppBar(
        title: Text('News Details Screen'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: Stack(
        children: [
          Container(
            child: Container(
              height: height * 0.45,
              child : ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(40),
                ),
              child: CachedNetworkImage(
                imageUrl: widget.newsImage,
                fit: BoxFit.cover,
              ),
              ),
            ),
          )
        ],
      ),


    );
  }
}
