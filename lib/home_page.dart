import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:unsplash/catagories_listview.dart';
import 'package:unsplash/components.dart';
import 'package:unsplash/full_view.dart';
import 'package:unsplash/custom_drawer.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

// ignore: camel_case_types
class _home_pageState extends State<home_page> {
  // ignore: non_constant_identifier_names
  TextEditingController search_image_controller = TextEditingController();

  List<dynamic> images = [];
  // ignore: non_constant_identifier_names
  fetch_api(String catagores) async {
    try {
      var response = await http.get(Uri.parse(
          "https://api.unsplash.com/search/photos?page=1&per_page=100&query=$catagores&client_id=$access_key"));

      if (response.statusCode == 200) {
        var resJson = json.decode(response.body);
        print(resJson);
        setState(() {
          images = resJson["results"];
        });
      } else {}
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  @override
  void initState() {
    fetch_api("new");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      drawer: const custom_drawer(),
      appBar: AppBar(
        centerTitle: true,
        title: DefaultTextStyle(
            style: const TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.normal,
                shadows: [
                  Shadow(
                      color: Colors.black, offset: Offset(3, 3), blurRadius: 9)
                ]),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText("R e a l V i e w",
                    speed: const Duration(milliseconds: 200),
                    cursor: "",
                    curve: Curves.easeInOut)
              ],
              repeatForever: true,
            )),
        elevation: 0,
        toolbarHeight: 70,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: TextField(
                controller: search_image_controller,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white54,
                    suffixIcon: InkWell(
                        onTap: () {
                          fetch_api(search_image_controller.text);
                        },
                        child: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        )),
                    hintText: "search",
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 199, 198, 198)),
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 199, 198, 198)),
                        borderRadius: BorderRadius.circular(20)))),
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(height: 200, child: catagories_listview()),
          Expanded(
            child: MasonryGridView.builder(
              itemCount: images.length,
              itemBuilder: (((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: InkWell(
                      child: Image.network(
                        images[index]["urls"]["full"],
                        fit: BoxFit.cover,
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return full_view(
                              image_url: images[index]["urls"]["raw"]);
                        }));
                      },
                    ),
                  ),
                );
              })),
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  search_image(index) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(images[index]["urls"]["full"]),
              fit: BoxFit.cover)),
    );
  }
}
