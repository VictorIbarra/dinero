import 'package:dineroenunclick/src/models/UsuarioModel.dart';
import 'package:dineroenunclick/src/providers/AyudaProvider.dart';
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
              color: pfazul2,
              fontSize: 19.0,
              fontWeight: FontWeight.w900,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      ),
      body: Container(
          padding: EdgeInsets.only(left: 15.0, top: 40.0), child: _loadData()),
    );
  }

  Widget _loadData() {
    return FutureBuilder(
      future: AyudaProvider.emailphone(Usuario.usr.clienteId),
      builder: (BuildContext context, AsyncSnapshot<AyudaResponse> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Correo',
                  style: TextStyle(color: pfazul2, fontSize: 30.0),
                ),
                _email(snapshot.data)
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
                  style: TextStyle(color: pfazul2, fontSize: 30.0),
                ),
                _phone(snapshot.data)
              ],
            )
          ],
        );
      },
    );
  }

  Widget _email(AyudaResponse res) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.email,
          color: pfazul2,
        ),
        FlatButton(
            onPressed: () {
              setState(() {
                if (res.data?.first?.email != null) {
                  _customLaunch(
                      'mailto:${res.data.first.email}?subject=test%20subject&body=test%20body');
                  _makeCall(
                      'mailto:${res.data.first.email}?subject=test%20subject&body=test%20body');
                }
              });
            },
            child: Text(
              res.data?.first?.email ?? 'hola@prestamofeliz.com.mx',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10.0, color: Colors.black),
            ))
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

  Widget _phone(AyudaResponse res) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.phone,
          color: pfazul2,
        ),
        FlatButton(
          onPressed: () {
            setState(() {
              if (res.data?.first?.telefono != null) {
                final tel = res.data.first.telefono.split('-').join('');
                _makeCall('tel:$tel');
              }
            });
          },
          child: Text(
            res.data?.first?.telefono ?? '800 3354 915',
            textAlign: TextAlign.center,
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
