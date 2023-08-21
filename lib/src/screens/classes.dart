



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prepa_estudiantes/services/horario_services.dart';

import 'dart:io';

import '../model/horarios.dart';
import '../widgets/class_day.dart';



class Clases extends StatefulWidget {
  const Clases({Key? key}) : super(key: key);


  @override
  State<Clases> createState() => _Clasestate();
}

class _Clasestate extends State<Clases> {
  final style1 = const TextStyle(color: Colors.white70, fontSize: 22);

  // cread lists day
  final listDay = ['Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes'];

  // instantia de la clase de horarios
  List<GroupHorarios> dayHorario = [];

  @override
  Widget build(BuildContext context) {
    final horarioServices = Provider.of<HorarioServices>(context);
    final horario = horarioServices.horario;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: IconButton(onPressed: (){
        //     // Navigator.pop(context);
        // }, icon:  const Icon(Icons.arrow_back_ios_new_rounded)),
        // backgroundColor: const Color(0xff1C1D21),
        backgroundColor: Colors.red,

        // elevation: 0,
        centerTitle: true,
        title: const Text('Horarios'),
      ),
      body: Container(
        // height: double.infinity,
        // color: const Color(0xff050d2e),
        color: const Color(0xff1C1D21),

        // color : Colors.white,
        child: Padding(
          padding: Platform.isAndroid || Platform.isIOS
              ? const EdgeInsets.all(0.0)
              : const EdgeInsets.all(50.0),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // const Center(
                    //   child: Text(
                    //     'Dias de la semana',
                    //     style: TextStyle(fontSize: 20, color: Colors.white70),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: listDay.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 150,
                                height: 40,
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xff4CCFFF).withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    switch (index) {
                                      case 0:
                                        dayHorario = horario.friday;
                                        break;
                                      case 1:
                                        dayHorario = horario.tuesday;
                                        break;
                                      case 2:
                                        dayHorario = horario.monday;
                                        break;
                                      case 3:
                                        dayHorario = horario.thursday;
                                        break;
                                      case 4:
                                        dayHorario = horario.wednesday;
                                        break;
                                    }
                                    setState(() {});
                                  },
                                  child: Center(
                                    child: Text(
                                      listDay[index],
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            );

                            // ClassToDay para ver la claese por dia.
                            // return GestureDetector(
                            //   child: ClassDay(
                            //     textDay: listDay[index],
                            //   ),
                            // );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 500,
                      child: dayHorario.isEmpty
                          ? Center(
                              child: Column(
                              children: [
                                SizedBox(
                                  height: 250,
                                  width: 250,
                                  child: Image.asset(
                                    "asset/student.png",
                                    width: 250,
                                    height: 250,
                                  ),
                                ),
                                const Text("Selecciona un dia de la semana"),
                              ],
                            ))
                          : ListView.builder(
                              itemCount: dayHorario.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ClassToDay(
                                    horarios: dayHorario,
                                    index: index);
                              },
                            ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
