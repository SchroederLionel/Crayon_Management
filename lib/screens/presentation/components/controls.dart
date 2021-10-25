import 'package:crayon_management/providers/slide_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Controls extends StatelessWidget {
  Controls({Key? key}) : super(key: key);

  _launchURL(BuildContext context, SlideDataProvider currentSelectedPDF) {
    ItemScrollController _scrollController = ItemScrollController();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    showGeneralDialog(
        barrierColor: Colors.black,
        context: context,
        pageBuilder: (_, __, ___) {
          return Material(
            child: Stack(
              children: [
                Flexible(child: Container()),
                Center(
                  child: Container(
                    color: Colors.blue,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              _scrollController.scrollTo(
                                  index: 1,
                                  duration: Duration(milliseconds: 200));
                            },
                            icon: const Icon(
                              Icons.arrow_left,
                              color: Colors.black,
                              size: 24,
                            )),
                        IconButton(
                            onPressed: () {
                              _scrollController.scrollTo(
                                  index: 2,
                                  duration: Duration(milliseconds: 200));
                            },
                            icon: const Icon(
                              Icons.arrow_right,
                              color: Colors.black,
                              size: 24,
                            )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });

    //
  }

  @override
  Widget build(BuildContext context) {
    var translation = AppLocalizations.of(context);
    bool isScreenWide = MediaQuery.of(context).size.width >= 650;
    SlideDataProvider? currentSelectedProvider;
    return Container();
  }
}



/**
 * 
 PdfDocumentLoader.openData(
                    Uint8List(),
                    documentBuilder: (context, pdfDocument, pageCount) =>
                        ScrollablePositionedList.builder(
                            minCacheExtent: 4,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemScrollController: _scrollController,
                            itemCount: pageCount,
                            itemBuilder: (context, index) => SizedBox(
                                  width: width,
                                  child: PdfPageView(
                                    pageBuilder: (context,
                                        PdfPageTextureBuilder textureBuilder,
                                        pageSize) {
                                      return textureBuilder();
                                    },
                                    //pdfDocument: pdfDocument,
                                    pageNumber: index + 1,
                                  ),
                                )),
                    onError: (err) {
                      print(err);
                    },
                  ),
  return Flex(
      direction: isScreenWide ? Axis.horizontal : Axis.vertical,
      children: [
        Consumer<PdfListProvider>(
            builder: (context, PdfListProvider pdfs, child) {
          if (pdfs.getPdfs.isNotEmpty) {
            currentSelectedProvider = pdfs.getPdfs.first;
            return Row(
              children: [
                DropdownButton<PdfProvider>(
                    value: pdfs.getPdfs.first,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 18,
                    elevation: 16,
                    style: Theme.of(context).textTheme.bodyText1,
                    underline: Container(
                      height: 2,
                      color: Colors.blueAccent,
                    ),
                    onChanged: (PdfProvider? file) {
                      currentSelectedProvider = file!;
                    },
                    items: pdfs.getPdfs.map<DropdownMenuItem<PdfProvider>>(
                        (PdfProvider singlePdf) {
                      return DropdownMenuItem<PdfProvider>(
                        value: singlePdf,
                        child: Text(singlePdf.getTitle),
                      );
                    }).toList()),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton.icon(
                    onPressed: () =>
                        _launchURL(context, currentSelectedProvider!),
                    icon: const Icon(Icons.open_in_browser),
                    label: Text(translation!.openSlide)),
              ],
            );
          } else {
            return Container();
          }
        }),
      ],
    );


 */