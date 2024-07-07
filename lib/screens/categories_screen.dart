import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_apk/Services/news_services.dart';
import 'package:news_apk/models/categories_news_model.dart';
import 'package:news_apk/screens/news_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  NewsServices newsServices = NewsServices();
  String categoryName = "General";
  final format = DateFormat("MMMM  dd, yyyy");

  List<String> categoriesList = [
    "General",
    "Entertainment",
    "Health",
    "Sports",
    "Business",
    "Technology",
  ];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoriesList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    categoryName = categoriesList[index];
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 7, bottom: 3),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: categoryName == categoriesList[index]
                          ? Colors.deepPurple
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: categoryName == categoriesList[index] ? 1 : 2,
                        color: categoryName == categoriesList[index]
                            ? Colors.black
                            : Colors.deepPurple,
                      ),
                    ),
                    child: Text(
                      categoriesList[index],
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: categoryName == categoriesList[index]
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<CategoriesNewsModel>(
              future: newsServices.fetCategoriesNewsApi(categoryName),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitChasingDots(
                      size: 50,
                      color: Colors.deepPurple,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(snapshot
                          .data!.articles![index].publishedAt
                          .toString());
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return NewsScreen(
                                author: snapshot.data!.articles![index].author
                                    .toString(),
                                content: snapshot.data!.articles![index].content
                                    .toString(),
                                description: snapshot
                                    .data!.articles![index].description
                                    .toString(),
                                newsDate: snapshot
                                    .data!.articles![index].publishedAt
                                    .toString(),
                                newsImage: snapshot
                                    .data!.articles![index].urlToImage
                                    .toString(),
                                newsTitle: snapshot.data!.articles![index].title
                                    .toString(),
                                source: snapshot
                                    .data!.articles![index].source!.name
                                    .toString(),
                              );
                            },
                          ));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            // color: Colors.black.withOpacity(0.5),
                            border: Border.all(
                              color: Colors.deepPurple,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      height: heigth * 0.18,
                                      width: width * 0.3,
                                      placeholder: (context, url) {
                                        return const SpinKitChasingDots(
                                          size: 50,
                                          color: Colors.deepPurple,
                                        );
                                      },
                                      errorWidget: (context, url, error) {
                                        return Image.asset(
                                          "assets/Hand holding smartphones with online newspaper, newsletter.jpg",
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(8),
                                    height: heigth * 0.18,
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        Text(
                                          snapshot.data!.articles![index].title
                                              .toString(),
                                          maxLines: 4,
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: width * 0.23,
                                              child: Text(
                                                snapshot.data!.articles![index]
                                                    .source!.name
                                                    .toString(),
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors
                                                      .deepPurple.shade700,
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              format.format(dateTime),
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    Colors.deepPurple.shade700,
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
                    },
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
