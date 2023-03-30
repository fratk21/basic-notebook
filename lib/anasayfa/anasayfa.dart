import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:odev/giris/giris.dart';
import 'package:odev/not/postcard.dart';
import 'package:odev/not_ekle/not_ekle.dart';
import 'package:odev/servisler/auth.dart';

class anasayfaekran extends StatefulWidget {
  final String uid;
  const anasayfaekran({super.key, required this.uid});

  @override
  State<anasayfaekran> createState() => _anasayfaekranState();
}

class _anasayfaekranState extends State<anasayfaekran> {
  authservisi _autservisi = authservisi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: 'M',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.lightBlue,
                ),
                children: [
                  TextSpan(
                    text: 'Y',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                  TextSpan(
                    text: ' N',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 30,
                    ),
                  ),
                  TextSpan(
                    text: 'O',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                  TextSpan(
                    text: 'T',
                    style: TextStyle(
                      color: Colors.lightBlue,
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
                ],
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
              color: Colors.black,
              onPressed: () {
                _autservisi.cikis();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => girisekran()));
              },
              icon: Icon(Icons.output))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('post')
            .where('id', isEqualTo: widget.uid)
            .where("silme", isEqualTo: true)
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
