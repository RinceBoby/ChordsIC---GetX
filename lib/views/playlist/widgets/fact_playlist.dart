// import 'package:chordsic/interfaces/3%20favorite.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class PlayList extends StatelessWidget {
//   final plThumb;
//   final plTitle;
//   final plSongsNo;
//   final index;

//   const PlayList({
//     Key? key,
//     required this.plThumb,
//     required this.plTitle,
//     required this.plSongsNo,
//     required this.index,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         onOnTap(index, context);
//       },
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//             child: Container(
//               height: 100,
//               decoration: BoxDecoration(
//                 borderRadius: const BorderRadius.all(
//                   Radius.circular(10),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.2),
//                     spreadRadius: 0.3,
//                     blurRadius: 1,
//                     offset: const Offset(3, 3),
//                   ),
//                 ],
//                 gradient: LinearGradient(
//                   colors: [
//                     Colors.purpleAccent.withOpacity(0.3),
//                     Colors.purpleAccent.withOpacity(0.015),
//                   ],
//                   begin: Alignment.bottomCenter,
//                   end: Alignment.topCenter,
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 20),
//                     child: Container(
//                       height: 60,
//                       width: 60,
//                       decoration: BoxDecoration(
//                         borderRadius: const BorderRadius.all(
//                           Radius.circular(50),
//                         ),
//                         image: DecorationImage(
//                           image: AssetImage(plThumb),
//                         ),
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Spacer(flex: 2),
//                         Text(
//                           plTitle,
//                           style: GoogleFonts.nunito(
//                             fontSize: 22,
//                             letterSpacing: 1,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const Spacer(),
//                         Text(
//                           plSongsNo,
//                           style: GoogleFonts.nunito(
//                             fontSize: 20,
//                             letterSpacing: 1,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                         const Spacer(
//                           flex: 2,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   onOnTap(int index, BuildContext context) {
//     if (index == 1) {
//       Navigator.of(context).push(MaterialPageRoute(
//         builder: (ctx) => const Favorite(),
//       ));
//     } else if (index == 3) {
//       Navigator.of(context).push(MaterialPageRoute(
//         builder: (ctx) => const Favorite(),
//       ));
//     }
//   }
// }



// //Create New Plylist

