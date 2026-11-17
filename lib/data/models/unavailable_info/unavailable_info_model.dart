import 'package:anyamar/commons/exports.dart';

class UnavailableInfoModel {
  final Widget ctaButtonWidget;
  final String text;
  final String supplementaryText;
  final VoidCallback closeMethod;

  UnavailableInfoModel({
    required this.ctaButtonWidget,
    required this.text,
    required this.supplementaryText,
    required this.closeMethod,
  });
}
