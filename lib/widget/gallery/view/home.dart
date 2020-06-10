import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterrr/widget/gallery/tab/image.dart';
import 'package:flutterrr/widget/gallery/tab/file.dart';
import 'package:flutterrr/widget/gallery/tab/photo.dart';
import 'package:path_provider/path_provider.dart';

class GalleryHome extends StatefulWidget {
  @override
  _GalleryHomeState createState() => _GalleryHomeState();
}

class _GalleryHomeState extends State<GalleryHome> {
  Future<Directory> _tempDirectory;
  Future<Directory> _appSupportDirectory;
  Future<Directory> _appLibraryDirectory;
  Future<Directory> _appDocumentsDirectory;
  Future<Directory> _externalDocumentsDirectory;
  Future<List<Directory>> _externalStorageDirectories;
  Future<List<Directory>> _externalCacheDirectories;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xffe67e22),
          title: Text(
            'Gallery',
            style: TextStyle(color: Colors.white, fontFamily: 'Bold'),
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            labelPadding: EdgeInsets.only(bottom: 15),
            tabs: <Widget>[
              Text(
                'Images',
                style: TextStyle(
                    color: Colors.white, fontSize: 18, fontFamily: 'Medium'),
              ),
              Text(
                'Videos',
                style: TextStyle(
                    color: Colors.white, fontSize: 18, fontFamily: 'Medium'),
              ),
              Text(
                'Audios',
                style: TextStyle(
                    color: Colors.white, fontSize: 18, fontFamily: 'Medium'),
              ),
              Text(
                'Files',
                style: TextStyle(
                    color: Colors.white, fontSize: 18, fontFamily: 'Medium'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Photo(),
            Text("video"),
            Text("auido"),
            File(),
//            Images(),
//            Video(),
//            Audio(),
//            File(),
          ],
        ),
      ),
    );
  }

  void _requestAppDocumentsDirectory() {
    setState(() {
      _appDocumentsDirectory = getApplicationDocumentsDirectory();
      _appDocumentsDirectory.then((value) => print(value.path));
    });
  }

  void _requestAppSupportDirectory() {
    setState(() {
      _appSupportDirectory = getApplicationSupportDirectory();
    });
  }

  void _requestAppLibraryDirectory() {
    setState(() {
      _appLibraryDirectory = getLibraryDirectory();
    });
  }

  void _requestExternalStorageDirectory() {
    setState(() {
      _externalDocumentsDirectory = getExternalStorageDirectory();
    });
  }

  void _requestExternalStorageDirectories(StorageDirectory type) {
    setState(() {
      _externalStorageDirectories = getExternalStorageDirectories(type: type);
    });
  }

  void _requestExternalCacheDirectories() {
    setState(() {
      _externalCacheDirectories = getExternalCacheDirectories();
    });
  }
}
