import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unsplash/theme/theme_provider.dart';

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoSwitch(
                value:
                    Provider.of<ThemeProvider>(context, listen: false).isdark,
                onChanged: (value) {
                  setState(() {
                    Provider.of<ThemeProvider>(context, listen: false).toggle();
                  });
                })
          ],
        ),
      ),
    );
  }
}
