import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:odev/giris/giris.dart';
import 'package:odev/not/postcard.dart';
import 'package:odev/not_ekle/not_ekle.dart';
import 'package:odev/servisler/auth.dart';

class cop_ekran extends StatefulWidget {
  final String uid;
  const cop_ekran({super.key, required this.uid});

  @override
  State<cop_ekran> createState() => _cop_ekranState();
}

class _cop_ekranState extends State<cop_ekran> {
  authservisi _autservisi = authservisi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: 'T',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.lightBlue,
                ),
                children: [
                  TextSpan(
                    text: 'R',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                  TextSpan(
                    text: 'A',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 30,
                    ),
                  ),
                  TextSpan(
                    text: 'S',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                  TextSpan(
                    text: 'H',
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('post')
            .where('id', isEqualTo: widget.uid)
            .where("silme", isEqualTo: false)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              child: postcard(
                snap: snapshot.data!.docs[index].data(),
              ),
            ),
          );
        },
      ),
    );
  }
}
