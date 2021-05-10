import 'package:dineroenunclick/src/models/UsuarioModel.dart';
import 'package:dineroenunclick/src/pages/CreditosPage.dart';
import 'package:dineroenunclick/src/pages/FormNuevosCreditosPage.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dineroenunclick/src/pages/PinPage.dart';
import 'package:dineroenunclick/src/pages/NotificacionesPage.dart';
import 'package:dineroenunclick/src/pages/PerfilPage.dart';

class ClientePage extends StatefulWidget {
  ClientePage({Key key}) : super(key: key);

  _ClientePageState createState() => _ClientePageState();
}

Widget _creditoElemento(BuildContext context, solicitud, monto) {
  return GestureDetector(
    onTap: () {
      print(monto);
      Navigator.pushNamed(context, '/credito');
    },
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        width: (double.infinity) * .7,
        color: Color(0xFFffffff),
        child: ListTile(
          leading: Icon(Icons.credit_card),
          title: Text(solicitud,
              style: TextStyle(
                color: Color(0xFF000000),
                fontWeight: FontWeight.normal,
              )),
          subtitle: Text(monto),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    ),
  );
}

class _ClientePageState extends State<ClientePage> {
  int _currentPage = 0;
  bool userStatus = Usuario.usr.clientePF;
  String pantallaPrincipal = Usuario.usr.pantallaPrincipal;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget _loadPage(int page) {
    if (userStatus) {
      if (pantallaPrincipal == 'Solicita') {
        switch (page) {
          case 0:
            return CreditosPage();
          case 1:
            return PinPage();
          case 2:
            return NotificacionesPage();
          default:
            return CreditosPage();
        }
      } else if (pantallaPrincipal == 'PIN') {
        switch (page) {
          case 0:
            return CreditosPage();
          case 1:
            return PinPage();
          case 2:
            return NotificacionesPage();
          default:
            return CreditosPage();
        }
      }
    } else {
      switch (page) {
        case 0:
         return FormNuevosCreditos();
        case 1:
         return PinPage();
        case 2:
          return NotificacionesPage();
        default:
          return CreditosPage();
      }
    }
  }

  Widget _buildNavigationBar() {
    if (userStatus) {
      if (pantallaPrincipal == 'Solicita') {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: pfazul2,
          currentIndex: _currentPage,
          onTap: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.attach_money), label: 'Solicita'),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_on), label: 'Ofertas PiN'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'Notificaciones'),
          ],
        );
      } else if (pantallaPrincipal == 'PIN') {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: pfazul2,
          currentIndex: _currentPage,
          onTap: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.attach_money), label: 'Solicita'),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_on), label: 'Ofertas PiN'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'Notificaciones'),
          ],
        );
      }
    } else {
      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: pfazul2,
        currentIndex: _currentPage,
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money), label: 'Solicita'),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on), label: 'Ofertas PiN'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notificaciones'),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 500),
        child: SizedBox(
          height: 35.0,
        ),
      ),
      bottomNavigationBar: _buildNavigationBar(),
      body: _loadPage(_currentPage),
    );
  }
}