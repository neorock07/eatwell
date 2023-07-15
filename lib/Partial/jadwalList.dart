import 'package:flutter/material.dart';

Future setBtmJadwal(BuildContext context,
    {String? name,
    BuildContext? btmContex,
    String? kalori,
    String? confidence,
    String? user_key,
    String? food_key}) {
  return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      builder: (context) {
        btmContex = context;
        return SizedBox(
          child: Wrap(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("hushdushdushdsuhsudh"),
                Text("hushdushdushdsuhsudh"),
                Text("hushdushdushdsuhsudh"),
                Text("hushdushdushdsuhsudh"),
                Text("hushdushdushdsuhsudh"),
                Text("hushdushdushdsuhsudh"),
                Text("hushdushdushdsuhsudh"),
                Text("hushdushdushdsuhsudh"),
                Text("hushdushdushdsuhsudh"),
              ],
            ),
          ]),
        );
      });
}
