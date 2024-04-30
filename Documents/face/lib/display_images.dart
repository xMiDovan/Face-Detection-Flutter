// ignore_for_file: depend_on_referenced_packages, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

class ImageListPage extends StatefulWidget {
  @override
  _ImageListPageState createState() => _ImageListPageState();
}

class _ImageListPageState extends State<ImageListPage> {
  List<String> _imageUrls = [];

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  Future<void> fetchImages() async {
    final response = await http.get(Uri.parse('https://mthesis.com/face/view_image.php'));

    try{
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          _imageUrls = List<String>.from(data.map((imageData) => imageData['url'] as String));
        });
      } else {
        throw Exception('Failed to load images');
      }
    } catch(Exception)
    {
      print(Exception);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Intruder List'),
      ),
      body: _imageUrls.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of images per row
                crossAxisSpacing: 4.0, // Spacing between each image horizontally
                mainAxisSpacing: 4.0, // Spacing between each image vertically
              ),
              itemCount: _imageUrls.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    imageUrl: _imageUrls[index],
                    fit: BoxFit.cover, // Ensure the image covers the whole space
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                );
              },
            ),
    );
  }
}
