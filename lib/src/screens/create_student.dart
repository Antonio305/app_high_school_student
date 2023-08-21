import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prepa_estudiantes/src/model/for_create_student.dart';
import 'package:prepa_estudiantes/src/widgets/text_fields.dart';

import '../../services/generation_services.dart';
import '../../services/group_services.dart';
import '../../services/semestres_services.dart';
import '../../services/student_services.dart';
import '../provider/meuOptionProvider.dart';

class FormIsWidows extends StatefulWidget {
  const FormIsWidows({Key? key}) : super(key: key);

  @override
  State<FormIsWidows> createState() => _FormIsWidowsState();
}

class _FormIsWidowsState extends State<FormIsWidows> {
  DateTime selectedDate = DateTime.now();

  StudentByResgister student = StudentByResgister(
      name: '',
      lastName: '',
      secondName: '',
      gender: '',
      dateOfBirth: DateTime.now(),
      bloodGrade: '',
      curp: '',
      age: 0,
      town: '',
      numberPhone: 0,
      email: "",
      tuition: '',
      password: '',
      status: true,
      rol: 'STUDENT',
      studentTutor: StudentTutors(
          nameTutor: '',
          lastNameTutor: '',
          secondNameTutor: '',
          kinship: '',
          numberPhoneTutor: 000),
      group: '',
      semestre: [], 
      subjects: [],
      generation: '');

  final _formKey = GlobalKey<FormState>();

  // controlador para los campos de texto...
  final numberPhoneStudent = TextEditingController();

  final numberPhoneTutor = TextEditingController();

  String? genderSelect;
  String? bloodGradeSelect;
  String? curpSelect;
  int? ageSelect;
  String? groupSelect;
  String? semestreSelect;
  // List<String>? subjectsSelect;
  String? generationSelect;

  String? kinshipSelect;

// String? semestreSelect;

  String phoneStudent = '';
  String phoneTutor = '';

  String _dropdownValue = '';

  


