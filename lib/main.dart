import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prepa_estudiantes/src/screens/chat/schedule_for_day.dart';
import 'package:provider/provider.dart';
import 'package:prepa_estudiantes/services/chat/chat_services.dart';
import 'package:prepa_estudiantes/services/chat/socket_servives.dart';
import 'package:prepa_estudiantes/services/file_services.dart';
import 'package:prepa_estudiantes/services/generation_services.dart';
import 'package:prepa_estudiantes/services/group_services.dart';
import 'package:prepa_estudiantes/services/horario_services.dart';
import 'package:prepa_estudiantes/services/login_services.dart';
import 'package:prepa_estudiantes/services/publication_services.dart';
import 'package:prepa_estudiantes/services/push-notification-services.dart';
import 'package:prepa_estudiantes/services/rating_services.dart';
import 'package:prepa_estudiantes/services/semestres_services.dart';
import 'package:prepa_estudiantes/services/story_services.dart';
import 'package:prepa_estudiantes/services/student_services.dart';
import 'package:prepa_estudiantes/services/subject_services.dart';
import 'package:prepa_estudiantes/services/sumbmit_task_services.dart';
import 'package:prepa_estudiantes/services/taskReceived_services.dart';
import 'package:prepa_estudiantes/services/task_services.dart';
import 'package:prepa_estudiantes/services/tuition_services.dart';
import 'package:prepa_estudiantes/src/provider/login_form_provider.dart';
import 'package:prepa_estudiantes/src/provider/meuOptionProvider.dart';
import 'package:prepa_estudiantes/src/screens/add_semestre_subjects.dart';
import 'package:prepa_estudiantes/src/screens/allTaskDelivered.dart';
import 'package:prepa_estudiantes/src/screens/home.dart';
import 'package:prepa_estudiantes/src/screens/chat.dart';
import 'package:prepa_estudiantes/src/screens/chat_page.dart';
import 'package:prepa_estudiantes/src/screens/check__auth_login.dart';
import 'package:prepa_estudiantes/src/screens/class_for_day.dart';
import 'package:prepa_estudiantes/src/screens/create_student.dart';
import 'package:prepa_estudiantes/src/screens/create_task.dart';
import 'package:prepa_estudiantes/src/screens/details_class.dart';
import 'package:prepa_estudiantes/src/screens/entry_class.dart';
import 'package:prepa_estudiantes/src/screens/exams.dart';
import 'package:prepa_estudiantes/src/screens/home_chat.dart';
import 'package:prepa_estudiantes/src/screens/home_exams.dart';
import 'package:prepa_estudiantes/src/screens/information_subject.dart';
import 'package:prepa_estudiantes/src/screens/information_teacher.dart';
import 'package:prepa_estudiantes/src/screens/list_publication.dart';
import 'package:prepa_estudiantes/src/screens/login.dart';
import 'package:prepa_estudiantes/src/screens/perfil.dart';

// import 'package:flutter_native_splash/flutter_native_splash.dart';

// import 'package:flutter/services.dart';5
import 'package:prepa_estudiantes/src/screens/ratings.dart';
import 'package:prepa_estudiantes/src/screens/search_tuition.dart';
import 'package:prepa_estudiantes/src/screens/show_publication.dart';
import 'package:prepa_estudiantes/src/screens/subjects.dart';
import 'package:prepa_estudiantes/src/screens/teachers.dart';
// import 'package:prepa_estudiantes/src/widgets/screen_download.dart';

import 'src/screens/home_tarea.dart';

import 'dart:io';

import 'src/screens/screen_class.dart';

void main() async {
  // hacemos la intnacia de la funciton para iniciarlizar el Firebe

  WidgetsFlutterBinding.ensureInitialized();

// WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
//   FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
// FlutterNativeSplash.removeAfter(initialization);
 
  // await Future.delayed(const Duration(seconds: 2));
  // FlutterNativeSplash.remove();

// para las notifcacioens por el moment oestara comentado, falta la configuracion
  // if (Platform.isAndroid) {
  //   await PushNotificationServices.initializeApp();
  // }

  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
  //   (value) =>
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => LoginFormProvider()),
    ChangeNotifierProvider(create: (_) => LoginServices()),
    ChangeNotifierProvider(create: (_) => StudentServices()),
    ChangeNotifierProvider(create: (_) => TaskServices()),

    // para subir los archivos
    ChangeNotifierProvider(create: (_) => FilesServices()),

    // para las opciones del menu MAC Y WINDOWS

    ChangeNotifierProvider(create: (_) => MenuOptionProvider()),

    // send task
    ChangeNotifierProvider(create: (_) => SendTaskServices()),

// get horarios scheule
    ChangeNotifierProvider(create: (_) => HorarioServices()),

    // For  subjects

    ChangeNotifierProvider(create: (_) => SubjectServices()),

