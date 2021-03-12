import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passController = TextEditingController();

  final _addressController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        if (model.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Form(
          key: _formkey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Nome Completo",
                ),
                keyboardType: TextInputType.name,
                validator: (text) {
                  if (text.isEmpty) {
                    return "Nome invalido!";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "E-mail",
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (text) {
                  if (text.isEmpty || !text.contains("@")) {
                    return "E-mail invalido!";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passController,
                decoration: InputDecoration(
                  hintText: "Senha",
                ),
                obscureText: true,
                validator: (text) {
                  if (text.isEmpty || text.length < 6) {
                    return "Senha invalida!";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  hintText: "Endereço",
                ),
                validator: (text) {
                  if (text.isEmpty) {
                    return "Endereço invalida!";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 16.0),
              SizedBox(
                height: 45,
                child: ElevatedButton(
                  child: Text(
                    "Criar Conta",
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    if (_formkey.currentState.validate()) {
                      Map<String, dynamic> userData = {
                        "name": _nameController.text,
                        "email": _emailController.text,
                        "address": _addressController.text,
                      };

                      model.signUp(
                        userData: userData,
                        pass: _passController.text,
                        onSuccess: _onSuccess,
                        onFail: _onFail,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _onSuccess() {
    final snackBar = SnackBar(
      content: Text(
        'Usuário criado com sucesso!',
      ),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    final snackBar = SnackBar(
      content: Text(
        'Falha ao criar usuário!',
      ),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
