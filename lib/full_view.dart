import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

// ignore: camel_case_types
class full_view extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final String image_url;
  // ignore: non_constant_identifier_names
  const full_view({super.key, required this.image_url});

  @override
  State<full_view> createState() => _full_viewState();
}

// ignore: camel_case_types
class _full_viewState extends State<full_view> {
  // ignore: non_constant_identifier_names
  void downlote_image(String image_url) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.green,
          ));
        });
    FileDownloader.downloadFile(
      url: image_url.trim(),
      name: "image.jpg",
      onProgress: (fileName, progress) {},
      onDownloadCompleted: (path) {
        Navigator.pop(context);
      },
      onDownloadError: (errorMessage) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        Image.network(
          widget.image_url,
          fit: BoxFit.fill,
          filterQuality: FilterQuality.high,
        ),
        Positioned(
          bottom: 40,
          left: 550,
          child: Container(
            width: 200,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20)),
            child: TextButton(
              onPressed: () {
                downlote_image(widget.image_url);
              },
              child: const Icon(
                Icons.download_sharp,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
        )
      ]),
    );
  }
}
