import 'package:flutter/material.dart';

class CardCharactersCustom extends StatelessWidget {
  final String? image;
  final String? name;
  final int? id;

  const CardCharactersCustom({super.key, required this.image, required this.name, required this.id});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        ClipOval(
          child: Image.network(
            image!,
            height: 80,
            width: 80,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: Text(
            '#$id-$name',
            softWrap: true,
            maxLines: 2,
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontFamily: "GentiumPlus",
            ),
          ),
        ),
      ],
    );
  }
}
