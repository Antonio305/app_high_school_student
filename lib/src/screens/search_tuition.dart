import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prepa_estudiantes/services/tuition_services.dart';
import 'package:prepa_estudiantes/src/model/tuition.dart';
import 'package:prepa_estudiantes/src/widgets/cardTask_qualifield.dart';
import 'package:prepa_estudiantes/src/widgets/text_fields.dart';

class SearchTuition extends StatefulWidget {
  const SearchTuition({Key? key}) : super(key: key);

  @override
  State<SearchTuition> createState() => _SearchTuitionState();
}

class _SearchTuitionState extends State<SearchTuition> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController textTuition = TextEditingController();
  String tuition = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tuition = textTuition.text;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final tuitionServices = Provider.of<TuitionServices>(context);

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Buscar Matricula'),
      // ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 120,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(children: [
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: size.width * 0.35,
                        height: size.height * 0.2,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset('asset/prepa_logo.png')),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text('INGRESA SU MATRICULA'),
                    const SizedBox(
                      height: 50,
                    ),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SizedBox(
                          width: 250,
                          child: TextFormField(
                            controller: textTuition,
                            autocorrect: true,
                            decoration: InputDecorations.authDecoration(
                                hintText: 'Ingresa', labelText: 'Ingresa'),
                            onChanged: (value) {
                              tuition = value;
                              setState(() {});
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'INGRESA TU MATRICULA';
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            Map<String, dynamic> respBody =
                                await tuitionServices.getTuitionName(tuition);
                            if (respBody.containsKey('msg')) {
                              _mostrarMensajeError(respBody['msg']);

                              return null;
                            }
                            _mostrarMensajeData(respBody);
                          }
                        },
                        child: tuitionServices.status == true
                            ? const CircularProgressIndicator()
                            : const Text('BUSCAR')),
                  ]),
                ),
              ),
            ),
            const SizedBox(
              height: 200,
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarMensajeError(String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(''),
          content: Text(mensaje),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
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

  void _mostrarMensajeData(Map<String, dynamic> respBody) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final tServices = Provider.of<TuitionServices>(context, listen: false);
        return AlertDialog(
          title: const Text('Numeor '),
          content: SizedBox(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Numero de control: ' + tServices.tuition.tuition),
                Text('Registrado por: ' +
                    tServices.tuition.user.name +
                    tServices.tuition.user.lastName +
                    tServices.tuition.user.secondName)
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Crear cuenta'),
              onPressed: () {
                // Navigator.of(context).pop();
                Navigator.pushNamed(context, 'create_count',
                    arguments: tServices.tuition.tuition);
              },
            ),
            ElevatedButton(
              child: const Text('Salir'),
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
