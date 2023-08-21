import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prepa_estudiantes/services/student_services.dart';
import 'package:prepa_estudiantes/services/subject_services.dart';
import 'package:prepa_estudiantes/src/model/student.dart';
import 'package:prepa_estudiantes/src/model/subjects.dart';
import 'package:prepa_estudiantes/src/screens/drawer_one.dart';
import 'package:prepa_estudiantes/src/widgets/card_falso.dart';
import 'package:prepa_estudiantes/src/widgets/news.dart';
import 'package:prepa_estudiantes/src/widgets/show_alert.dart';

import 'dart:io';
import '../../services/horario_services.dart';
import '../../services/login_services.dart';
import '../../services/publication_services.dart';
import '../../services/secure_storage.dart';
import '../../services/semestres_services.dart';
import '../../services/story_services.dart';
import '../../services/taskReceived_services.dart';
import '../../services/task_services.dart';
import '../model/horarios.dart';
import '../model/task.dart';
import '../widgets/cardStory.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // para cargar algunos de los datosf
    onLoading();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1C1D21),
      drawer: const Drawer1(),
      appBar: AppBar(
        backgroundColor: const Color(0xff1C1D21),
        title: const Center(child: Text("PREPA BOCHIL")),
        actions: [
          //     showSearch(context: context, delegate: SearchDelegateClass());
          //   },
          //   icon: const Icon(Icons.search),
          // ),
          IconButton(
            onPressed: () async {
              final loginServices =
                  Provider.of<LoginServices>(context, listen: false);
              await loginServices.logout();
              final storage = SecureStorage.storage;
              await storage.delete(key: 'token');

              // despues iremos  al login para el nuevo inicio de sesion

              Navigator.pushReplacementNamed(context, 'login');
            },
            icon: const Icon(Icons.login_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Navigator.pushNamed(context, 'chat_message');
          },
          icon: const Icon(Icons.chat_rounded),
          label: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('CHAT'),
          )),
      body: _buildBody(),
    );
  }

  // Future<List<String>>
  List<String> listIdSubject(List<Subjects> listIdSubjects) {
// new id list
    List<String> newIdList = [];

    for (var idSuject in listIdSubjects) {
      newIdList.add(idSuject.uid);
    }

    return newIdList;
  }

  // funcio nque se ejecuta par al horario de clases
  void onLoading() async {
    final studentServices =
        Provider.of<StudentServices>(context, listen: false);
    final dataStudent = studentServices.student;
    final horarioServices =
        Provider.of<HorarioServices>(context, listen: false);
    final taskServices = Provider.of<TaskServices>(context, listen: false);

    final storyServices = Provider.of<StoryServices>(context, listen: false);
    // para  obtener la lista de materia
    final subjectServices =
        Provider.of<SubjectServices>(context, listen: false);
    final student = studentServices.student;

    await subjectServices.allSubjectForSemestre(student.semestre.last.id);

    final subjects = subjectServices.subjects;

    await storyServices.getAllStoryByStatusTrue();

    if (student.subjects.isNotEmpty || subjects.isNotEmpty) {
      //  final idSubjects = listIdSubject(student.subjects);
      List<String> idSubjects = listIdSubject(subjects);

      // await horarioServices.getHorario(
      //     // '63f96704ontcfe1982933912129',
      //     dataStudent.generation.id,
      //     dataStudent.semestre.last.id,
      //     dataStudent.group.id);

      await taskServices.getTaskStudent(
          // token,
          student.generation.id,
          student.semestre[0].id,
          student.group.id,
          // student.subjects[1].id
          idSubjects);
    }
  }
}

// ignore: camel_case_types
class _buildBody extends StatefulWidget {
  @override
  State<_buildBody> createState() => _buildBodyState();
}

class _buildBodyState extends State<_buildBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // contolador de la animacion
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..forward();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
// instancia de la clase para las tareas
    final taskServices = Provider.of<TaskServices>(context);
    final List<Tasks> tasks = taskServices.tasks;

