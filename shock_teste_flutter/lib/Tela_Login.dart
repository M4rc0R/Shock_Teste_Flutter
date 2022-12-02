import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final _controleUsuario = TextEditingController();
  final _controleSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 6, 46, 53),
      body: Padding(
        padding: EdgeInsets.all(35),

        //Inicio da configuração do formulário

        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Label e validação de Usuário

              TextFormField(
                controller: _controleUsuario,
                autofocus: true,
                keyboardType: TextInputType.text,
                style: new TextStyle(color: Colors.white, fontSize: 20),
                decoration: InputDecoration(
                    labelText: 'Usuário',
                    labelStyle: TextStyle(color: Colors.white)),

                //Validar se o campo está vazio ou não

                validator: (usuario) {
                  if (usuario == null || usuario.isEmpty) {
                    return 'Digite seu usuário';
                  }

                  return null;
                },
              ),

              Divider(),

              //Label e validação da senha

              TextFormField(
                controller: _controleSenha,
                autofocus: true,
                obscureText: true,
                keyboardType: TextInputType.text,
                style: new TextStyle(color: Colors.white, fontSize: 20),
                decoration: InputDecoration(
                    labelText: 'Senha',
                    labelStyle: TextStyle(color: Colors.white)),

                //Validar se o campo está vazio ou não

                validator: (senha) {
                  if (senha == null || senha.isEmpty) {
                    return 'Digite sua senha';
                  }

                  return null;
                },
              ),

              Divider(),

              //Botão "Entrar" - Faz a validação dos campos preenchidos e chama a função
              //que valida se Usuário e senha batem com a API

              ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    Logar();
                  }
                },
                child: Text('Entrar'),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Função que chama a API

  Future Logar() async {
    // Faz o mapeamento dos campos inseridos (User e Senha) e converte em Json

    Map user = {"user": _controleUsuario.text, "senha": _controleSenha.text};
    var url = Uri.parse("http://127.0.0.1:5000/ValidaLogin");
    var body = jsonEncode(user);

    // Recebendo o a mensagem do campo STATUS da API

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    var status = jsonDecode(response.body)['status'];

    // Logica do login: se a resposta do Status da API for "Logado", sobe um
    //popup com a mensagem "Logado com sucesso" e utiliza o Navigator para
    // fazer a transição para a tela "Bem-Vindo";

    if (status == "logado") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 18, 255, 57),
          content: Text('Logado com sucesso!'),
          behavior: SnackBarBehavior.floating));

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => BemVindo()));
    }

    //Logica do login: se a resposta do Status da API for "user ou senha invalidos", sobe um
    //popup com a mensagem "Usuário ou senha invalidos".

    if (status == "invalido") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 255, 232, 20),
          content: Text('Usuário ou senha invalidos'),
          behavior: SnackBarBehavior.floating));
    }

    //Logica do login: se o APP não conseguir se comunicar com a API, sobe um
    //popup com a mensagem "Servidor indisponivel".

    if (response.statusCode != 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 255, 17, 28),
          content: Text('Servidor indisponivel'),
          behavior: SnackBarBehavior.floating));
    }
  }
}
