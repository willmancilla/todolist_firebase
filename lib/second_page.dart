import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SegundaPagina extends StatefulWidget {
  SegundaPagina({Key? key}) : super(key: key);

  @override
  State<SegundaPagina> createState() => _SegundaPaginaState();
}

class _SegundaPaginaState extends State<SegundaPagina> {
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _controller = TextEditingController();
  FirebaseDatabase database = FirebaseDatabase.instance;
  late DatabaseReference ref;

  @override
  void initState() {
    // ignore: deprecated_member_use
    ref = database.reference();
    ref.onValue.listen((event) {
      if (event.snapshot.value == null) {
        return;
      }
    });
    super.initState();
  }

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
                padding: const EdgeInsets.all(10),
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
                onPressed: () async {
                  await ref.child('List').push().set({
                    'Task': _controller.text,
                  });
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
