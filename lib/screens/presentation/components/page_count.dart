import 'package:crayon_management/providers/presentation/page_count_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageCount extends StatelessWidget {
  const PageCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20, bottom: 20),
      alignment: Alignment.bottomRight,
      child: Consumer<PageCountProvider>(
        builder: (context, pageCountProvider, child) {
          if (pageCountProvider.showPageCount) {
            return Text(
              '${pageCountProvider.currentPageNumber + 1}/${pageCountProvider.totalPageCount}',
              style: const TextStyle(color: Colors.white24),
            );
          }
          return Container();
        },
      ),
    );
  }
}
