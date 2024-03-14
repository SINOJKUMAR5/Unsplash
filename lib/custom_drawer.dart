import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:unsplash/pages.dart/settings.dart';

// ignore: camel_case_types
class custom_drawer extends StatefulWidget {
  const custom_drawer({super.key});

  @override
  State<custom_drawer> createState() => _custom_drawerState();
}

// ignore: camel_case_types
class _custom_drawerState extends State<custom_drawer> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40))),
        backgroundColor: Colors.grey.shade500,
        child: ListView(
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(),
                child: CircleAvatar(
                  foregroundImage: NetworkImage(
                      "https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=",
                      scale: 2),
                )),
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const settings();
                        }));
                      },
                      child: const ListTile(
                        leading: Icon(Icons.settings),
                        title: Text("Setting"),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Divider(
                        thickness: 0.3,
                      ),
                    ),
                    const InkWell(
                      child: ListTile(
                        leading: Icon(Icons.login),
                        title: Text("Account"),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Divider(
                        thickness: 0.3,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                icon: Icon(
                                  Icons.flutter_dash,
                                  color: Colors.blue,
                                  size: 50,
                                ),
                                elevation: 3,
                                title: Text("R e a l v i e w"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Ok"))
                                ],
                                content: Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child:
                                      Text("created by flutter 3.1.0 wit Api"),
                                ),
                              );
                            });
                      },
                      child: const ListTile(
                        leading: Icon(Icons.info),
                        title: Text("Info"),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Divider(
                        thickness: 0.3,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        auth.signOut();
                      },
                      child: ListTile(
                        leading: Icon(Icons.logout),
                        title: Text("Logout"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
