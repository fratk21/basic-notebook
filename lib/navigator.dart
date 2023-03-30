import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:odev/anasayfa/anasayfa.dart';
import 'package:odev/cop/cop.dart';
import 'package:odev/not_ekle/not_ekle.dart';

class navigator_ekran extends StatefulWidget {
  final String uid;
  const navigator_ekran({Key? key, required this.uid}) : super(key: key);

  @override
  State<navigator_ekran> createState() => _navigator_ekranState();
}

class _navigator_ekranState extends State<navigator_ekran> {
  int _page = 0;
  late PageController pageController; // for tabs animation

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black,
              blurRadius: 5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            elevation: 10,
            backgroundColor: Colors.white,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: (_page == 0) ? Colors.indigo : Colors.black,
                ),
                label: 'Notlarım',
                backgroundColor: Colors.indigo,
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.delete_forever_rounded,
                    color: (_page == 1) ? Colors.indigo : Colors.black,
                  ),
                  label: 'Çöp Kutusu',
                  backgroundColor: Colors.black),
            ],
            onTap: navigationTapped,
            currentIndex: _page,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        hoverColor: Colors.black,
        hoverElevation: 50,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => notekle_ekran(
                        uid: widget.uid,
                      )));
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

List<Widget> homeScreenItems = [
  anasayfaekran(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
  cop_ekran(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
