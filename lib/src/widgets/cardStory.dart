
// ignore: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../services/story_services.dart';
import '../model/story.dart';
import 'dart:ui' as ui;


class CardStory extends StatefulWidget {
  
  const CardStory({
    Key? key,
    required this.size,
  }) : super(key: key);

  final ui.Size size;

  @override
  State<CardStory> createState() => _StoryState();
}

class _StoryState extends State<CardStory> {
  // create list types Storys
  List<Storys> storys = [];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final storyServices = Provider.of<StoryServices>(context);
    storys = storyServices.storysByStatusTrue;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border:
              Border.all(width: 0.5, color: Colors.white70.withOpacity(0.1))),
      width: Platform.isAndroid || Platform.isIOS
          ? widget.size.width * 0.96
          : widget.size.width / 2.2,
      height: Platform.isAndroid || Platform.isIOS
          ? widget.size.height * 0.3
          : widget.size.height * 0.5,
      child: storys.isEmpty
          ? const Center(child: Text('No hay hostoarias que mostrar'))
          : CardSwiper(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              // threshold: 20,
              // maxAngle: 10,
              numberOfCardsDisplayed: 1,
              // isHorizontalSwipingEnabled: true,
              direction: CardSwiperDirection.left,
              cardsCount: storys.length,
              cardBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          width: 0.5, color: Colors.white70.withOpacity(0.1))),
                  width: widget.size.width / 2.2,
                  height: widget.size.height * 0.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: storys[index].archivos == null
                        ? Center(
                            child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('No Image'),
                                Text(
                                  storys[index].data!,
                                  style: const TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ))
                        : Image.network(
                            // 'http://192.168.1.71:8080/api/uploadFile/${storys[index].id}/story',
                            'http://1.bp.blogspot.com/-zKX8CREi3QY/T2OMZgW3s6I/AAAAAAAAWzg/5sFH754c6sw/s1600/Los-mas-Hermosos-Paisajes-Naturales_04.jpg',
                            fit: BoxFit.fill,
                          ),
                  ),
                );
              }),
    );
  }
}
