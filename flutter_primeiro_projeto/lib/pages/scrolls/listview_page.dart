import 'package:flutter/material.dart';

class ListviewPage extends StatelessWidget {
  const ListviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List View'),
      ),
      //body: ListView.builder(
      //itemCount: 10,
      //itemBuilder: (context, index) {
      //  return ListTile(
      //    title: Text('Indice $index'),
      //    subtitle: Text('Flutter é TOP'),
      //    leading: CircleAvatar(),
      //  );
      //}
      body: ListView.separated(
          itemCount: 100,
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.red,
              thickness: 2,
            );
          },
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Indice $index'),
              subtitle: const Text('Flutter é TOP'),
              leading: const CircleAvatar(
                backgroundImage: NetworkImage('https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png'),
              ),
              trailing: Icon(Icons.delete),
            );
          }),
    );
  }
}
