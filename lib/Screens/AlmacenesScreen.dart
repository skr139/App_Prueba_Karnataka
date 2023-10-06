import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AlmacenesScreen extends StatelessWidget {
  //const ReportesScreen({super.key});

  //Metodo POST *******************
  _postData(String empresa, String almacen, int accion) async {
    Uri url = Uri.parse("http://localhost:8080/ventas/");
    String fecha = DateTime.now().toString().substring(0, 11);
    print(fecha);
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'fecha': fecha,
        'almacen': almacen,
        'cantidad': accion,
        'nombre': empresa,
      }),
    );
  }

  List<String> almacenes; // Lista de almacenes de la empresa
  String empresa; // Nombre de la empresa
  AlmacenesScreen({super.key, required this.empresa, required this.almacenes});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vitrinas del concesionario'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: almacenes.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                    title: const Text("Ventas"),
                    contentPadding: const EdgeInsets.all(20.0),
                    children: [
                      TextButton(
                          onPressed: () async {
                            print("Se presiono Vendes");
                            _postData(empresa, almacenes[index], 1);
                            Navigator.pop(context);
                            AlertDialog alert = AlertDialog(
                              title: Text("Venta satisfactoria!"),
                              content: Text(
                                  "Se ha realizado una nueva venta al concesionario ${almacenes[index]}"),
                            );
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          },
                          child: Text("Nueva venta")),
                      TextButton(
                          onPressed: () {
                            print("Se presiono devolucion");
                            Navigator.pop(context);
                            AlertDialog alert = AlertDialog(
                              title: Text("Devolución!"),
                              content: Text(
                                  "Se ha realizado una nueva nota de credito al concesionario ${almacenes[index]}"),
                            );
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          },
                          child: Text("Devolución")),
                    ],
                  ),
                );
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                color: Color(0xFFFFE4E1), // Color de resaltado
                child: ListTile(
                  title: Text(almacenes[index]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
