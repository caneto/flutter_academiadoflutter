import 'package:flutter/material.dart';

class ButtonCard extends StatelessWidget {
  final String textOption;
  final VoidCallback? onTap;

  const ButtonCard({Key? key, required this.textOption, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      width: 180,
      height: 180,
      child: Center(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: onTap,
              child: Card(
                elevation: 3,
                shadowColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.deepPurpleAccent),
                  borderRadius: BorderRadius.circular(30),
                ),
                color: Colors.grey[100],
                child: SizedBox(
                  width: 160,
                  height: 160,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          textOption,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
