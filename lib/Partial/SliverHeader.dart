import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SliverHeader extends SliverPersistentHeaderDelegate {
  static Widget searchView(BuildContext context,
      {String? hint, TextEditingController? controller}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: const Color.fromARGB(255, 240, 240, 240),
        child: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: TextField(
            controller: controller,
            onSubmitted: (String txt) async {
              controller!.text = txt;
            },
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 2, right: 12, top: 15),
                hintText: (hint != null) ? hint : "Cari makanan",
                border: InputBorder.none,
                suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      LucideIcons.delete,
                      color: Colors.lightGreen,
                    )),
                icon: Icon(
                  LucideIcons.search,
                  color: Colors.grey[500],
                ),
                hintStyle: const TextStyle(
                    fontFamily: "serif", fontWeight: FontWeight.normal)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: searchView(context),
    );
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