// instnaciadel model dende esta el datos de los estudianes
    final studentServices = Provider.of<StudentServices>(context);
    final student = studentServices.student;

    // nistacne class para mostar la lista de materia
    final subjectServices = Provider.of<SubjectServices>(context);
    final subjects = subjectServices.subjects;

    bool isDesktop = Platform.isWindows == Platform.isWindows;

    return SafeArea(
      child: Row(
        children: [
          !isDesktop ? const Drawer1() : Container(),
          SingleChildScrollView(
            child: Padding(
              padding: !isDesktop
                  ? EdgeInsets.symmetric(horizontal: size.width * 0.03)
                  : const EdgeInsets.all(8.0),
              child: Container(
                width: Platform.isWindows || Platform.isMacOS
                    // ? size.width * 0.655
                    ? size.width * 0.652
                    : size.width * 0.94,

                //  color:const  Color(0xff050d2e),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  Parte del logo de la aplicacion

                    const SizedBox(
                      height: 40,
                    ),
                    const Text('BUENOS DIAS',
                        style: TextStyle(fontSize: 25, color: Colors.white70)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AnimatedOpacity(
                        // opacity: _animation.value,
                        opacity: .9,
                        duration: const Duration(seconds: 1),
                        child: Text(
                            student.name +
                                "  " +
                                student.lastName +
                                "  " +
                                student.secondName,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white70)),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),

                    // slider(size: size),
                    CardStory(size: size),

                    const SizedBox(
                      height: 20,
                    ),
                    Divider(),
                    ListSubjects(subjects: subjects),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(),

                    const scheduleDay(),

                    // Tareas.
                    const SizedBox(
                      height: 20,
                    ),

                    // para la seccion de la teareas
                    const Text(
                      'Tareas',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 220,
                      //  color:   Colors.white,

                      child: tasks.isEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: 150,
                                    height: 150,
                                    child: Image.asset('asset/mitask.png')),
                                const Text(
                                    "Vendito sea el señor no tienes tarea",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white70)),
                              ],
                            )
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: tasks.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, 'home_tarea',
                                          arguments: tasks[index]);
                                    },
                                    child: CardTarea(
                                      tasks: tasks[index],
                                    ));
                              },
                            ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Otras Opciones',
                        style: TextStyle(fontSize: 18, color: Colors.white70)),
                    const SizedBox(
                      height: 20,
                    ),

                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          GestureDetector(
                            onTap: () {
                              final studentServices =
                                  Provider.of<StudentServices>(context,
                                      listen: false);

                              final taskReceivedServices =
                                  Provider.of<TaskQualifieldServices>(context,
                                      listen: false);
                              taskReceivedServices.getAllTaskReceived(
                                  studentServices.student.uid!);

                              // final task = taskReceivedServices.taskReceived;

                              Navigator.pushNamed(
                                context, 'allTaskDelivered',
                                // arguments: task
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 160,
                                width: 230,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xff242529),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          height: 100,
                                          width: 130,
                                          child: Image.asset(
                                              'asset/sendtask.png')),
                                      const Text('Tareas Calificados',
                                          style: TextStyle(
                                              color: Colors.white54,
                                              fontSize: 16)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 160,
                              width: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xff242529),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(20.0),
                                child: SizedBox(
                                  child: Center(
                                    child: Text('Tareas Entregados',
                                        style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 16)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Publicaciones',
                          style: TextStyle(fontSize: 18, color: Colors.white70),
                        ),
                        TextButton(
                            onPressed: () {
                              final publicationServices =
                                  Provider.of<PublicationServices>(context,
                                      listen: false);

                              publicationServices.allPublication();
                              Navigator.pushNamed(context, 'list_publication');
                            },
                            child: const Text('Ver todas'))
                      ],
                    ),

                    const SizedBox(
                      width: double.infinity,
                      height: 320,
                      child: News(),
                    ),

                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class scheduleDay extends StatefulWidget {
  const scheduleDay({
    Key? key,
  }) : super(key: key);

  @override
  State<scheduleDay> createState() => _scheduleDayState();
}

class _scheduleDayState extends State<scheduleDay>
    with SingleTickerProviderStateMixin {
// crer un functio napra retornar el dia que es hot

  myDayClass() {
    final now = DateTime.now();

    // crero una lita de losdais de la semana
    final List weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday'
          'Saturday',
      'Sunday'
    ];

    // quieor  hacer si hy es 6 me debe de mostar el dia sabado en la console
    String myday = '';
    for (int i = 0; i < weekdays.length; i++) {
      if (i == now.weekday - 1) {
        myday = weekdays[i];
        print(weekdays[i]);
      }
    }

    return myday;
  }

