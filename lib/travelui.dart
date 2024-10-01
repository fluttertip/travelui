import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:travelui/dataservices.dart';
import 'package:carousel_slider/carousel_slider.dart';
import "package:travelui/descriptionpage.dart";

class Travelui extends StatefulWidget {
  const Travelui({super.key});

  @override
  State<Travelui> createState() => _TraveluiState();
}

class _TraveluiState extends State<Travelui> {
  final List<Map<String, dynamic>> destinations = DataService.destinations;
  final List<Map<String, dynamic>> hotels = DataService.hotels;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              height: 300,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
                  opacity: .4,
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Color.fromARGB(167, 0, 0, 0),
                    BlendMode.darken
                  )

                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.black.withOpacity(.9),
                    Colors.black.withOpacity(.6),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Where Do You Want To Go ?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 50,
                    margin:
                        const EdgeInsets.only(left: 0, right: 0, bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300,
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 20, top: 15),
                          hintText: 'Search for the Places nearby......'),
                    ),
                  ),
                ],
              ),
            ),
            customcarouselslider("Best Destination", destinations),
            customcarouselslider("Best Hotels", hotels),
          ],
        ),
      ),
    );
  }
}

Widget customcarouselslider(String title, List<Map<String, dynamic>> jsondata) {
  return Column(
    children: [
      Container(
        color: Colors.grey.shade300,
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(20),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(20),
        height: 350,
        child: CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 0.75,
            initialPage: 0,
            reverse: false,
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            height: 500.0,
          ),
          items: jsondata.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Column(children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DescriptionPage(
                                data: [i],
                              )));
                    },
                    child: Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Image.asset(
                        i['image'],
                        fit: BoxFit.scaleDown,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      i['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ]);
              },
            );
          }).toList(),
        ),
      ),
    ],
  );
}
