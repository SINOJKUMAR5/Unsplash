import 'package:flutter/material.dart';
import 'package:unsplash/view_catagories_image.dart';

class catagories_listview extends StatefulWidget {
  const catagories_listview({super.key});

  @override
  State<catagories_listview> createState() => _catagories_listviewState();
}

class _catagories_listviewState extends State<catagories_listview> {
  List catagories = [
    "https://images.unsplash.com/photo-1648413653819-7c0fd93e8e6a?q=80&w=1965&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1499372076272-6b5c2d2bb391?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1510784722466-f2aa9c52fff6?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1583337130417-3346a1be7dee?q=80&w=1964&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1527631746610-bca00a040d60?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1532381872557-b370482876a3?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
  ];

  List catagories_name = [
    "cars",
    "love",
    "nature",
    "dogs",
    "travel",
    "photograpy"
  ];
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: controller,
        scrollDirection: Axis.horizontal,
        itemCount: catagories.length,
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return view_catagories_image(
                        catagories_name: catagories_name[index]);
                  }));
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(catagories[index]),
                          fit: BoxFit.cover)),
                  child: Center(
                    child: Text(
                      catagories_name[index],
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
