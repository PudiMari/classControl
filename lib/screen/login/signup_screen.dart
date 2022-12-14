
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/validators.dart';
import '../../models/user/user.dart';
import '../../models/user/user_manager.dart';

class SignUpScreen extends StatelessWidget {
  //Utilizado para que possamos acessar o formulário nesta tela
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final UserLocal user = UserLocal();

  SignUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Criar Conta de Usuário'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formkey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'Nome completo'),
                      enabled: !userManager.loading,
                      validator: (name) {
                        if (name!.isEmpty) {
                          return 'Campo obrigatório!!!';
                        } else if (name.trim().split(' ').length <= 1) {
                          return 'Preencha seu nome completo';
                        }
                        return null;
                      },
                      //evita o uso de controladores
                      onSaved: (name) => user.name = name,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Email'),
                      enabled: !userManager.loading,
                      keyboardType: TextInputType.emailAddress,
                      validator: (email) {
                        if (email!.isEmpty) {
                          return 'Campo obrigatório!!!';
                        } else if (!emailValidator(email)) {
                          return 'E-mail inválido!!!';
                        }
                        return null;
                      },
                      onSaved: (email) =>
                          user.email = email, //salva no email diretamennte
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Senha'),
                      enabled: !userManager.loading,
                      obscureText: true,
                      validator: (password) {
                        if (password!.isEmpty) {
                          return 'Campo obrigatório!!!';
                        } else if (password.length < 6) {
                          return 'Senha deve ter ao menos 6 caracteres!!!';
                        }
                        return null;
                      },
                      onSaved: (password) => user.password = password,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'Repita a senha'),
                      enabled: !userManager.loading,
                      obscureText: true,
                      validator: (password) {
                        if (password!.isEmpty) {
                          return 'Campo obrigatório!!!';
                        } else if (password.length < 6) {
                          return 'Senha deve ter ao menos 6 caracteres!!!';
                        }
                        return null;
                      },
                      onSaved: (password) => user.confirmPassword = password,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: userManager.loading
                          ? null
                          : () {
                              if (formkey.currentState!.validate()) {
                                //chama o método onSave de cada um dos formsfield
                                //os campos deveram ter onsaved habilitado00
                                formkey.currentState!.save();
                                if (user.password != user.confirmPassword) {
                                  const ScaffoldMessenger(
                                    child: SnackBar(
                                      content: Text(
                                        'Senhas não coincidem!!!',
                                        style: TextStyle(fontSize: 11),
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }
                                userManager.signUp(
                                  userLocal: user,
                                  onSucess: () {
                                    Navigator.of(context).pop();
                                  },
                                  onFail: (e) {
                                    ScaffoldMessenger(
                                      child: SnackBar(
                                        content: Text(
                                          'Falha ao registrar usuário: $e',
                                          style: const TextStyle(fontSize: 11),
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                      child: userManager.loading
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            )
                          : const Text(
                              'Criar conta',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
