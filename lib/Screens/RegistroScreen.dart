import 'package:flutter/material.dart';
import 'package:prueba/Screens/AlmacenesScreen.dart';

class RegistroScreen extends StatelessWidget {
  List<String> empresas;
  // Listado de todas las ventas para buscar los almacenes de cada empresa
  List<dynamic> RegistroCompleto;

//Metodo para contar la lista de almacenes de una empresa
//Ingresar como parametro el nombre de la empresa
//Devuelve un arreglo con los almacenes de la empresa
  List<String> _ListaAlmacenes(String nombreEmpresa) {
    List<String> listaAlmacenes = [];
    RegistroCompleto.forEach((element) {
      if (nombreEmpresa == element["nombre"]) {
        // Preguntar si el almacen ya está en el registro para no repetir valores
        if (!listaAlmacenes.contains(element["almacen"])) {
          listaAlmacenes.add(element["almacen"]);
        }
      }
    });
    print(listaAlmacenes);
    return listaAlmacenes;
  }

  RegistroScreen(
      {super.key, required this.empresas, required this.RegistroCompleto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Concesionarios'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: empresas.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Manejar el evento de clic aquí
                //print('Elemento seleccionado: ${empresas[index]}');

                Navigator.push(
                  // El pushnamed dió demasiados problemas, mejor usar push
                  context,
                  MaterialPageRoute(
                    builder: (context) => AlmacenesScreen(
                        empresa: empresas[index],
                        almacenes: _ListaAlmacenes(empresas[index])),
                  ),
                );
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                color: Color(0xFFFFE4E1), // Color de resaltado
                child: ListTile(
                  title: Text(empresas[index]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