// controlador para la animacion del tecto
  late AnimationController _controller;
  late Animation<double> _animation;

  // inicializar el controlador
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // duracion  de la animation
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          // ..forward();
          // ..forward();
          ..repeat();

    // animacion
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
  }

  // terminamos la  animacio del text
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheduleServices = Provider.of<HorarioServices>(context);

    // today's clases --- clases del dia
    List<GroupHorarios> todayClass = [];

    final schedule = scheduleServices.horario;

    // hacemos la instancia de la funcion crearda que devuelve el dia de hoy

    final myDay = myDayClass();
    // 'Monday',
    //   'Tuesday',
    //   'Wednesday',
    //   'Thursday',
    //   'Friday'
    //       'Saturday',
    //   'Sunday'

    switch (myDay) {
      case 'Monday':
        todayClass = schedule.monday;
        break;
      case 'Tuesday':
        todayClass = schedule.tuesday;
        break;

      case 'Wednesday':
        todayClass = schedule.wednesday;
        break;

      case 'Thursday':
        todayClass = schedule.thursday;
        break;

      case 'Friday':
        todayClass = schedule.friday;
        break;

      case 'Saturday':
        // todayClass = schedule.;'
        todayClass = [];

        break;

      case 'Sunday':
        todayClass = [];
        break;

      default:
        todayClass = schedule.monday;
    }

    return Column(
      children: [
        Row(
          children: [
            const Text(
              'Clases',
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
            const Spacer(),
            MaterialButton(
              onPressed: () {
                // Navigator.pushNamed(context, 'class');
                if (todayClass.isEmpty) {
                  ShowAlert.showAlert(
                      context,
                      'Clases',
                      const Center(
                        child: Text('NO HAY CLASES ENTENDE'),
                      ));
                      return null;

                }
                Navigator.pushNamed(context, 'schedule_by_day');
              },
              child: Text(
                todayClass.length.toString() + ' Clases hoy.',
                style: const TextStyle(fontSize: 15, color: Colors.white24),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: double.infinity,
          height: 150,
          // child: const ClassToDay(),

          child: todayClass.isEmpty
              ? Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 0.5, color: Colors.white10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 100,
                        child: Image.asset('asset/mitask.png'),
                      ),

                      // const Text(" NO HAY CLASES ES FIN DE SEMANA",
                      //     style:
                      //         TextStyle(fontSize: 15, color: Colors.white24)),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'NO HAY CLASES ES FIN DE SEMANA',
                                style: TextStyle(
                                    // fontFamily: 'sans-serif'
                                    // fontFamily: 'Courier',
                                    fontFamily: 'Roboto',
                                    color: Colors.white60,
                                    fontSize: _animation.value * 15),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : Data(horarios: todayClass.first),
        ),
      ],
    );
  }
}

class ListSubjects extends StatelessWidget {
  const ListSubjects({
    Key? key,
    required this.subjects,
  }) : super(key: key);

  final List<Subjects> subjects;

  @override
  Widget build(BuildContext context) {
    final studentServices =
        Provider.of<StudentServices>(context, listen: false);
    final student = studentServices.student;
    // student.subjects.isEmpty

// su lista de materiaas sera mostrado por semestre

    return Column(
      // mainAxisAlignment: MainAxisAlignment.start
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Materias',
          style: TextStyle(fontSize: 18, color: Colors.white70),
        ),
        const SizedBox(
          height: 10,
        ),
        student.subjects.isEmpty
            ? Card(
                color: const Color(0xff25282F),
                child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('No tienes materias agregadas'),
                          const SizedBox(
                            height: 10,
                          ),
                          TextButton(
                              onPressed: () {
                                final semestreServices =
                                    Provider.of<SemestreServices>(context,
                                        listen: false);
                                semestreServices.getSemestres();

                                Navigator.pushNamed(
                                    context, 'add_semestre_subject');
                              },
                              child: const Text('Agregar materias')),
                        ],
                      ),
                    )),
              )
            : Container(
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(20),
                //   border: Border.all(width: 0.5, color: Colors.white10),
                // ),
                // height: 50,
                child: Wrap(
                  children: List.generate(
                      subjects.length,
                      (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                // backgroundColor:    Color(0xff25282F),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xff25282F)),
                              ),
                              onPressed: () async {
                                // Befor navigating     the next view make   two request by subject
                                // taks for subject
                                // and task qualified

                                final taskServices = Provider.of<TaskServices>(
                                    context,
                                    listen: false);

                                final taskQualifieldServices =
                                    Provider.of<TaskQualifieldServices>(context,
                                        listen: false);

                                // get task for subject
                                taskServices.getTaskStentBySubject(
                                    student.group.id, subjects[index].uid);

                                // / esto extrae todas las tareas en la cuall
                                //   //solo se require por materia
                                taskQualifieldServices
                                    .getAllTaskReceivedBySubjet(
                                        subjects[index].uid);
                                // taskQualifieldServices.getAllTaskReceived(idStudent);

                                Navigator.pushNamed(context, 'show_subjects',
                                    arguments: subjects[index]);
                              },
                              child: Text(subjects[index].name),
                            ),
                          )),
                ),

                // child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: subjects.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       return Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 5),
                //         child: ElevatedButton(
                //           style: ButtonStyle(
                //             // backgroundColor:    Color(0xff25282F),
                //             backgroundColor: MaterialStateProperty.all(
                //                 const Color(0xff25282F)),
                //           ),
                //           onPressed: () async {
                //             // Befor navigating     the next view make   two request by subject
                //             // taks for subject
                //             // and task qualified

                //             final taskServices = Provider.of<TaskServices>(
                //                 context,
                //                 listen: false);

                //             final taskQualifieldServices =
                //                 Provider.of<TaskQualifieldServices>(context,
                //                     listen: false);

                //             // get task for subject
                //             taskServices.getTaskStentBySubject(
                //                 student.group.id, subjects[index].uid);

                //             // / esto extrae todas las tareas en la cuall
                //             //   //solo se require por materia
                //             taskQualifieldServices.getAllTaskReceivedBySubjet(
                //                 subjects[index].uid);
                //             // taskQualifieldServices.getAllTaskReceived(idStudent);

                //             Navigator.pushNamed(context, 'show_subjects',
                //                 arguments: subjects[index]);
                //           },
                //           child: Text(subjects[index].name),
                //         ),
                //       );
                //     }),
              ),
      ],
    );
  }
}

