import 'package:flutter/material.dart';

class CardMovie extends StatelessWidget {
  const CardMovie({
    Key? key,
    required Map<String, dynamic> this.movie,
  }) : super(key: key);
  final Map<String, dynamic> movie;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Movie 1');
      },
      child: Container(
        width: 190,
        height: 300,
        margin: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF292B37),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF292B37).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 6,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
                'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Movie Title Here',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 21,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Action/Adventure',
                    style: TextStyle(
                      color: Colors.white54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      SizedBox(width: 5),
                      Text(
                        '8.5',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
