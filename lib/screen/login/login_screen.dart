// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/validators.dart';
import '../../models/user/user.dart';
import '../../models/user/user_manager.dart';
import '../mainpage/main_page.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  //utilizado para obter acesso aos textformfields (ex.: obter o texto)
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  //Utilizado para que possamos acessar o formulário nesta tela
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/ifmt.png',
                    height: 120,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'ClassRoom Control APP',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 40),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  //utilizado para disponibilizar o comportamento de formulário (validadores, por exemplo)
                  child: Form(
                    key: formkey,
                    //o consumer ficará observando o UserManager
                    child: Consumer<UserManager>(
                      //o child do consumer é utilizar para evitar a reconstrução de algum widget complexo/grande
                      //exemplificando com o botão esqueci minha senha
                      child: Align(
                        //o child vai utilizando onde o botão será incluiído
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          child: const Text('Esqueci minha senha'),
                          onPressed: () {},
                        ),
                      ),
                      builder: (_, userManager, child) {
                        //agora temos acesso direto ao usermanager
                        return ListView(
                          padding: const EdgeInsets.all(16),
                          shrinkWrap:
                              true, //define que ocupe a menor altura na tels
                          children: <Widget>[
                            TextFormField(
                              controller: emailController,
                              enabled: !userManager.loading,
                              decoration:
                                  const InputDecoration(hintText: 'E-mail'),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              validator: (email) {
                                //um validador deve ser chamando no Form
                                if (!emailValidator(email!)) {
                                  return 'E-mail inválido!!!';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: passwordController,
                              enabled: !userManager.loading,
                              decoration:
                                  const InputDecoration(hintText: 'Senha'),
                              autocorrect: false,
                              obscureText: true,
                              validator: (password) {
                                if (password!.isEmpty || password.length < 6) {
                                  return 'Senha inválida!!!';
                                }
                                return null;
                              },
                            ),
                            //o child aqui, representa o botão que foi indicado ao consumer para não ser reconstruído
                            child!, //objeto do consumer - é apenas um exemplo para não ser reconstruído
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: userManager.loading
                                      ? null
                                      : () {
                                          //utilizando o validador definido no FORM
                                          if (formkey.currentState!
                                              .validate()) {
                                            // context.read<UserManager>().signIn(  //AGORA PODEMOS UTILIZAR O USERMANAGER
                                            userManager.signIn(
                                                userLocal: UserLocal(
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text,
                                                ),
                                                //função de callback
                                                onFail: (e) {
                                                  ScaffoldMessenger(
                                                    child: SnackBar(
                                                      content: Text(
                                                        'Falha ao entrar: $e',
                                                        style: const TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                      backgroundColor:
                                                          Colors.red,
                                                    ),
                                                  );
                                                },
                                                //função de callback
                                                onSucess: () {
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const MainPage(),
                                                    ),
                                                  );
                                                });
                                          }
                                        },
                                  child: userManager.loading
                                      ? const CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.white),
                                        )
                                      : const Text(
                                          'Entrar',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => SignUpScreen()),
                                    );
                                  },
                                  child: const Text(
                                    'Registrar',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
