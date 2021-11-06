import 'package:crayon_management/providers/presentation/page_count_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class PresentationControls extends StatelessWidget {
  final ItemScrollController scrollController;
  const PresentationControls({required this.scrollController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageCountProvider =
        Provider.of<PageCountProvider>(context, listen: false);
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                pageCountProvider.deacreasePageCount();
                scrollController.scrollTo(
                    index: pageCountProvider.currentPageNumber,
                    duration: const Duration(milliseconds: 250));
              },
              icon: const Icon(
                Icons.arrow_left,
                color: Colors.white24,
                size: 24,
              )),
          IconButton(
              onPressed: () {
                pageCountProvider.increasePageCount();
                scrollController.scrollTo(
                    index: pageCountProvider.currentPageNumber,
                    duration: const Duration(milliseconds: 250));
              },
              icon: const Icon(
                Icons.arrow_right,
                color: Colors.white24,
                size: 24,
              )),
        ],
      ),
    );
  }
}
