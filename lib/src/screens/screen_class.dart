import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/horario_services.dart';
import '../model/horarios.dart';
import 'dart:io';

import '../widgets/class_day.dart';

class ScreenClass extends StatefulWidget {
  const ScreenClass({Key? key}) : super(key: key);

  @override
  State<ScreenClass> createState() => _ScreenClassState();
}

class _ScreenClassState extends State<ScreenClass> {
  final style1 = const TextStyle(color: Colors.white70, fontSize: 22);

  // cread lists day
  final listDay = ['Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes'];

  // instantia de la clase de horarios
  List<GroupHorarios> dayHorario = [];

  @override
  Widget build(BuildContext context) {
    final horarioServices = Provider.of<HorarioServices>(context);
    final horario = horarioServices.horario;

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SELECIONA LOS DIAS DE MA SEMAMA', style: TextStyle(fontSize: 14)),
      ),
      body: Container(
        height: double.infinity,
        // color: const Color(0xff050d2e),
        color: const Color(0xff1C1D21),

        // color : Colors.white,
        child: Padding(
          padding: Platform.isAndroid || Platform.isIOS
              ? const EdgeInsets.all(5.0)
              : const EdgeInsets.symmetric(horizontal: 50),
          child: SafeArea(
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
                    height: 10,
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
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xff4CCFFF).withOpacity(0.4),
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
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: size.height * 0.73,
                    child: dayHorario.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: size.height * 0.3,
                                width: size.width * 0.3,
                                child: Image.asset(
                                  "asset/student.png",
                                  // width: 300,
                                  // height: 300,
                                ),
                              ),
                              const Text("Selecciona un dia de la semana"),
                            ],
                          )
                        : ListView.builder(
                            itemCount: dayHorario.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ClassToDay(
                                  horarios: dayHorario, index: index);
                            },
                          ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
