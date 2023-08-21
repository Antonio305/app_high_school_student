import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prepa_estudiantes/services/student_services.dart';
import 'package:prepa_estudiantes/src/widgets/material_button.dart';

import 'dart:io' show Platform;

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
// creamos una lista de los menu


  @override
  Widget build(BuildContext context) {
    const style1 = TextStyle(fontSize: 14, color: Colors.white70);
    final size = MediaQuery.of(context).size;

    return Container(
      color: const Color(0xff1C1D21),
      width: size.width * 0.23,
      height: size.height,
    );
  }
}

class Profile extends StatefulWidget {
  const Profile({
    Key? key,
    required this.style1,
  }) : super(key: key);

  final TextStyle style1;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final studentServices = Provider.of<StudentServices>(context);
    final student = studentServices.student;

    return GestureDetector(
      onTap: () {
        // intanice loginServices for token
        // final loginServices = LoginServices();
        // // Provider.of<LoginServices>(context, listen: false);

        // String? token = await loginServices.myTokenID();

        // final studentServides =
        //     Provider.of<StudentServices>(context, listen: false);

        // await studentServides.getStudentForID(token!);
        Navigator.pushNamed(context, 'profile');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  "https://imagesvc.meredithcorp.io/v3/mm/image?url=https:%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2020%2F02%2Fkatherine-johnson.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
              student.name +
                  "  " +
                  student.lastName +
                  "  " +
                  student.secondName,
              style: widget.style1),
          Text(
            'hitler_aleman@gmail.com',
            style: widget.style1,
          ),
        ],
      ),
    );
  }
}
