import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterrr/models/file_model.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:storage_path/storage_path.dart';
import 'package:path/path.dart' as path;
import 'package:mime_type/mime_type.dart';
import 'package:open_file/open_file.dart';

class File extends StatefulWidget {
  @override
  _FileState createState() => _FileState();
}

class _FileState extends State<File> with AutomaticKeepAliveClientMixin {
  String _openResult = 'Unknown';

  Future<void> openFile() async {
    final filePath = '/sdcard/Download/test.pdf';
    final result = await OpenFile.open(filePath);

    setState(() {
      _openResult = "type=${result.type}  message=${result.message}";
    });
  }

  Future<List> get _localPath async {
    List<String> files = [];
    var filePath = '/sdcard/Download';
    var dir = new Directory(filePath);
    dir.listSync(recursive: true, followLinks: false).forEach((element) {
//      f.mimeType = element.filePath.substring(element.filePath.lastIndexOf(".") + 1);
      files.add(element.path);
//      print(path.basename(element.path));
//      print(mime(element.path));
    });

//    final directory = await getApplicationDocumentsDirectory();

    return files;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _localPath,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
//                FileModel fileModel = FileModel.fromJson(list[index]);
                return Container(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      InkWell(
                        onTap: ()=> OpenFile.open(snapshot.data[index]),
                        // handle your onTap here
                        child: Center(
//                        child: _getFileTye(fileModel.files[0].mimeType),
                          child: _getFileTye(mime(snapshot.data[index])),
                        ),
                      ),
                      Container(
                        color: Colors.black.withOpacity(0.7),
                        height: 30,
                        width: double.infinity,
                        child: Center(
                          child: FlatButton(
                            onPressed:  ()=> OpenFile.open(snapshot.data[index]),
                            child: Text(
//                            fileModel.folderName,
                              path.basename(snapshot.data[index]),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Regular'),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  _getFileTye(String fileType) {
    switch (fileType) {
      case 'application/pdf':
        return Icon(
          Icons.picture_as_pdf,
          color: Colors.red,
          size: 68,
        );
        break;

      default:
        return Icon(
          Icons.attach_file,
          color: Colors.blue,
          size: 68,
        );
    }
  }

  @override
  bool get wantKeepAlive => true;
}
