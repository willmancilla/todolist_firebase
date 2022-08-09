import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class PrimeiraPagina extends StatefulWidget {
  const PrimeiraPagina({Key? key}) : super(key: key);

  @override
  State<PrimeiraPagina> createState() => _PrimeiraPaginaState();
}

class _PrimeiraPaginaState extends State<PrimeiraPagina> {
  List<String> nomes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: nomes.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text('${index + 1} - ${nomes[index]}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adicionar tarefa',
        child: const Icon(Icons.add),
        onPressed: () async {
          String? resposta = await Navigator.of(context).pushNamed(
            '/segunda',
          ) as String?;

          if (resposta != null) {
            FirebaseAnalytics.instance.logEvent(name: 'tarefa_adicionada');
            setState(() {
              nomes.add(resposta);
            });
          }
        },
      ),
    );
  }
}
