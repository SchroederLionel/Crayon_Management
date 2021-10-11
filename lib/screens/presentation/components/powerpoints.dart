import 'package:crayon_management/providers/pdf_provider.dart';
import 'package:crayon_management/screens/presentation/components/drop_zone.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              'Slides',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ListenableProvider<PdfProvider>(
                          create: (context) => PdfProvider(),
                          child: DropZone(),
                        );
                      });
                },
                icon: Icon(Icons.add),
                label: Text('Add Slide'))
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
