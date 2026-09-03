import 'package:flutter/cupertino.dart';
import 'package:graduateproject/utils/Appimages.dart';
import 'package:graduateproject/utils/colors.dart';

class Language extends StatelessWidget {
  const Language({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                  width: 92,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Appcolor.black,
                    border: Border.all(color:Appcolor.yellow, width: 3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipOval(
                        child: Image.asset(
                          Appimages.Eg,
                          width: 28,
                          height: 28,
                          fit: BoxFit.cover,
                        ),
                      ),
          
                      ClipOval(
                        child: Image.asset(
                          Appimages.LR,
                          width: 28,
                          height: 28,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                );
  }
}