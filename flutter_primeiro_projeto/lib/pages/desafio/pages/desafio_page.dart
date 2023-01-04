import 'package:flutter/material.dart';

import '../models/posts_model.dart';

class DesafioPage extends StatefulWidget {

  const DesafioPage({ Key? key }) : super(key: key);

  @override
  State<DesafioPage> createState() => _DesafioPageState();
}

class _DesafioPageState extends State<DesafioPage> {
   
   @override
   Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 249, 249, 249),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
                  'Instagram',
                  style: TextStyle(
                    fontFamily: 'Billabong',
                    fontSize: 40.0,
                    color: Colors.black,
                  ),
                ),
           actions: [
            IconButton(
              icon: Image.asset(
                       'assets/images/more.png',
                       color: Colors.black,
                       width: 22,
                       height: 22,
              ),
              onPressed: () => print('ok'),
            ),
            IconButton(
              icon: const Icon(Icons.favorite_border_outlined, color: Colors.black),
              iconSize: 28.0,
              onPressed: () => print('ok'),
            ),
            IconButton(
              icon: const Icon(Icons.message_outlined, color: Colors.black),
              iconSize: 28.0,
              onPressed: () => print('ok ok '),
            ),  
          ],
        ),
        body: mainList(),
        bottomNavigationBar: mainPage(),
      );
  }

  ListView mainList() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: <Widget>[
        const SizedBox(
           height: 5,
        ),
        Container(
          width: double.infinity,
          height: 100.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: stories.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return const SizedBox(width: 10.0);
              }
              return ImageAvatar(urlImage: stories[index -1].userAvatar, texto: stories[index - 1].user);
              //Container(
                //margin: const EdgeInsets.all(10.0),
                //width: 65.0,
                //height: 65.0,
                //decoration: const BoxDecoration(
                //  shape: BoxShape.circle,
                //  boxShadow: [
                //    BoxShadow(
                //      color: Colors.black45,
                //      offset: Offset(0, 2),
                //      blurRadius: 6.0,
                //    ),
                //  ],
                //),
               // child: CircleAvatar(
                //  child: ClipOval(
                //    child: Image(
                //      height: 63.0,
                //      width: 63.0,
                //      image: AssetImage(stories[index - 1]),
                //      fit: BoxFit.cover,
                //    ),
                //),
                //),
              //);
            },
          ),
        ),
        _post(0),
        _post(1),
      ],
    );
  }

   ClipRRect mainPage() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30.0,
              color: Colors.black,
            ),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 30.0,
              color: Colors.black,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
                  'assets/images/reels.png',
                    width: 26, 
                    height: 26,
                  ),
            label: 'reels',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_bag_outlined,
              size: 30.0,
              color: Colors.black,
            ),
            label: 'Shop',
          ),
          const BottomNavigationBarItem(
            icon: CircleAvatar(
              child: ClipOval(
                child: Image(
                  height: 63.0,
                  width: 63.0,
                  image: AssetImage('assets/images/post_image1.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget _post(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      child: Container(
        width: double.infinity,
        height: 560.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        child: ClipOval(
                          child: Image(
                            height: 50.0,
                            width: 50.0,
                            image: AssetImage(posts[index].userAvatar),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      posts[index].user,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(posts[index].timeAgo),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert),
                      padding: const EdgeInsets.only(left: 25),
                      color: Colors.black,
                      onPressed: () => print('ok'),
                    ),
                  ),
                  InkWell(
                    onDoubleTap: () => print('Like'),
                    onTap: () {
                      //Navigator.push(
                      //  context,
                      //  MaterialPageRoute(
                      //    builder: (_) => ViewPostScreen(
                      //      post: posts[index],
                      //    ),
                      //  ),
                      //);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(0.0),
                      width: double.infinity,
                      height: 400.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 5),
                            blurRadius: 8.0,
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage(posts[index].imageUrl),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: const Icon(Icons.favorite_border),
                                  iconSize: 28.0,
                                  onPressed: () => print('Like post'),
                                ),
                                IconButton(
                                  icon: Image.asset(
                                    'assets/images/chat.png',
                                      color: Colors.black,
                                      width: 25,
                                      height: 25,
                                    ),
                                  iconSize: 30.0,
                                  onPressed: () => print('mail'),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Image.asset(
                                    'assets/images/send.png',
                                       color: Colors.black,
                                      width: 25,
                                      height: 25,
                                    ),
                                  iconSize: 30.0,
                                  onPressed: () {
                                    //Navigator.push(
                                    //  context,
                                    //  MaterialPageRoute(
                                    //    builder: (_) => ViewPostScreen(
                                    //      post: posts[index],
                                    //    ),
                                    //  ),
                                    //);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.bookmark_border),
                          iconSize: 30.0,
                          onPressed: () => print('ok saved'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
          width: 80,
          height: 80,
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
          width: 80,
          height: 80,
          padding: const EdgeInsets.all(3) ,
          child: ClipOval(
                  child: Image(
                    height: 60.0,
                    width: 60.0,
                    image: AssetImage(urlImage),
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        Container(
          width: 85,
          height: 105,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(5)
              ),
              
              child: Text(texto, style: const TextStyle(fontSize: 10, color: Colors.white),),
            ),
          ),
        )
      ],  
    );
  }

}