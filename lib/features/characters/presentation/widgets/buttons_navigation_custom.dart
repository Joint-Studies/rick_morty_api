// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ButtonsNavigationCustom extends StatelessWidget {
  final String prev;
  final String next;
  final int current;
  final int? page;
  final VoidCallback onPressedPrev;
  final VoidCallback onPressedNext;

  const ButtonsNavigationCustom({
    super.key,
    required this.prev,
    required this.next,
    required this.current,
    required this.page,
    required this.onPressedPrev,
    required this.onPressedNext,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: onPressedPrev,
            child: Text(prev),
          ),
          Container(
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
              ),
              child: Row(
                children: [
                  Text('$current  |'),
                  Text(
                    ' $page',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )),
          ElevatedButton(
            onPressed: onPressedNext,
            child: Text(next),
          ),
        ],
      ),
    );
  }
}

/*
 Positioned(
                  bottom: 20,
                  left: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<CharactersCubit>().getNextPage();
                    },
                    child: Text('Anterior'),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 40,
                  child: Text(
                    '${state.responseEntity.infoEntity?.pages}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: ElevatedButton(
                    onPressed: () async {
                      context.read<CharactersCubit>().getNextPage();
                    },
                    child: Text('Proxima'),
                  ),
                ),*/
