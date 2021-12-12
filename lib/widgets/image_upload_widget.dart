import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:ylc/widgets/camera_page.dart';

class ImageUpload extends StatefulWidget {
  final Size size;
  final ValueChanged<File> onChanged;
  final String docName;

  const ImageUpload({Key key, this.size, this.onChanged, this.docName})
      : super(key: key);

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File file;

  Widget buildUploadWidget(Widget widg) {
    return Container(
      height: 100,
      margin: EdgeInsets.all(20),
      child: GestureDetector(
        onTap: () {
          openCamera(context).then(
            (value) {
              if (value != null) {
                setState(() {
                  file = value;
                  widget.onChanged?.call(file);
                });
              }
            },
          );
        },
        child: DottedBorder(
          dashPattern: [8],
          strokeCap: StrokeCap.round,
          borderType: BorderType.RRect,
          radius: Radius.circular(5),
          color: Colors.blue,
          strokeWidth: 2,
          child: Center(
            child: Padding(padding: const EdgeInsets.all(10), child: widg),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Stack(
        children: [
          Center(
            child: file != null
                ? buildUploadWidget(
                    Image.file(
                      file,
                      width: widget.size.width,
                    ),
                  )
                : buildUploadWidget(ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.add,
                        size: 32,
                      ),
                    ),
                    title: Text('Upload ${widget.docName}'),
                  )),
          ),
          Align(
            alignment: Alignment.topRight,
            child: file != null
                ? Container(
                    margin: EdgeInsets.all(10),
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          file = null;
                        });
                      },
                    ),
                  )
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
