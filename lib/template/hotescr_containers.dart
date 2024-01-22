// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class MoreInfoContainer extends StatelessWidget {
  const MoreInfoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(15)),
      child: Column(children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image(
                    image: AssetImage('assets/icons/emoji-happy.png'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Удобства',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Самое необходимое',
                        style: TextStyle(
                            color: Color.fromARGB(1000, 130, 135, 150)),
                      )
                    ],
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image(
                    image: AssetImage('assets/icons/tick-square.png'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Что включено',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Самое необходимое',
                        style: TextStyle(
                            color: Color.fromARGB(1000, 130, 135, 150)),
                      )
                    ],
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image(
                    image: AssetImage('assets/icons/close-square.png'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Что не включено',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Самое необходимое',
                        style: TextStyle(
                            color: Color.fromARGB(1000, 130, 135, 150)),
                      )
                    ],
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        )
      ]),
    );
  }
}

class RatingContainer extends StatelessWidget {
  var rating;
  var ratingName;
  RatingContainer({required this.rating, required this.ratingName, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color.fromARGB(100, 255, 199, 0)),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            const Icon(
              Icons.star,
              color: Colors.orange,
              size: 20,
            ),
            Text(
              '$rating $ratingName',
              style: const TextStyle(
                  color: Color.fromARGB(1000, 255, 168, 0),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ));
  }
}
