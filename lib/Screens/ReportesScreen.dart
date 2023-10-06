import 'package:flutter/material.dart';

class ReportesScreen extends StatelessWidget {
  //const ReportesScreen({super.key});
  List<String> empresas;
  List<int> ventas;
  ReportesScreen({super.key, required this.empresas, required this.ventas});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reporte'),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columns: [
              DataColumn(label: Text('Empresa')),
              DataColumn(label: Text('Ventas')),
            ],
            rows: empresas.asMap().entries.map((registro) {
              final int indice = registro.key;
              return DataRow(
                cells: [
                  DataCell(Text(registro.value)),
                  DataCell(Text(ventas[indice].toString())),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
