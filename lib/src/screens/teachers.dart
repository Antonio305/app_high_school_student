import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prepa_estudiantes/services/subject_services.dart';

class ScreenlistTeacher extends StatelessWidget {
  const ScreenlistTeacher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subjectServices = Provider.of<SubjectServices>(context);
    final subjects = subjectServices.subjects;
     Color  colorText = Colors.white54;
    return Scaffold(
      backgroundColor: const Color(0xff1C1D21),
      appBar: AppBar(
                backgroundColor: const Color(0xff1C1D21),

        // backgroundColor: const Color(0xff1C1D21),
        title:  Text(
          'PROFESORES',
          style: TextStyle(fontSize: 18 , color: colorText),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: subjects.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'profile_teacher',
                    arguments: subjects[index].teachers);
              },
              title: Text(
                subjects[index].teachers.name +
                    " " +
                    subjects[index].teachers.lastName +
                    " " +
                    subjects[index].teachers.secondName,
                style: const TextStyle(fontSize: 13),
              ),
              subtitle: Text(
                subjects[index].teachers.collegeDegree,
                style: const TextStyle(fontSize: 12),
              ),
              leading: CircleAvatar(
                // backgroundImage: ,
                // radius: 90.0,
                // backgroundColor: Colors.blueAccent,
                child: Text(subjects[index].teachers.name.substring(0, 1)),
              ),
              trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.chevron_right_rounded)),
            );
          },
        ),
      ),
    );
  }
}
