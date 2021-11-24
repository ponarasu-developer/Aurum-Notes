import 'package:flutter/material.dart';

// ignore: camel_case_types
class emptylist extends StatelessWidget {
  const emptylist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.hourglass_empty_outlined,
              size: 70,
              color: Colors.greenAccent,
            ),
            const Text(
              'Hoo hoo !.Your list is empty ',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w200,
              ),
            )
          ],
        ),
      ),
    );
  }
}
