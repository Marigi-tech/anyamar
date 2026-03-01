import 'package:flutter/cupertino.dart';
import 'package:test_app/data/constants.dart';
import 'package:test_app/responsiveness/screen_size.dart';

import 'package:test_app/views/widgets/buttons/card_button_widget.dart';
import 'package:test_app/views/widgets/search_widget/search_widget.dart';

class TableIntroWidget extends StatelessWidget {
  final String dataLength;
  final String dataType;
  final VoidCallback? onPressedCallBack;
  final ValueChanged<String> onSearch;
  const TableIntroWidget({
    super.key,
    required this.dataLength,
    required this.onSearch,
    required this.dataType,
    this.onPressedCallBack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Filter through table data
        SearchWidget(
          onSearch: onSearch,
          width: getSizeFromContext(context).width / 3,
        ),
        SizedBox(width: 10.0),
        Row(
          children: [
            CardButtonWidget(
              buttonTitle: 'Add $dataType',
              buttonIcon: CupertinoIcons.add,
              onPressedCallBack: onPressedCallBack,
            ),
            SizedBox(width: 5),

            //Search

            //No of units
            Text(dataLength, style: CustomTextStyles.cardDescriptionStyle),
            SizedBox(width: 5),
            Text(dataType, style: CustomTextStyles.greenText),
          ],
        ),
      ],
    );
  }
}
