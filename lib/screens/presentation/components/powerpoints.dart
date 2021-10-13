import 'package:crayon_management/datamodels/confirmation_dialog_data.dart';
import 'package:crayon_management/providers/pdf_list_provider.dart';
import 'package:crayon_management/providers/pdf_provider.dart';
import 'package:crayon_management/screens/presentation/components/drop_zone.dart';
import 'package:crayon_management/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Powerpoints extends StatelessWidget {
  const Powerpoints({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pdfListProvider =
        Provider.of<PdfListProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
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
                      }).then((value) {
                    if (value != null) {
                      pdfListProvider.add(value);
                    }
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
          height: 50,
          child: Consumer<PdfListProvider>(
            builder: (context, pdfs, child) {
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: pdfs.getPdfsLength,
                itemBuilder: (context, index) {
                  return Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(pdfs.getPdfProvider(index).getTitle),
                        const SizedBox(
                          width: 30,
                        ),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      ConfirmationDialog(
                                          confirmationDialogData:
                                              ConfirmationDialogData(
                                                  title: 'Deletion',
                                                  cancelTitle: 'Cancel',
                                                  description:
                                                      'Are you sure you want to delete _________.',
                                                  acceptTitle: 'Yes')));
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ))
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
