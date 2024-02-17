import 'package:flutter/material.dart';

class SignOfTheDay extends StatefulWidget {
  final String languageName;
  final String imageUrl;

  const SignOfTheDay({
    Key? key,
    required this.languageName,
    required this.imageUrl,
  }) : super(key: key);

  @override
  _SignOfTheDayState createState() => _SignOfTheDayState();
}

class _SignOfTheDayState extends State<SignOfTheDay> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sign of the Day',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                IconButton(
                  icon: Icon(
                    isFavorite
                        ? Icons.favorite
                        : Icons.favorite_outline_sharp,
                    size: 30,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Image.asset(
              widget.imageUrl,
              height: 200.0,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
