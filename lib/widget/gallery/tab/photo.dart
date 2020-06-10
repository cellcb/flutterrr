import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

class Photo extends StatefulWidget {
  @override
  _PhotoState createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  int _currentIndex = 0;

  @override
  void initState() {
    Directory('/sdcard/Pictures')
        .listSync(recursive: true, followLinks: false)
        .forEach((element) {
      listaPagine.add(element.path);
    });
//    picDir
//        .list(recursive: true, followLinks: false)
//        .listen((FileSystemEntity entity) {
//      print(entity.path);
//      listaPagine.add(entity.path);
//    });
  }

  List<String> listaPagine = [];

//  final List<String> listaPagine = [
////    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1572156794767&di=be526a0b54ee46d946d3250a7968a6f7&imgtype=0&src=http%3A%2F%2Fi0.hdslb.com%2Fbfs%2Farticle%2Fbdcfa6f72cf1bbfd324b84f5777e6848b2d2be4e.jpg',
////    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1572156824160&di=c205e84c76495370233a593da91dcda7&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn10116%2F48%2Fw551h297%2F20190314%2F946d-hufnxfn4009298.jpg',
////    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1572751557&di=50401b19d4db5efa4168350720ef6ad2&imgtype=jpg&er=1&src=http%3A%2F%2Fpics4.baidu.com%2Ffeed%2Fa50f4bfbfbedab64dee455dd9827d4c779311e2a.png%3Ftoken%3D5134b72012d51c515324de0976a8efdc%26amp%3Bs%3DCB9C578454135FC20494D9DD0300C0B1',
////    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1572158959381&di=d35bfaae98371e5188aa793ca4f946c4&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201811%2F17%2F20181117182732_vkiak.jpg'
//  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text('# $_currentIndex'),
//      ),
      body: PhotoViewGallery.builder(
        itemCount: listaPagine.length,
        builder: (BuildContext context, int index) {
          String myImg = listaPagine[index];
          return PhotoViewGalleryPageOptions(
            imageProvider: FileImage(File(myImg)),
          );
        },
        scrollDirection: Axis.vertical,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
