import 'package:flutter/material.dart';

//==========This widget isn't used cause we have used on_Audio_query instead of listView Builder==========//

Widget SongListItems({
  required songThumb,
  required albumName,
  required songName,
  required artistName,
  //required time,
}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Container(
          height: 100,
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
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    image: DecorationImage(
                      image: AssetImage(songThumb),
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
                      songName,
                      style: const TextStyle(
                          fontFamily: "Montserrat Alter1",
                          fontSize: 20,
                          fontWeight: FontWeight.w300),
                    ),
                    const Spacer(flex: 1),
                    Text(
                      albumName,
                      style: const TextStyle(
                          fontFamily: "Montserrat Alter1",
                          fontSize: 15,
                          fontWeight: FontWeight.w100),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Text(
                      artistName,
                      style: const TextStyle(
                          fontFamily: "Montserrat Alter1",
                          fontSize: 15,
                          fontWeight: FontWeight.w100),
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
                  children: const [
                    Spacer(
                      flex: 2,
                    ),
                    Icon(
                      Icons.favorite_border_outlined,
                      color: Colors.black,
                      size: 28,
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Icon(
                      Icons.add_circle_outline_outlined,
                      color: Colors.black,
                      size: 28,
                    ),
                    Spacer(
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
