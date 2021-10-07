import 'package:flutter/material.dart';

class Powerpoints extends StatelessWidget {
  const Powerpoints({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Powerpoint',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.add),
                label: Text('Add powerpoint'))
          ],
        ),
        const SizedBox(
          height: 14,
        ),
        Container(
          height: 150,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 30,
            itemBuilder: (context, index) {
              return Container(
                height: 150,
                width: 300,
                child: Card(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('PDF $index'),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                              ))
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Text('Introduction');
                            }),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