  // Creamos una lista de areas.
  final List<String> areas = [
    'Fisicos Matemeeticos',
    'Quimicos Biologos',
    'Ciencias Sociales',
    'Economicos Administrativos',
    'Tronco Comun'
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneStudent = numberPhoneStudent.text;
    phoneTutor = numberPhoneTutor.text;

    onLoading();
  }

// funciuon para las fechas
  _selectDate(BuildContext context) async {
    // varaible que guarda la fecha seleccionada
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1990),
      lastDate: DateTime(2050),
      // cambaira el texto de los botones
      helpText: 'Seleccionar Fecha ',
      cancelText: 'Cancelar',
      confirmText: 'Guardar',
      // locale: const Locale('es', 'MX'),
    );

    // si para una de stas condiciones actualizamos el  datos
    if (selected != null && selected != selectedDate) {
      setState(() {
        student.dateOfBirth = selected;
        selectedDate = selected;
      });
    }
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // datos iniciales de las fechas
  // // funcion now estre la fecha de hoy

  // una del os tipos de sangre
  final bloodType = <String>['A+', 'O+', 'B+', 'AB+', 'A-', 'O-', 'B-', 'AB-'];

  var parentesco = <String>[
    'HERMANO',
    'HERMANA',
    'PADRE',
    'MADRE',
    'ABUELO',
    'ABUELA',
    'TIO',
    'TIA',
  ];

  // cresmo una lsita de las

  var ageStudent = <int>[14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25];

  @override
  Widget build(BuildContext context) {
    var gender = <String>['FEMENINO', 'MASCULINO', 'OTRO'];
    // String dropButtonValue =  gender.first;
    // hacemos la instancia de provider
    final dropMenuProvider = Provider.of<MenuOptionProvider>(context);
    final groupServices = Provider.of<GroupServices>(context, listen: true);
    final semestreServices =
        Provider.of<SemestreServices>(context, listen: true);
    final generationServices =
        Provider.of<GenerationServices>(context, listen: true);
    final studentServices = Provider.of<StudentServices>(context);

    final semestre = semestreServices.semestres;
    final group = groupServices.group;
    final generation = generationServices.generations;

    String blood_type_default = bloodType.first;

    Size size = MediaQuery.of(context).size;
    Provider.of<StudentServices>(context, listen: false);

    // el control escoalr o matricula del estudiens recibe aomo parametro
    String? tuition = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      backgroundColor: const Color(0xff1C1D21),
      appBar: AppBar(
        title: const Text('Create Count'),
        backgroundColor: const Color(0xff1C1D21),
      ),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      // datos personales
                      const Text(
                        'Datos Personales',
                        // style: TextStyle(
                        //     fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        runSpacing: 50,
                        spacing: 20,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            // width: size.width * 0.2,
                            width: 330,
                            // height: 60,
                            child: TextFormField(
                              onChanged: (String value) {
                                student.name = value;
                              },
                              decoration: InputDecorations.authDecoration(
                                  hintText: '',
                                  labelText: 'Nombre',
                                  prefixIcon: Icons.near_me),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Ingresa el nombre';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            // width: size.width * 0.2,
                            width: 330,

                            // height: 60,
                            child: TextFormField(
                              onChanged: (value) => student.lastName = value,
                              decoration: InputDecorations.authDecoration(
                                  hintText: '',
                                  labelText: 'Apelllido Paterno',
                                  prefixIcon: Icons.person),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Ingresa el apellido paterno';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            // width: size.width * 0.2,
                            // height: 60,
                            width: 330,
                            child: TextFormField(
                              onChanged: (value) => student.secondName = value,
                              decoration: InputDecorations.authDecoration(
                                  hintText: '',
                                  labelText: 'Apelllido Materno',
                                  prefixIcon: Icons.add_a_photo),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Ingresa el apellido materno';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 320,
                            child: Row(
                              children: [
                                const Text('Sexo'),
                                const SizedBox(
                                  width: 20,
                                ),

                                // sexo
                                DropdownButton<String>(
                                  value:
                                      dropMenuProvider.dropdownMenuItemSexoGet,
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 5,
                                  // style: const TextStyle(color: Colors.deepPurple),
                                  // underline: Container(
                                  //   height: 2,
                                  //   color: Colors.deepPurpleAccent,
                                  // ),
                                  onChanged: (String? value) {
                                    // This is called when the user selects an item.
                                    dropMenuProvider.dropdownMenuItemSexo =
                                        value!;
                                    // student.gender = value;
                                    print('Sexo' + "" + value);
                                    genderSelect = value;
                                  },
                                  items: gender.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      onTap: () {
                                        genderSelect = value;
                                      },
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            width: 330,
                            child: Column(
                              children: [
                                const Text('Fecha de nacimiento'),
                                const SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          _selectDate(context);
                                        },
                                        child:
                                            const Text('Seleccion la fecha ')),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                                    //  student.secondName = selectedDate;
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 320,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Tipo de sangre'),
                                const SizedBox(width: 50),
                                DropdownButton(
                                    elevation: 6,
                                    value: dropMenuProvider.bloogGradStudent,
                                    //  retorno d los tipos de sangre
                                    items: bloodType
                                        .map<DropdownMenuItem<String>>(
                                            (String value) =>
                                                DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value)))
                                        .toList(),
                                    onChanged: (String? value) {
                                      dropMenuProvider.bloogGradStudent =
                                          value!;
                                      // student.bloodGrade = value;
                                      bloodGradeSelect = value;
                                    }),
                              ],
                            ),
                          ),
                          SizedBox(
                            // height: 60,
                            // width: size.width * 0.2,
                            width: 330,
                            child: TextFormField(
                              onChanged: (value) => student.curp = value,
                              decoration: InputDecorations.authDecoration(
                                hintText: '',
                                labelText: 'Curp',
                                // prefixIcon: Icons.document_scanner_sharp
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Ingresa el Curp';
                                }
                                return null;
                              },
                            ),
                          ),

                          // FIEL FOR INSRT AGE O LA EDAD EN ESPALOL

                          SizedBox(
                            width: 320,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Edad'),
                                const SizedBox(
                                  width: 15,
                                ),
                                DropdownButton<int>(
                                    value: dropMenuProvider.ageStudent,
                                    items: ageStudent
                                        .map((int value) =>
                                            DropdownMenuItem<int>(
                                                value: value,
                                                child: Text(value.toString())))
                                        .toList(),
                                    onChanged: (int? value) {
                                      dropMenuProvider.ageStudent = value!;
                                      // student.age = value;
                                      ageSelect = value;
                                      // print('Datos e los estudiantes');
                                    }),
                              ],
                            ),
                          ),

                          // direccion town
                          // para  crear  el usuario y la contraseña
                          SizedBox(
                            width: 320,
                            // height: 40,
                            child: TextFormField(
                              onChanged: (value) => student.town = value,
                              initialValue: '',
                              decoration: InputDecorations.authDecoration(
                                hintText: '',
                                labelText: 'Direccion',
                                // prefixIcon: Icons.document_scanner_sharp
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Ingresa Direccion';
                                }
                                return null;
                              },
                            ),
                          ),
                          // number phone

                          // para  crear  el usuario y la contraseña
                          SizedBox(
                            width: 330,
                            // height: 40,
                            child: TextFormField(
                              // controller: numberPhoneStudent,
                              keyboardType: TextInputType.number,

                              validator: (value) {
                                // if (value!.isEmpty) {
                                //   return 'Por favor ingrese un número';
                                // }
                                // if (int.tryParse(value) == null) {
                                //   return 'Por favor ingrese solo números';
                                // }
                                // return null;

                                // // Expresión regular para verificar si la entrada es numérica
                                final isDigitsOnly =
                                    RegExp(r'^\d+$').hasMatch(value ?? '');
                                if (!isDigitsOnly) {
                                  return 'Por favor ingrese solo números';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                // student.numberPhone = int.parse(value);
                                phoneStudent = value;
                              },
                              initialValue: '',
                              decoration: InputDecorations.authDecoration(
                                hintText: '',
                                labelText: 'Telefono',
                                // prefixIcon: Icons.document_scanner_sharp
                              ),
                            ),
                          ),

                          // para  crear  el usuario y la contraseña
                          SizedBox(
                            width: 330,
                            // height: 40,
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) => student.email = value,
                              initialValue: '',
                              decoration: InputDecorations.authDecoration(
                                hintText: '',
                                labelText: 'Correo electronico',
                                // prefixIcon: Icons.document_scanner_sharp
                              ),
                              validator: (value) {
                                String pattern =
                                    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z]{2,})$';
                                RegExp regex = RegExp(pattern);

                                if (!regex.hasMatch(value!)) {
                                  return 'Ingresa un correo electronico valido';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          // para  crear  el usuario y la contraseña
                          SizedBox(
                            width: 330,
                            // height: 40,
                            child: TextFormField(
                              onChanged: (value) => student.tuition = value,
                              initialValue: '',
                              decoration: InputDecorations.authDecoration(
                                hintText: '',
                                labelText: 'Matricula',
                                // prefixIcon: Icons.document_scanner_sharp
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Ingresa la matricula';
                                }
                                return null;
                              },
                            ),
                          ),

                          SizedBox(
                            width: 330,
                            // height: 40,
                            child: TextFormField(
                              onChanged: (value) => student.password = value,
                              decoration: InputDecorations.authDecoration(
                                hintText: '',
                                labelText: 'Contraseña',
                                // prefixIcon: Icons.document_scanner_sharp
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Este campo es obligatorio';
                                } else if (value.length < 8) {
                                  return 'La contraseña debe tener 8 caracteres';
                                } else if (!RegExp(
                                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                                    .hasMatch(value)) {
                                  return ' Letra mayúscula,  minúscula  y un número';

                                  // return 'La contraseña debe contener al menos una letra mayúscula, una letra minúscula y un número';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  // TODO:  date tutor

                  // datoTutor(parentesco, size),
                  Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'Datos del tutor',
                        // style: TextStyle(
                        //     fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,

                        runSpacing: 50,
                        spacing: 40,
                        // mainAxisAlignment:
                        // MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 330,
                            // height: 60,
                            child: TextFormField(
                              onChanged: (value) =>
                                  student.studentTutor.nameTutor = value,
                              decoration: InputDecorations.authDecoration(
                                hintText: '',
                                labelText: 'Nombre',
                                // prefixIcon: Icons.document_scanner_sharp
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Este campo es obligatorio';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 330,
                            // height: 60,
                            child: TextFormField(
                              onChanged: (value) =>
                                  student.studentTutor.lastNameTutor = value,
                              decoration: InputDecorations.authDecoration(
                                hintText: '',
                                labelText: 'Apellido Paterno',
                                // prefixIcon: Icons.document_scanner_sharp
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Este campo es obligatorio';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 330,
                            // height: 60,
                            child: TextFormField(
                              onChanged: (value) =>
                                  student.studentTutor.secondNameTutor = value,
                              decoration: InputDecorations.authDecoration(
                                hintText: '',
                                labelText: 'Apellido Materno',
                                // prefixIcon: Icons.document_scanner_sharp
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Este campo es obligatorio';
                                }
                                return null;
                              },
                            ),
                          ),
                          Column(
                            children: [
                              const Text('Parentesco'),
                              DropdownButton<String>(
                                  isExpanded: false,
                                  value: dropMenuProvider.parectencoStudent,
                                  items: List.generate(
                                      parentesco.length,
                                      (index) => DropdownMenuItem<String>(
                                            onTap: () {
                                              // student.studentTutor.kinship =
                                              //     parentesco[index];
                                              kinshipSelect = parentesco[index];
                                            },
                                            value: parentesco[index],
                                            child: Text(parentesco[index]),
                                          )),
                                  // parentesco
                                  // .map((String value) => DropdownMenuItem<String>(

                                  //     value: value, child: Text(value)))
                                  // .toList(),
                                  onChanged: (String? value) {
                                    dropMenuProvider.parectencoStudent = value!;
                                    // kinshipSelect = value;

                                    // student.studentTutor.nameTutor = value;
                                  }),
                            ],
                          ),
                          SizedBox(
                            // width: 150,
                            width: size.height * 0.25,
                            // height: 40,
                            child: TextFormField(
                                                          keyboardType: TextInputType.number,

                              validator: (value) {
                                // Expresión regular para verificar si la entrada es numérica

                                final isDigitsOnly =
                                    RegExp(r'^\d+$').hasMatch(value ?? '');
                                if (!isDigitsOnly) {
                                  return 'Por favor ingrese solo números';
                                }
                                return null;
                              },

                              onChanged: (String value) {
                                phoneTutor = value;

                                // student.studentTutor.numberPhoneTutor = int.parse(value);
                              },
                              decoration: InputDecorations.authDecoration(
                                hintText: '',
                                labelText: 'Telefono',
                                // prefixIcon: Icons.document_scanner_sharp
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),

                      // TODO: DATOS DE LAS ESCUELAS
                      const Text(
                        'Datos Escolares',
                        // style: TextStyle(
                        //     fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold
                        //     ),
                      ),
                      Divider(),
                      const SizedBox(height: 20),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,

                        runSpacing: 50,
                        spacing: 40,

                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // areas
                          SizedBox(
                            width: 330,
                            child: Row(
                              children: [
                                const Text('Area'),
                                const SizedBox(
                                  width: 10,
                                ),
                                DropdownButton(
                                    // value: dropMenuProvider.dropdownMenuItemGroup,
                                    value: areas.first,
                                    items: List.generate(
                                        areas.length,
                                        (index) => DropdownMenuItem<String>(
                                            onTap: () {
                                              // student.group = group[index].uid;

                                              // groupSelect = areas[index];
                                              student.specialtyArea =
                                                  areas[index];
                                            },
                                            value: areas[index],
                                            child: Text(areas[index]))),
                                    onChanged: (String? value) {
                                      // dropMenuProvider.dropdownMenuItemGroup = value!;
                                    }),
                              ],
                            ),
                          ),

                          //cresremos a cada uno de los drop down
                          SizedBox(
                            width: 320,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Grupo'),
                                const SizedBox(
                                  width: 10,
                                ),
                                DropdownButton(
                                    value:
                                        dropMenuProvider.dropdownMenuItemGroup,
                                    items: List.generate(
                                        group.groups.length,
                                        (index) => DropdownMenuItem<String>(
                                            onTap: () {
                                              // student.group = group[index].uid;
                                              groupSelect =
                                                  group.groups[index].uid;
                                            },
                                            value: group.groups[index].name,
                                            child: Text(
                                                group.groups[index].name))),
                                    onChanged: (String? value) {
                                      dropMenuProvider.dropdownMenuItemGroup =
                                          value!;
                                    }),
                                //  group
                                //     .map<DropdownMenuItem<String>>((value) =>
                                //         DropdownMenuItem<String>(
                                //             value: value.name, child: Text(value.name)))
                                //     .toList(),
                                // onChanged: (String? value) {
                                //   dropMenuProvider.dropdownMenuItemGroup = value!;
                                // }

                                // ),
                              ],
                            ),
                          ),

                          // lsita de los semestre
                          SizedBox(
                            width: 320,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Semestre'),
                                const SizedBox(width: 40),
                                DropdownButton<String>(
                                    value: dropMenuProvider
                                        .dropdownMenuItemSemestre,
                                    items: List.generate(
                                        semestre.length,
                                        (index) => DropdownMenuItem<String>(
                                            onTap: () {
                                              // student.semestre.add(semestre[index].uid);
                                              // semestreSelect.add(semestre[index].uid);
                                              semestreSelect =
                                                  semestre[index].uid;
                                            },
                                            value: semestre[index].name,
                                            child: Text(semestre[index].name))),
                                    onChanged: (String? value) {
                                      dropMenuProvider
                                          .dropdownMenuItemSemestre = value!;
                                    }),
                              ],
                            ),
                          ),

                          // lista de las generaciones

                          SizedBox(
                            width: 320,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Generacion'),
                                const SizedBox(width: 40),
                                DropdownButton<String>(
                                    // value: generation.first.initialDate.toString(),

                                    value: dropMenuProvider
                                        .dropDownMenuItemGeneracion,
                                    items: List.generate(
                                        generation.length,
                                        (index) => DropdownMenuItem(
                                            onTap: () {
                                              // student.generation = generation[index].uid;
                                              generationSelect =
                                                  generation[index].uid;
                                            },
                                            value: generation[index]
                                                .initialDate
                                                .toString(),
                                            child: Text(
                                                '${generation[index].initialDate.year} - ${generation[index].finalDate.year}'))),

                                    //  generation
                                    //     .map<
                                    //         DropdownMenuItem<
                                    //             String>>((value) => DropdownMenuItem(
                                    //         value: value.initialDate.toString(),
                                    //         child: Text(
                                    //             '${value.initialDate.year} - ${value.finalDate.year}')))
                                    //     .toList(),
                                    onChanged: (String? value) {
                                      dropMenuProvider
                                          .dropDownMenuItemGeneracion = value!;
                                    }),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  // datoEscolar(dropMenuProvider, group, semestre, generacion)

                  MaterialButton(
                    onPressed: () async {
                      if (ageSelect == null ||
                          genderSelect == null ||
                          bloodGradeSelect == null ||
                          kinshipSelect == null ||
                          groupSelect == null ||
                          semestreSelect == null ||
                          generationSelect == null) {
                        print('No se ha seleccionado da de los DropDown');

                        // Mostrar un mensaje de error si no se ha seleccionado una opción
                        return showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text("Error"),
                            content:
                                const Text("Por favor, seleccione una opción."),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Aceptar'),
                              )
                            ],
                          ),
                        );
                      }

                      // if (formKey.isValidate()) {
                      if (formKey.currentState!.validate()) {
                        // hacer algo

                        final studentServices = Provider.of<StudentServices>(
                            context,
                            listen: false);

                        student.gender = genderSelect!;
                        student.bloodGrade = bloodGradeSelect!;
                        student.age = ageSelect!;
                        student.studentTutor.kinship = kinshipSelect!;
                        student.group = groupSelect!;

                        student.semestre.add(semestreSelect!);

                        student.generation = generationSelect!;

                        student.numberPhone = int.parse(phoneStudent);
                        student.studentTutor.numberPhoneTutor =
                            int.parse(phoneTutor);
                        await studentServices.registerStudent(student);
                        print(student.name);
                      }
                    },
                    child: studentServices.status == true
                        ? const CircularProgressIndicator()
                        : const Text('Registrares'),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  // Creamos un metodo  para cargar los datos que re requiredn

  void onLoading() async {
    // groups
    final groupServices = Provider.of<GroupServices>(context, listen: false);
    // semstres
    final semestreServices =
        Provider.of<SemestreServices>(context, listen: false);
    // generations
    final generationServices =
        Provider.of<GenerationServices>(context, listen: false);
    // aregres

    groupServices.allGroup();
    semestreServices.getSemestres();
    generationServices.allGeneration();
  }
}
