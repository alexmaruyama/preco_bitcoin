import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _preco = '';

  _onAtualizar() async {
    var url = 'https://blockchain.info/ticker';
    http.Response response;
    response = await http.get(url);
    Map<String, dynamic> objeto = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        _preco = (objeto['BRL']['buy']).toString();
      });
    } else {
      setState(() {
        _preco = 'Não foi possível obter';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 200,
                right: 40,
                bottom: 40,
                left: 40,
              ),
              child: Image.asset('imagens/bitcoin.png'),
            ),
            Text(
              'R\$ $_preco',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 40,
              ),
              child: RaisedButton(
                color: Colors.orange,
                onPressed: _onAtualizar,
                child: Text(
                  'Atualizar',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
