import 'package:flutter/material.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';

class RespuestaCreditoPage extends StatefulWidget {
  RespuestaCreditoPage({Key key}) : super(key: key);

  _RespuestaCreditoPageState createState() => _RespuestaCreditoPageState();
}

class _RespuestaCreditoPageState extends State<RespuestaCreditoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
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
            'Solicita',
            style: TextStyle(
              color: pfazul2,
              fontSize: 19.0,
              fontWeight: FontWeight.w900,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SE TE NOTIFICARÁ CUANDO SE AUTORICE',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 50.0, color: Colors.grey),
            ),
            SizedBox(
              height: 25.0,
            ),
            Icon(
              Icons.notifications,
              color: Colors.grey,
              size: 80,
            ),
            SizedBox(
              height: 10.0,
            ),
            _goIiniio(context),
          ],
        ),
      ),
    );
  }

  Widget _goIiniio(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      width: _screenSize.width * .7,
      height: _screenSize.height * .07,
      child: RaisedButton(
          elevation: 5.0,
          onPressed: () async {
            Navigator.pop(context);
          },
          padding: EdgeInsets.all(5.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: pfazul2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'CONTINUAR',
                style: TextStyle(
                  //color: Color(0xFFFF960A),
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat',
                ),
              )
            ],
          )),
    );
  }
}
