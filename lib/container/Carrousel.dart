import 'package:flutter/material.dart';
import 'package:lcdf_idfm/container/MediaContainer.dart';
import 'package:lcdf_idfm/button/btnRound.dart';
import 'package:lcdf_idfm/player/video/YoutubeVideoPlayer.dart';
import 'package:lcdf_idfm/principals/FullScreenImage.dart';
import 'package:lcdf_idfm/container/ZoomedContainer.dart';
import 'package:lcdf_idfm/text/SubTitle.dart';

class Carrousel extends StatefulWidget {
  String? title;
  bool zoomable;
  List<MediaContent> images;
  List<MediaContent> videos;
  Carrousel({
    super.key,
    this.title,
    this.images = const [],
    this.videos = const [],
    this.zoomable = false,
  });
  @override
  State<Carrousel> createState() => _CarrouselState();
}

class _CarrouselState extends State<Carrousel> {
  String source = "";
  String description = "";
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    source = widget.images.isNotEmpty
        ? widget.images[0].credits
        : widget.videos[0].credits;
    description = widget.images.isNotEmpty
        ? widget.images[0].description
        : widget.videos[0].description;
  }

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    int totalPages = widget.images.length + widget.videos.length;

    return SizedBox(
      height: (widget.title != null || widget.zoomable == true) ? 290 : 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (widget.title != null) ...[
                Expanded(child: SubTitle(title: widget.title ?? "")),
                SizedBox(height: 10),
              ],
              SizedBox(width: 10),
              if (widget.zoomable == true) ...[
                BtnRound(
                  isUnactive: false,
                  action: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ZoomedContainer(
                          elements:
                              widget.images.map((e) {
                                return Expanded(
                                  child: Carrousel(
                                    images: [e],
                                    videos: [],
                                    zoomable: false,
                                    title: "",
                                  ),
                                );
                              }).toList() +
                              widget.videos.map((e) {
                                return Expanded(
                                  child: Carrousel(
                                    images: [],
                                    videos: [e],
                                    zoomable: false,
                                    title: e.description,
                                  ),
                                );
                              }).toList(),
                          title: widget.title ?? "",
                          nbElementRow: 1,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        PageView(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              currentPage = index;
                              if (index < widget.images.length) {
                                description = widget.images[index].description;
                                source = widget.images[index].credits;
                              } else {
                                description = widget.videos[index].description;
                                source = widget.videos[index].credits;
                              }
                            });
                          },
                          children: [
                            if (widget.images.isNotEmpty)
                              for (var i = 0; i < widget.images.length; i++)
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FullScreenImage(
                                          imagePath: widget.images[i].Path,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Image.asset(
                                    widget.images[i].Path,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                            if (widget.videos.isNotEmpty)
                              for (var i = 0; i < widget.videos.length; i++)
                                YoutubeVideoPlayer(
                                  videoId: widget.videos[i].Path,
                                ),
                          ],
                        ),
                        if (totalPages > 1)
                          Positioned(
                            bottom: 10,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(totalPages, (index) {
                                return Container(
                                  margin: const EdgeInsets.all(4),
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: currentPage == index
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.5),
                                    shape: BoxShape.circle,
                                  ),
                                );
                              }),
                            ),
                          ),
                        Positioned(
                          left: 10,
                          top: 78,
                          child: BtnRound(
                            isUnactive: currentPage == 0,
                            action: () {
                              _pageController.previousPage(
                                curve: Curves.easeInOut,
                                duration: Duration(milliseconds: 250),
                              );
                            },
                            rotation: 3.14,
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 78,
                          child: BtnRound(
                            isUnactive: currentPage == totalPages - 1,
                            action: () {
                              _pageController.nextPage(
                                curve: Curves.easeInOut,
                                duration: Duration(milliseconds: 250),
                              );
                            },
                            rotation: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(child: Text(description)),
          Center(
            child: Text(
              source,
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
