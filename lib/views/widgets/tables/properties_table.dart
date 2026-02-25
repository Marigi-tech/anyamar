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
        child: Text("Property", style: TextStyle(fontWeight: FontWeight.w200)),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text("Location", style: TextStyle(fontWeight: FontWeight.w200)),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text(
          "Managed By",
          style: TextStyle(fontWeight: FontWeight.w200),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text("Tenants", style: TextStyle(fontWeight: FontWeight.w200)),
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
  String location,
  String manager,
  String tenants,
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
          location,
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        child: Text(
          manager,
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        child: Text(
          tenants,
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
