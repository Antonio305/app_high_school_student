import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/taskReceived_services.dart';
import '../model/task_received.dart';

import 'dart:io';

import '../widgets/cardTask_qualifield.dart';

class AllTaskDelivered extends StatefulWidget {
  const AllTaskDelivered({Key? key}) : super(key: key);

  @override
  State<AllTaskDelivered> createState() => _AllTaskDeliveredState();
}

class _AllTaskDeliveredState extends State<AllTaskDelivered> {
  List<TaskReceived> taskReceived = [];

  @override
  void initState() {
    super.initState();
    taskReceived = [];
  }

  @override
  Widget build(BuildContext context) {
    final taskReceivedServices = Provider.of<TaskQualifieldServices>(context);
    // taskReceivedServices.
    taskReceived = taskReceivedServices.taskReceived;

    // taskReceived =
    // ModalRoute.of(context)?.settings.arguments as List<TaskReceived>;
    return Scaffold(
        backgroundColor: const Color(0xff1C1D21),
        appBar: AppBar(
          elevation: 0,
          title: const Text('Tareas Calificados'),
          backgroundColor: const Color(0xff1C1D21),
        ),
        body: taskReceivedServices.status == true
            ? const Center(child: CircularProgressIndicator.adaptive())
            : Center(
                child: taskReceived.isEmpty
                    ? const Text('NO TIENES TAREA CALIFICADOS')
                    : ListView.builder(
                        itemCount: taskReceived.length,
                        itemBuilder: (BuildContext context, int index) {
                          // return Text(taskReceived[index].task.nameTask);
                          return CardTaskQualifield(
                              taskReceived: taskReceived, index: index);
                        },
                      ),
              ));
  }
}
