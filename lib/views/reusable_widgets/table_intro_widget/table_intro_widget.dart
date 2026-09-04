import 'package:flutter/cupertino.dart';
import 'package:anyamar/commons/constants.dart';
import 'package:anyamar/responsiveness/screen_size.dart';
import 'package:anyamar/views/reusable_widgets/buttons/card_button_widget.dart';
import 'package:anyamar/views/reusable_widgets/search_widget/search_widget.dart';

class TableIntroWidget extends StatelessWidget {
  final String dataLength;
  final String dataType;
  final VoidCallback? onPressedCallBack;
  final ValueChanged<String> onSearch;
  final bool? hasSearchBar;
  final List<Widget>? customWidgets;
  const TableIntroWidget({
    super.key,
    required this.dataLength,
    required this.onSearch,
    required this.dataType,
    this.onPressedCallBack,
    this.hasSearchBar = false,
    this.customWidgets,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Filter through table data
          Visibility(
            visible: hasSearchBar == true ? true : false,
            child: SearchWidget(
              onSearch: onSearch,
              width: getSizeFromContext(context).width / 3,
            ),
          ),
          SizedBox(width: 20.0),
          Row(
            children:
                customWidgets ??
                [
                  CardButtonWidget(
                    buttonTitle: 'Add $dataType',
                    buttonIcon: CupertinoIcons.add,
                    onPressedCallBack: onPressedCallBack,
                  ),
                  SizedBox(width: 10),

                  //Search

                  //No of var $dataType
                  Text(
                    dataLength,
                    style: CustomTextStyles.cardDescriptionStyle,
                  ),
                  SizedBox(width: 5),
                  Text(dataType, style: CustomTextStyles.greenText),
                ],
          ),
        ],
      ),
    );
  }
}
