import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:odev/anasayfa/anasayfa.dart';
import 'package:odev/navigator.dart';
import 'package:odev/servisler/auth.dart';

import '../snackbar.dart';

class notekle_ekran extends StatefulWidget {
  final String uid;
  const notekle_ekran({super.key, required this.uid});

  @override
  State<notekle_ekran> createState() => _notekle_ekranState();
}

class _notekle_ekranState extends State<notekle_ekran> {
  authservisi _autservisi = authservisi();
  TextEditingController _not = TextEditingController();
  TextEditingController _notadi = TextEditingController();
  bool _isLoading = false;
  String? res;
  Future<void> gir() async {
    setState(() {
      _isLoading = true;
    });

    res = await _autservisi.Post(_notadi.text, _not.text);

    if (res == "succes") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => navigator_ekran(
                    uid: widget.uid,
                  )));
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, res!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              text: 'N',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.lightBlue,
              ),
              children: [
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
                    color: Colors.blue,
                    fontSize: 30,
                  ),
                ),
                TextSpan(
                  text: ' EK',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
                TextSpan(
                  text: 'LE',
                  style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
        centerTitle: false,
        actions: <Widget>[
          TextButton(
            onPressed: gir,
            child: !_isLoading
                ? const Text(
                    "Post",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  )
                : const SpinKitWave(
                    color: Colors.white,
                    size: 25.0,
                  ),
          ),
        ],
      ),
      // POST FORM
      body: Column(
        children: <Widget>[
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width - 10,
                height: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: SizedBox(
                  child: TextField(
                    controller: _notadi,
                    decoration: InputDecoration(
                        hintText: "   not adi", border: InputBorder.none),
                    maxLines: 2,
                    maxLength: 100,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width - 10,
                height: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: SizedBox(
                  child: TextField(
                    controller: _not,
                    decoration: InputDecoration(
                        hintText: "   not...", border: InputBorder.none),
                    maxLines: 50,
                    maxLength: 4000,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
