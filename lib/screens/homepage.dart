import 'package:flutter/material.dart';
import 'package:portfolio/screens/window.dart';
import 'package:portfolio/widgets/dock.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children:  [
            //   Desktop(),
            //Windower(),

            Window(
              child: Container(
               color: Colors.red,
                child: SizedBox.square(
                  dimension: 200,
                  child: Text(
                  	'aoe',
                  	style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

            Dock(),
          ],
        ),
      ),
    );
  }
}
