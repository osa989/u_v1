import 'package:flutter/material.dart';
import 'package:unheard_voices/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: purpleBlueColor,
        borderRadius:
            BorderRadius.circular(20.0), // Set your desired border radius here
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 10,
          end: 10,
        ),
        child: Column(
          children: [
            const Row(
              children: [
                SizedBox(
                  height: 75,
                ),
                Icon(
                  Icons.subject_outlined,
                  color: whiteColor,
                  size: 30,
                ),
                SizedBox(
                  width: 70,
                ),
                Text(
                  'Unheard Voices',
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  width: 68,
                ),
                Icon(
                  Icons.language,
                  color: whiteColor,
                  size: 26,
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsetsDirectional.only(
                      top: 10.0,
                      bottom: 10.0,
                      start: 13.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        25.0,
                      ),
                      color: whiteColor,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: Colors.grey,
                          size: 22.0,
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          'Search',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 14,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