// for get ratings for sujects
    ChangeNotifierProvider(create: (_) => RatingServices()),

    // para tareas entregados
    ChangeNotifierProvider(create: (_) => TaskQualifieldServices()),

    // get publication
    ChangeNotifierProvider(create: (_) => PublicationServices()),

    // change notifer by get subject
    ChangeNotifierProvider(create: (_) => SubjectServices()),
    ChangeNotifierProvider(create: (_) => StoryServices()),
    ChangeNotifierProvider(create: (_) => SocketService()),

    // chat
    ChangeNotifierProvider(create: (_) => ChatServices()),

    // semestre
    ChangeNotifierProvider(create: (_) => SemestreServices()),
    // group
    ChangeNotifierProvider(create: (_) => GroupServices()),
    // generacion
    ChangeNotifierProvider(create: (_) => GenerationServices()),
    // semestre
    ChangeNotifierProvider(create: (_) => SemestreServices()),
    // tuition o matricula
    ChangeNotifierProvider(create: (_) => TuitionServices())
  ], child: const MyApp()));
  // );
}

Future initialization(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 2));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /*
    *   creatmos dos contoladores 
    *    uno para el Navegacion
    *     otro para el snack
    */

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerState =
      GlobalKey<ScaffoldMessengerState>();

  final GlobalKey<NavigatorState> navigateKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    // de la fuction getter que se creo hacemos la isntnacia para obtener el stream
    PushNotificationServices.streamMessage.listen((message) {
      // print('main');

      //  navigateKey.currentState.pushNamed('home_tarea', arguments: message);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    // bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    // final isDarkTheme = ThemeData.dark();
    return MaterialApp(
      // title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      // navigatorKey: navigateKey,
      // scaffoldMessengerKey: scaffoldMessengerState,

      // home: const Home(),
      initialRoute: 'check_auth_screen',
      // initialRoute: 'home',
      routes: {
        'check_auth_screen': (_) => const CheckAuthScreen(),
        'home': (_) => const Home(),
        'login': (_) => const Login(),

        'classes': (_) => const ScreenClass(),
        'chat': (_) => const Chat(),
        'home_chat': (_) => const HomeChat(),
        'class_for_day': (_) => const ClassForDat(),
        'details_class': (_) => const DetailsClass(),
        'entry_class': (_) => const EntryClass(),
        'profile': (_) => const ProfileStudents(),
        // page examns

        'exams': (_) => const Exams(),
        'home_exams': (_) => const HomeExams(),
        'home_tarea': (_) => const HomeTarea(),
        // ruta para las tareas
        'create_task': (_) => ScreenCreateTask(),

        // ruta para las calificaciones
        'rating': (_) => const ScreenRating(),

        // Screen for all tasks delivered
        // tareas calificados
        'allTaskDelivered': (_) => const AllTaskDelivered(),

        // all publications
        'list_publication': (_) => const ScreenListPublication(),
        'show_publication': (_) => const ShowPublication(),

        // view to show the infromation of the subject
        'show_subjects': (_) => const ScreenSubject(),

        // lsit teacher
        'list_teachers': (_) => const ScreenlistTeacher(),
        //  show  information student
        'profile_teacher': (_) => const ScreenInformationTeacher(),

        // para el chat
        'chat_message': (_) => const ChatPages(),
        // 'chat_message': (_)=> const ChatPage2()
        // ruta para las materias
        'subjects': (_) => const ScreenlistSUbjects(),
        // para agregar las materias
        'add_semestre_subject': (_) => const ScreemAddSemestreSubject(),
        'search_tuition': (_) => const SearchTuition(),
        'create_count': (_) => const FormIsWidows(),
      
       // para los horarios 
       'schedule_by_day':(_) => const ScheduleByDay()
      },


      // theme: ThemeData.light(
      //   useMaterial3: true,
      // ),

      // No personalizado

      theme: ThemeData.dark(
        useMaterial3: true,
      ),

      // theme: ThemeData(
      //   useMaterial3: true,
      //   appBarTheme: const AppBarTheme(
      //     // color: Colors.red,
      //     backgroundColor: Color(0xff1C1D21),
      //   ),
      //   scaffoldBackgroundColor: const Color(0xff1C1D21),
      // ),

      // theme: isDarkTheme == ThemeData.light()
      //     ? ThemeData(
      //         // primarySwatch: Colors.blue,
      //         // scaffoldBackgroundColor: const Color(0xff1C1D21),
      //         // bottomAppBarColor: const Color(0xff1C1D21
      //         useMaterial3: true,

      //       )
      //     : ThemeData(
      //         // primarySwatch: Colors.blue,
      //         // scaffoldBackgroundColor: const Color(0xff1C1D21),

      //         useMaterial3: true,
      //       ),
    );
  }
}