class slider extends StatelessWidget {
  // vmao a recivir la altura
  final Size size;

  const slider({Key? key, required this.size}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Opacity(
            opacity: 0.7,
            child: Image.asset(
              'asset/si.jpg',
              filterQuality: FilterQuality.low,
              fit: BoxFit.fill,
              // opacity: 0.7,
            ),
          )),
      height: Platform.isAndroid || Platform.isIOS
          ? size.height * 0.3
          : size.height * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey,
        // color: Color(),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.3),
            offset: const Offset(0, 2),
            blurRadius: 1, // efecto de la sombre en la parte inferior.
            spreadRadius: 0.5,
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
    );
  }
}

class CardTarea extends StatelessWidget {
  // receibe list tasks
  final Tasks tasks;

  const CardTarea({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: Platform.isAndroid || Platform.isIOS ? size.width * 0.85 : 300,
        height: 200,
        decoration: BoxDecoration(
          color: const Color(0xff25282F),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 180,
                        child: Text(
                          tasks.subject.name,
                          // 'Matematicas',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white70),
                        ),
                      ),
                      // const SizedBox(height: 10),
                      // Row(
                      //   children: [
                      //     const Icon(Icons.watch_later_outlined,
                      //         color: Colors.white24),
                      //     const SizedBox(
                      //       width: 10,
                      //     ),
                      //     Text(
                      //       tasks.createdAt.toString().substring(0, 10),
                      //       style: const TextStyle(
                      //           fontSize: 15, color: Colors.white24),
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                  // const SizedBox(
                  //   width: 20,
                  // ),
                  Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xff2D3134),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            "https://pyxis.nymag.com/v1/imgs/2e0/38e/55f0d4724239a2b0aae4930e8b2e5d7c27-14-stephen-hawking.rsquare.w700.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              // logugar para el texto jjajaaja
              Text(
                tasks.nameTask,
                // 'LA INVESTIGACION ESTA BASA EN LAS  ANOMALIAS DE LA GRAVEDAD',
                style: const TextStyle(color: Colors.white70),
              ),

              const SizedBox(
                height: 20,
              ),
              // Row(
              //   children: [
              //     Image.asset('asset/iconito.png'),
              //     Container(
              //       height: 32,
              //       width: 32,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(32),
              //       ),
              //       child: ClipRRect(
              //           borderRadius: BorderRadius.circular(50),
              //           child: Image.network(
              //             'http://www.ugr.es/~jmaroza/images/Ramanujan.jpg',
              //             fit: BoxFit.fill,
              //           )),
              //     ),
              //   ],
              // ),
              Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('FECHA DE ENTERGA',
                        style: TextStyle(fontSize: 13, color: Colors.white24)),
                    Text(tasks.expiredAt.toString().substring(0, 10),
                        style: const TextStyle(
                            fontSize: 13, color: Colors.white24)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
