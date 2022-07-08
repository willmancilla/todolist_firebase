import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const PrimeiraPagina(),
        '/segunda': (context) => SegundaPagina(),
      },
    );
  }
}

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
            setState(() {
              nomes.add(resposta);
            });
          }
        },
      ),
    );
  }
}

class SegundaPagina extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _controller = TextEditingController();

  SegundaPagina({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Informe a tarefa abaixo: ', 
                style: TextStyle(fontSize: 18),
                ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo Obrigatório';
                    }

                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  bool validado = _formKey.currentState?.validate() ?? false;
                  if (validado) {
                    Navigator.of(context).pop(
                      _controller.text,
                    );
                  }
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}