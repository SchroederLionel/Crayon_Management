import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Controls extends StatelessWidget {
  Controls({Key? key}) : super(key: key);

  _launchURL(BuildContext context) {
    ItemScrollController _scrollController = ItemScrollController();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Size size = new Size(width, height);
    String pdf = 'assets/test.pdf';
    showGeneralDialog(
        barrierColor: Colors.black,
        context: context,
        pageBuilder: (_, __, ___) {
          return Material(
            child: Stack(
              children: [
                Flexible(
                  child: PdfDocumentLoader.openAsset(
                    pdf,
                    documentBuilder: (context, pdfDocument, pageCount) =>
                        ScrollablePositionedList.builder(
                            minCacheExtent: 4,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemScrollController: _scrollController,
                            itemCount: pageCount,
                            itemBuilder: (context, index) => Container(
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
                ),
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
                            icon: Icon(
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
                            icon: Icon(
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
    bool isScreenWide = MediaQuery.of(context).size.width >= 650;

    return Flex(
      direction: isScreenWide ? Axis.horizontal : Axis.vertical,
      children: [
        CustomDropDown(),
        ElevatedButton.icon(
            onPressed: () => _launchURL(context),
            icon: Icon(Icons.open_in_browser),
            label: Text('Open Powerpoint')),
        CustomDropDown(),
        ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.open_in_browser),
            label: Text('Open Powerpoint')),
      ],
    );
  }
}

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({Key? key}) : super(key: key);
  final String dropdownValue = 'Introduction';
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? newValue) {},
        items: <String>['Introduction', 'Chapter 1', 'Chapter 2', 'Chapter 3']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList());
  }
}





/**
 * 
 * 


     /*FloatingActionButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Icon(Icons.close)),
              FloatingActionButton(
                child: Icon(Icons.first_page),
                onPressed: () => controller.ready?.goToPage(pageNumber: 1),
              ),
              FloatingActionButton(
                child: Icon(Icons.last_page),
                onPressed: () => controller.ready
                    ?.goToPage(pageNumber: controller.currentPageNumber),
              ),*/

 * 
 */
