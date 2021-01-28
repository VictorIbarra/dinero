import 'package:flutter/material.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';

class AyudaPage extends StatefulWidget {
  AyudaPage({Key key}) : super(key: key);

  _AyudaPageState createState() => _AyudaPageState();
}

class _AyudaPageState extends State<AyudaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        //automaticallyImplyLeading: false,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: pfVerde,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        actions: <Widget>[
          Icon(
            Icons.arrow_back_ios,
          ),
          Icon(
            Icons.arrow_back_ios,
          ),
        ],
        title: Center(
          child: Text(
            'Centro de Ayuda',
            style: TextStyle(
              color: pfGris,
              fontSize: 15.0,
              fontWeight: FontWeight.w900,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.email,
                  color: Colors.blue,
                  size: 30.0,
                ),
                _email(),
              ],
            ),
            SizedBox(
              height: 25.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.call,
                  color: Colors.blue,
                  size: 30.0,
                ),
                _phone(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _email() {
    return Row(
      children: [
        Icon(Icons.email),
        FlatButton(
          onPressed: () {
            setState(() {
              _customLaunch(
                  'mailto:atencionusuarios@prestamofeliz.com.mx?subject=test%20subject&body=test%20body');
              _makeCall(
                  'mailto:atencionusuarios@prestamofeliz.com.mx?subject=test%20subject&body=test%20body');
            });
          },
          padding: EdgeInsets.only(right: 0.0),
          child: Text(
            'atencionusuarios@prestamofeliz.com.mx',
            style: TextStyle(fontSize: 15.0, color: Colors.black),
          ),
        ),
      ],
    );
  }

  void _customLaunch(comand) async {
    if (await canLaunch(comand)) {
      await launch(comand);
    } else {
      print('');
    }
  }

  Widget _phone() {
    return Row(
      children: [
        Icon(Icons.phone),
        FlatButton(
          onPressed: () {
            setState(() {
              _makeCall('tel:83904379');
            });
          },
          padding: EdgeInsets.only(right: 0.0),
          child: Text(
            '               83904379',
            style: TextStyle(fontSize: 20.0, color: Colors.black),
          ),
        ),
      ],
    );
  }

  void _makeCall(String number) async {
    if (await UrlLauncher.canLaunch(number)) {
      await UrlLauncher.launch(number);
    } else {
      throw 'could not launch';
    }
  }
}
