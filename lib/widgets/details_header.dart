import 'package:flutter/material.dart';

import '../features/home/presentation/views/widgets/button_play.dart';

class DetailsHeader extends StatelessWidget {
  const DetailsHeader({
    String? this.poster = '',
    String? this.backdrop = '',
    Key? key,
  }) : super(key: key);
  final String? poster;
  final String? backdrop;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.43,
        ),
        ClipRRect(
            child: backdrop != null
                ? FadeInImage.assetNetwork(
                    placeholder: 'assets/logotipoplanet.png',
                    image: 'https://image.tmdb.org/t/p/w500$backdrop',
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.35,
                    fit: BoxFit.fill,
                  )
                : Image.asset(
                    'assets/logotipoplanet.png',
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.35,
                    fit: BoxFit.fill,
                  )),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.18,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ClipRRect(
                    child: poster != null
                        ? FadeInImage.assetNetwork(
                            placeholder: 'assets/logotipoplanet.png',
                            image: 'https://image.tmdb.org/t/p/w500$poster',
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: MediaQuery.of(context).size.height * 0.28,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/logotipoplanet.png',
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.35,
                            fit: BoxFit.fill,
                          )),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
              ),
              ButtonPlay(
                onTap: () {},
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
            ),
            const Icon(
              Icons.favorite_border,
              color: Colors.white,
              size: 30,
            ),
          ],
        ),
      ],
    );
  }
}
