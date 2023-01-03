import 'package:flutter/material.dart';

class CircleAvatarPage extends StatelessWidget {

  const CircleAvatarPage({ Key? key }) : super(key: key);

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Circle Avatar'),),
           body: Row(
             children: const [
               //Container(
               // width: 100,
               // height: 199,
               // child: const CircleAvatar(
               //   backgroundImage: NetworkImage('https://cdn.pensador.com/img/authors/ne/ls/nelson-piquet-l.jpg'),
               // ),
               //),
               ImageAvatar(urlImage: 'https://cdn.pensador.com/img/authors/ne/ls/nelson-piquet-l.jpg',texto: 'Piquet',),
               ImageAvatar(urlImage: 'https://estaticos.globoradio.globo.com/fotos/2019/05/6540f5a9-d6ce-4ea7-9580-f9e7276db803.jpg', texto: 'Niki Lauda')
             ],
           ),
       );
  }
}

class ImageAvatar extends StatelessWidget {

  final String urlImage;
  final String texto;

  const ImageAvatar({super.key, required this.urlImage, required this.texto});
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Colors.red,
                Colors.blue
              ],
              begin: Alignment.topCenter
            ),
            borderRadius: BorderRadius.circular(100),
            color: Colors.blue,
          ),          
        ),
        Container(
          width: 100,
          height: 100,
          padding: const EdgeInsets.all(5) ,
          child: CircleAvatar(
            backgroundImage: NetworkImage(urlImage),
          ),
        ),
        Container(
          width: 100,
          height: 105,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(100)
              ),
              
              child: Text(texto, style: const TextStyle(fontSize: 10, color: Colors.white),),
            ),
          ),
        )
      ],  
    );
  }

  

}