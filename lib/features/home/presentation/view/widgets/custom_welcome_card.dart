import 'package:flutter/material.dart';

class CustomWelcomeCard extends StatelessWidget {
  const CustomWelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: const Color(0x9D5D7AFA),
          child: ListTile(
            title: const Text("Welcome",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
            subtitle: const Text(
              "User",
              style: TextStyle(fontSize: 16),
            ),
            trailing: Image.asset(
              "assets/Images/user3.png",
              width: 45,
            ),
          )),
    );
  }
}
