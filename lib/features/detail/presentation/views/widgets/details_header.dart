import 'package:flutter/material.dart';

import '../../../../home/presentation/views/widgets/button_play.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsHeader extends StatelessWidget {
  const DetailsHeader({
    String? this.poster = '',
    String? this.backdrop = '',
    required String this.url,
    Key? key,
  }) : super(key: key);

  final String? poster;
  final String? backdrop;
  final String url;

  @override
  Widget build(BuildContext context) {
    final Uri _url = Uri.parse(url);
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
                onTap: () async {
                  if (!await launchUrl(_url)) {
                    throw 'Could not launch $_url';
                  }
                },
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
