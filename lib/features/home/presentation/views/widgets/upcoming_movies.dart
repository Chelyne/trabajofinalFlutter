import 'package:flutter/material.dart';

class UpcomingMovies extends StatelessWidget {
  const UpcomingMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Upcoming Movies',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 28,
                ),
              ),
              Text(
                'See All',
                style: TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    'https://laverdadnoticias.com/__export/1655819964975/sites/laverdad/img/2022/06/21/spy_x_family_viral_anya_forger_con_rasgos_biologicos_de_loid_y_yor.jpeg_1899857922.jpeg',
                    height: 180,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    'https://laverdadnoticias.com/__export/1655819964975/sites/laverdad/img/2022/06/21/spy_x_family_viral_anya_forger_con_rasgos_biologicos_de_loid_y_yor.jpeg_1899857922.jpeg',
                    height: 180,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}