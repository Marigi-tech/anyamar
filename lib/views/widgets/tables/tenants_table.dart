import 'package:test_app/data/constants/commons.dart';
import 'package:test_app/views/widgets/tables/view_chevron_card.dart';

TableRow buildHeaderRow() {
  return TableRow(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text("", style: TextStyle(fontWeight: FontWeight.w200)),
      ),

      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text("Full Name", style: TextStyle(fontWeight: FontWeight.w200)),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text(
          "Phone Number",
          style: TextStyle(fontWeight: FontWeight.w200),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text("Unit ", style: TextStyle(fontWeight: FontWeight.w200)),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text(
          "Property name",
          style: TextStyle(fontWeight: FontWeight.w200),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text("View", style: TextStyle(fontWeight: FontWeight.w200)),
      ),
    ],
  );
}

TableRow buildDataRow(
  int index,
  String name,
  String phoneNumber,
  String unit,
  String propertyName,
) {
  return TableRow(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Text(
          '  $index  ',
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        child: Text(
          name,
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),

      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        child: Text(
          phoneNumber,
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        child: Text(
          unit,
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        child: Text(
          propertyName,
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        child: ViewChevronCard(onPressedCallBack: () {}),
      ),
    ],
  );
}
