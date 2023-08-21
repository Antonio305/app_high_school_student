import 'package:flutter/material.dart';

class DetailsClass extends StatelessWidget {
  const DetailsClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;
    
          //  final List = [const ChatGrupal(), const Detalle()];


    return Scaffold(
      appBar: AppBar(
                backgroundColor: const Color(0xff1C1D21),
        title: const Text('Detalle de la clase class'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
                 width: double.infinity,
                  color: const Color(0xff1C1D21),
          child: Column(children: [
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                
                children: [
                
                Container(color:const Color(0xff242529),
                  
                  width: size.width * .49,
                  height: 50,
                  child: MaterialButton(
                  
                    onPressed: () {},
                    child: const Text('CHAT GRUPAL'),
                  ),
                ),
                  Container(
                    color: Colors.white,
                    height: 50,
                    width:.5,
                  ),
                Container(
                  color:const Color(0xff242529),
                  width: size.width * .50,
                  height: 50,
                  child: MaterialButton(
                    onPressed: () {},
                    child: const Text('Detalles'),
                  ),
                ),

              ],),
            ),
          ]),
        ),
      ),
    );
  }
}






class ChatGrupal extends StatelessWidget {
  const ChatGrupal({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(children: [
          const Text('CHAT VACIO'),
            MaterialButton(onPressed: (){},
            child: const Text('INICIAR CHAT'),
            )
        ],),
      ),
      
    );
  }
}




class Detalle extends StatelessWidget {
  const Detalle({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     

       child: const Text('deatalles'),
      
    );
  }
}