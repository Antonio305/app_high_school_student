import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/login_services.dart';
import '../model/login.dart';
import '../provider/login_form_provider.dart';

import 'dart:io';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final load = LoginServices();
    // // load.loginUser();

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        // child: Container(
        //   decoration: BoxDecoration(
        //       border: Border.all(color: Colors.white10, width: 0.3)),
        //   // color: Colors.white,
        //   width: Platform.isAndroid || Platform.isIOS
        //       ? size.width
        //       : size.width / 3,
        //   height: size.height,
        child: _Form(size: size),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  final Size size;

  const _Form({Key? key, required this.size}) : super(key: key);

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final _formKey = GlobalKey<FormState>();

  String user = '';
  String password = '';

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userController.text = user;
    passwordController.text = password;
  }

  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // instancia de la clasep para la validacio de los datos.

    final loginFormProvider = Provider.of<LoginFormProvider>(context);
    // final loginServices = Provider.of<LoginFormProvider>(context);

    // controlador para los texto

    return Container(
      width: Platform.isWindows || Platform.isMacOS
          ? widget.size.width * 0.4
          : widget.size.width * 0.83,
      child: Form(
          key: loginFormProvider.formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),

                  // image
                  const Text('Preparatoria', style: TextStyle(fontSize: 18)),

                  const Text('Rafael Pascacio Gamboa',
                      style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: widget.size.width * 0.35,
                      height: widget.size.height * 0.2,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset('asset/prepa_logo.png')),
                    ),
                  ),
                  //  user
                  // password
                  SizedBox(
                    height: widget.size.height * 0.04,
                  ),
                  const Text('Login'),
                  SizedBox(
                    height: widget.size.height * 0.04,
                  ),

                  SizedBox(
                    // height: 65,
                    // width: 310,
                    child: TextFormField(
                      initialValue: user,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'INGRESA LA MATRICULA';
                        }
                      },
                      onChanged: (String value) {
                        user = value;
                        setState(() {});
                      },
                      onSaved: (String? value) {
                        user = value!;
                      },
                      decoration: InputDecoration(
                        hintText: 'Ingrese nombre de usuario',
                        prefixIcon: const Icon(Icons.person),
                        labelText: 'Matricula',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    // width: 310,
                    height: 65,
                    child: TextFormField(
                      initialValue: password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'INGRESA LA CONTRASEÑA';
                        }
                      },
                      onChanged: (String value) {
                        password = value;
                        setState(() {});
                      },
                      onSaved: (String? value) {
                        password = value!;
                      },
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        hintText: 'Ingrese contraseña',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                        // border: BorderRadius.circular(5),
                        // hintText: 'Hola',  se  queda dentro del caja de texto
                        labelText: 'Contraseña',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'search_tuition');
                          },
                          child: const Text('CREAR CUENTA',
                              style: TextStyle(fontSize: 13)))),
                  const SizedBox(
                    height: 65,
                  ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                        onPressed: loginFormProvider.isLoading
                            ? null
                            : () async {
                                // validacio ndel formulario
                                if (!loginFormProvider.isValidate()) return;

                                final loginServices = LoginServices();

                                final login =
                                    LoginUser(user: user, password: password);

                                final String? loginError =
                                    await loginServices.loginUser(login);
                                // // loginFormProvider.isLoading = false;
                                //
                                if (loginError == null) {
                                  // Navigator.pushNamed(context, 'home');

                                  Navigator.pushReplacementNamed(
                                      context, 'check_auth_screen');

                                  // hacemos la llamda de los datos de perfil

                                } else {
                                  // cason contrario mostramos el error

                                  print("MOSTRANDO EL ERROR" + loginError);
                                  _mostrarMensajeError(loginError);
                                }
                              },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: Text('INICIAR SESION'),
                        )),
                  ),
                  const SizedBox(height: 109)
                ],
              ),
            ),
          )),
    );
  }

  void _mostrarMensajeError(String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error de inicio de sesion'),
          content: Text(mensaje),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
