import 'dart:math';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:odev/navigator.dart';
import 'package:odev/not/not.dart';
import 'package:odev/servisler/auth.dart';

class postcard extends StatefulWidget {
  final snap;
  const postcard({
    super.key,
    required this.snap,
  });

  @override
  State<postcard> createState() => _postcardState();
}

class _postcardState extends State<postcard> {
  authservisi _auth = authservisi();
  deletePost(String postId) async {
    try {
      await _auth.deletePost(postId);
    } catch (err) {}
  }

  movepost(String postId, int durum) async {
    try {
      await _auth.movepost(postId, durum);
    } catch (err) {}
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => notekran(
                      notadi: widget.snap['notadi'],
                      not: widget.snap['not'],
                      saat: widget.snap['saat'],
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Container(
            // boundary needed for web
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Column(
              children: [
                // HEADER SECTION OF THE POST
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ).copyWith(right: 0),
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 0,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          widget.snap["silme"] == false
                                              ? showDialog(
                                                  useRootNavigator: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return Dialog(
                                                      child: ListView(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 16),
                                                          shrinkWrap: true,
                                                          children: [
                                                            "Move to my nots",
                                                          ]
                                                              .map(
                                                                (e) => InkWell(
                                                                    child:
                                                                        Container(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              12,
                                                                          horizontal:
                                                                              16),
                                                                      child:
                                                                          Text(
                                                                              e),
                                                                    ),
                                                                    onTap: () {
                                                                      if (widget
                                                                              .snap["silme"] ==
                                                                          false) {
                                                                        movepost(
                                                                            widget.snap['postId'].toString(),
                                                                            2);
                                                                        // remove the dialog box
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      }
                                                                    }),
                                                              )
                                                              .toList()),
                                                    );
                                                  },
                                                )
                                              : Container();
                                        },
                                        icon: widget.snap["silme"] == true
                                            ? Container()
                                            : Icon(Icons.restore),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      notekran(
                                                        notadi: widget
                                                            .snap['notadi'],
                                                        not: widget.snap['not'],
                                                        saat:
                                                            widget.snap['saat'],
                                                      )));
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              140,
                                          child: Column(
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                  children: [
                                                    TextSpan(
                                                        text:
                                                            ' ${widget.snap['notadi']}',
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0),
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                  children: [
                                                    TextSpan(
                                                        text:
                                                            ' ${widget.snap['saat']}',
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                              125, 84, 84, 84),
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            useRootNavigator: false,
                                            context: context,
                                            builder: (context) {
                                              return Dialog(
                                                child: ListView(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 16),
                                                    shrinkWrap: true,
                                                    children: [
                                                      widget.snap["silme"] ==
                                                              true
                                                          ? 'Move to trash '
                                                          : "Delete",
                                                    ]
                                                        .map(
                                                          (e) => InkWell(
                                                              child: Container(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        12,
                                                                    horizontal:
                                                                        16),
                                                                child: Text(e),
                                                              ),
                                                              onTap: () {
                                                                if (widget.snap[
                                                                        "silme"] ==
                                                                    false) {
                                                                  deletePost(
                                                                    widget.snap[
                                                                            'postId']
                                                                        .toString(),
                                                                  );
                                                                  // remove the dialog box
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                } else {
                                                                  movepost(
                                                                      widget
                                                                          .snap[
                                                                              'postId']
                                                                          .toString(),
                                                                      1);
                                                                  // remove the dialog box
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                }
                                                              }),
                                                        )
                                                        .toList()),
                                              );
                                            },
                                          );
                                        },
                                        icon: widget.snap["silme"] == true
                                            ? Icon(Icons.drive_file_move)
                                            : Icon(Icons.delete_forever),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
