import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prueba/Models/EmpresasModel.dart';
import 'package:prueba/Screens/RegistroScreen.dart';
import 'package:prueba/Screens/ReportesScreen.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prueba',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Prueba Karnataka'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Clase en donde se definen los metodos*********
class _MyHomePageState extends State<MyHomePage> {
  Uri url = Uri.parse("http://localhost:8080/ventas/");
  List<String> empresasTotal = [];
  List<int> ventasTotal = [];
  late List<dynamic> data;

  _getVentas() async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // Convertir los datos a formato JSON en data
      data = json.decode(response.body);
      data.forEach((element) {
        int? contador = 0;
        if (!empresasTotal.contains(element["nombre"])) {
          // Si la empresa no está en la lista, agregarla
          empresasTotal.add(element["nombre"]);
          data.forEach((comparar) {
            if (element["nombre"] == comparar["nombre"]) {
              contador = (contador! + comparar["cantidad"]) as int?;
            }
          });
          ventasTotal.add(contador!);
        }
      });
      print(empresasTotal.length);
      print(ventasTotal.length);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Reportes'),
              onTap: () async {
                await _getVentas();
                Navigator.push(
                  // El pushnamed dió demasiados problemas, mejor usar push
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReportesScreen(
                        empresas: empresasTotal, ventas: ventasTotal),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Registro'),
              onTap: () async {
                await _getVentas();
                Navigator.push(
                  // El pushnamed dió demasiados problemas, mejor usar push
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegistroScreen(
                      empresas: empresasTotal,
                      RegistroCompleto: data,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Principal  '),
      ),
      body: Center(child: Text("data")),
    );
  }
}
