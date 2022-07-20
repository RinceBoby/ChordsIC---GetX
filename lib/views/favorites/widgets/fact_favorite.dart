import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Favorites extends StatelessWidget {
  final favThumb;
  final favSongName;
  final favArtistAlbum;
  final favTime;

  const Favorites(
      {Key? key,
      required this.favThumb,
      required this.favSongName,
      required this.favArtistAlbum,
      required this.favTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 0.3,
                  blurRadius: 1,
                  offset: const Offset(3, 3),
                ),
              ],
              gradient: LinearGradient(
                colors: [
                  Colors.purpleAccent.withOpacity(0.3),
                  Colors.purpleAccent.withOpacity(0.015),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(50),
                      ),
                      image: DecorationImage(
                        image: AssetImage(favThumb),
                      ),
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(
                        flex: 2,
                      ),
                      Text(
                        favSongName,
                        style: const TextStyle(
                            fontFamily: "Montserrat Alter1",
                            fontSize: 20,
                            fontWeight: FontWeight.w300),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Text(
                        favArtistAlbum,
                        style: GoogleFonts.nunito(
                          fontSize: 15,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(
                        flex: 2,
                      ),
                      const Icon(
                        Icons.favorite,
                        color: Colors.redAccent,
                        size: 28,
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Text(
                        favTime,
                        style: const TextStyle(
                            fontFamily: "Montserrat Alter1",
                            fontWeight: FontWeight.w200,
                            color: Colors.grey),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
