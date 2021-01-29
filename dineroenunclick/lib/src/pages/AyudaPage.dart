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
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: pfAzul,
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
              color: pfAzul,
              fontSize: 19.0,
              fontWeight: FontWeight.w900,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15.0, top: 40.0),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Correo',
                  style: TextStyle(color: Colors.blue[900], fontSize: 30.0),
                ),
                _email(),
              ],
            ),
            SizedBox(
              height: 25.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Telefono',
                  style: TextStyle(color: Colors.blue[900], fontSize: 30.0),
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
            '    atencionusuarios@prestamofeliz.com.mx',
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
            '                       83904379',
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
