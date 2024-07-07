import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_apk/Services/news_services.dart';
import 'package:news_apk/models/news_channel_headlines_model.dart';
import 'package:news_apk/screens/categories_screen.dart';
import 'package:news_apk/screens/news_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

String name = 'bbc-news';

enum FilterList {
  bbcNews,
  cnn,
  theHindu,
  theTimesOfIndia,
  googleNews,
  googleIndia,
  foxNews,
}

class _HomeScreenState extends State<HomeScreen> {
  NewsServices newsServices = NewsServices();
  final format = DateFormat("MMMM  dd, yyyy");
  FilterList? selectedMenu;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.multitrack_audio),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CategoriesScreen()));
          },
        ),
        title: Text(
          "News",
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<FilterList>(
            onSelected: (FilterList item) {
              if (FilterList.bbcNews.name == item.name) {
                name = "bbc-news";
              }
              if (FilterList.cnn.name == item.name) {
                name = "cnn";
              }
              if (FilterList.googleNews.name == item.name) {
                name = "google-news";
              }
              if (FilterList.theHindu.name == item.name) {
                name = "the-hindu";
              }
              if (FilterList.theHindu.name == item.name) {
                name = "the-hindu";
              }
              if (FilterList.theTimesOfIndia.name == item.name) {
                name = "the-times-of-india";
              }
              if (FilterList.googleIndia.name == item.name) {
                name = "google-news-in";
              }
              if (FilterList.foxNews.name == item.name) {
                name = "fox-news";
              }
              setState(() {
                selectedMenu = item;
              });
            },
            initialValue: selectedMenu,
            itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
              const PopupMenuItem<FilterList>(
                value: FilterList.bbcNews,
                child: Text("BBC"),
              ),
              const PopupMenuItem<FilterList>(
                value: FilterList.cnn,
                child: Text("CNN"),
              ),
              const PopupMenuItem<FilterList>(
                value: FilterList.googleNews,
                child: Text("Google"),
              ),
              const PopupMenuItem<FilterList>(
                value: FilterList.googleIndia,
                child: Text("Google India"),
              ),
              const PopupMenuItem<FilterList>(
                value: FilterList.theHindu,
                child: Text("The Hindu"),
              ),
              const PopupMenuItem<FilterList>(
                value: FilterList.theTimesOfIndia,
                child: Text("Times Of India"),
              ),
              const PopupMenuItem<FilterList>(
                value: FilterList.foxNews,
                child: Text("Fox News"),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: heigth * 0.55,
            width: width,
            child: FutureBuilder<NewsChannelHeadlinesModel>(
              future: newsServices.fetchNewsChannelHeadlinesApi(),
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
                    scrollDirection: Axis.horizontal,
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
                        child: SizedBox(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: heigth * 0.6,
                                width: width * 0.9,
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.04,
                                  vertical: heigth * 0.02,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 3,
                                      color: Colors.deepPurple,
                                    ),
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
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
                              ),
                              Positioned(
                                bottom: 20,
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    height: heigth * 0.15,
                                    alignment: Alignment.bottomCenter,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: width * 0.7,
                                          child: Text(
                                            snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        SizedBox(
                                          width: width * 0.7,
                                          child: Row(
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index]
                                                    .source!.name
                                                    .toString(),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const Spacer(),
                                              Text(
                                                format.format(dateTime),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
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
                    },
                  );
                }
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: newsServices.fetchIndianNewsApi(),
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
                                            color: Colors.black87,
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
