import 'package:dineroenunclick/src/pages/CreditosPage.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:dineroenunclick/src/pages/SolicitaPage.dart';
import 'package:dineroenunclick/src/pages/PinPage.dart';
import 'package:dineroenunclick/src/pages/NotificacionesPage.dart';
import 'package:dineroenunclick/src/pages/PerfilPage.dart';

class ClientePage extends StatefulWidget {
  ClientePage({Key key}) : super(key: key);

  _ClientePageState createState() => _ClientePageState();
}

Widget _creditoElemento(BuildContext context, solicitud, monto ){

  
  return GestureDetector(
    onTap: (){
      print(monto);
      Navigator.pushNamed(context, '/credito');

    },
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        //padding: EdgeInsets.all(10.0),
        width: (double.infinity)*.7,
        //height: _screenSize.height * .15,
        color: Color(0xFFffffff),
        child: ListTile(
          leading: Icon(Icons.credit_card),
          title: Text(solicitud, style: TextStyle(color: Color(0xFF000000), fontWeight: FontWeight.normal,)),
          subtitle: Text(monto),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    ),
  );

}

class _ClientePageState extends State<ClientePage> {

  int _currentPage = 0;

  //listC.add(new Cliente(id: 1, nombre: 'HEB', direccion: 'Jabones al 50%', mora: '-', latitud: 25.7382688, longitud: -100.3026886));

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget _loadPage(int page){

    switch(page){
      case 0: return CreditosPage();
      case 1: return PinPage();
      //case 1: return PageStorage(child: PinPage(key: PageStorageKey('PagePiN')), bucket: PageStorageBucket(),);
      case 2: return NotificacionesPage();
      case 3: return PerfilPage();//MovimientosPage();
      default: return CreditosPage();
    }
  }

  Widget _buildNavigationBar(){
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: pfazul2,
      //iconSize: 30.0,
      //showSelectedLabels: false,
      //showUnselectedLabels: false,
      currentIndex: _currentPage,
      onTap: (index){
        setState(() {
          _currentPage = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money),
          title: Text('Solicita')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on),
          title: Text('Ofertas PiN')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          title: Text('Notificaciones')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          title: Text('Perfil')
        ),
      ],

    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 500),
        child: SizedBox(height: 35.0,),
      ),
      bottomNavigationBar: _buildNavigationBar(),
      body: _loadPage(_currentPage),
    );
  
  }
}
