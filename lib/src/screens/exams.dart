import 'package:flutter/material.dart';
import 'package:prepa_estudiantes/src/widgets/card_exams.dart';


class Exams extends StatelessWidget {
  const Exams({Key? key}) : super(key: key);

  // Liata de los profesores
  @override
  Widget build(BuildContext context) {
    // creamous una lista de tipo Teachers.
    final List<Teachers> teachers = [
      Teachers(1, 'Ing Jaime Yong', 'Matematicas','Hola','asset/iconito.png'),
      Teachers(2, 'Quimic Beltran', 'Quimica','Hola', 'asset/iconito.png'),
      Teachers(3, 'Ing Eriberto ', 'Infomatica','Hola', 'asset/iconito.png'),
      Teachers(4, 'Ing Jaime Yong', 'Matematicas','Hola', 'asset/iconito.png'),
      Teachers(3, 'Ing Eriberto ', 'Infomatica','Hola', 'asset/iconito.png'),
      Teachers(4, 'Ing Jaime Yong', 'Matematicas','Hola', 'asset/iconito.png'),
      Teachers(3, 'Ing Eriberto ', 'Infomatica','Hola', 'asset/iconito.png'),
      Teachers(4, 'Ing Jaime Yong', 'Matematicas','Hola', 'asset/iconito.png'),
      Teachers(3, 'Ing Eriberto ', 'Infomatica','Hola', 'asset/iconito.png'),
      Teachers(4, 'Ing Jaime Yong', 'Matematicas','Hola', 'asset/iconito.png'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis examenes'),
        backgroundColor: const Color(0xff1C1D21),
      ),
      body: Container(
        // color: const Color(0xff050d2e),
        color: const Color(0xff1C1D21),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
                children: List.generate(teachers.length, (index) {
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'home_exams'),
                child: CardExams(
                    image: teachers[index].image,
                    materia: teachers[index].materia,
                    name: teachers[index].name),
              );
            })),
          ),
        ),
      ),
    );
  }
}

class Teachers {
  int? id;
  String name = "";
  String materia = "";
  String description="";
  String image = "";
  // cremos el contructor

  Teachers(int id, String names, String materias,String descriptions, String images) {
    id = id;
    name = names;
    materia = materias;
      description = descriptions;
    image = images;
  }
}
