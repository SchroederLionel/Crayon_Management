class ConfirmationDialogData {
  String? title;
  String? description;
  String? cancelTitle;
  String? acceptTitle;
  late String itemTitle;
  ConfirmationDialogData(
      {this.title,
      this.description,
      this.cancelTitle,
      this.acceptTitle,
      required this.itemTitle});
}
