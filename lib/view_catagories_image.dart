import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:unsplash/components.dart';
import 'package:unsplash/full_view.dart';

// ignore: camel_case_types
class view_catagories_image extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final String catagories_name;
  // ignore: non_constant_identifier_names
  const view_catagories_image({super.key, required this.catagories_name});

  @override
  State<view_catagories_image> createState() => _view_catagories_imageState();
}

// ignore: camel_case_types
class _view_catagories_imageState extends State<view_catagories_image> {
  List images = [];

  // ignore: non_constant_identifier_names
  fetch_api(String catagores) async {
    try {
      var response = await http.get(Uri.parse(
          "https://api.unsplash.com/search/photos?page=1&per_page=100&query=$catagores&client_id=$access_key"));

      if (response.statusCode == 200) {
        var resJson = json.decode(response.body);

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
    fetch_api(widget.catagories_name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MasonryGridView.builder(
        itemCount: images.length,
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                  child: Image.network(images[index]["urls"]["full"]),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return full_view(image_url: images[index]["urls"]["raw"]);
                    }));
                  },
                )),
          );
        },
      ),
    );
  }
}
