import 'package:dineroenunclick/src/models/CreditoModel.dart';
import 'package:dineroenunclick/src/models/UsuarioModel.dart';
import 'package:dineroenunclick/src/providers/CreditoProvider.dart';
import 'package:dineroenunclick/src/widgets/SolicitaItem.dart';
import 'package:flutter/material.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';

class CreditosPage extends StatefulWidget {
  CreditosPage({Key key}) : super(key: key);
  _CreditosPageState createState() => _CreditosPageState();
}

BoxDecoration myBoxDecoration(Color color) {
  return BoxDecoration(
    border: Border.all(width: 2.0, color: Colors.grey),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  );
}

class _CreditosPageState extends State<CreditosPage> {
  Widget _loadCreditos(BuildContext context) {
    return FutureBuilder(
      future: CreditoProvider.creditosCliente(Usuario.usr.clienteId),
      builder: (BuildContext context, AsyncSnapshot<List<Credito>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.isEmpty) {
            return Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No cuentas con créditos a renovar',
                    textScaleFactor: 1.3,
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  new Image.asset(
                    'assets/13.png',
                    height: 60.0,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            );
          }
          return _drawVisitanteItems(snapshot.data, context);
        } else {
          return Container(
              height: 600.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _drawVisitanteItems(List<Credito> creditos, BuildContext context) {
    return ListView.builder(
      itemCount: creditos.length,
      itemBuilder: (BuildContext context, int index) {
        return SolicitaItem(credito: creditos[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
           actions: [
          IconButton(
            icon: Icon(
              Icons.account_circle,
              color: pfazul2,
            ),
            onPressed: () {
              setState(() {
                     Navigator.pushNamed(context, '/hola');
              });
            },
          )
        ],
        title: Center(
          child: Text(
            'Solicita',
            style: TextStyle(
              color: pfazul2,
              fontSize: 30.0,
              fontWeight: FontWeight.w900,
              fontFamily: 'Montserrat',
            ),
          ),
        )
      ),
      body: _loadCreditos(context),
    );
  }
}