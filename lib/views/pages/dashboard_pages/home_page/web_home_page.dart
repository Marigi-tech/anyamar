// import 'package:test_app/data/constants/commons.dart';
// import 'package:test_app/views/pages/dashboard_pages/home_page/intro_card_list.dart';
// import 'package:test_app/views/widgets/dashboard_widgets/chats_card_widget.dart';
// import 'package:test_app/views/widgets/dashboard_widgets/property_information_card_widget.dart';
// import 'package:test_app/views/widgets/dashboard_widgets/intro_text_widget.dart';
// import 'package:test_app/views/widgets/dashboard_widgets/tenant_information_card_widget.dart';

// class WebHomePage extends StatefulWidget {
//   const WebHomePage({super.key});

//   @override
//   State<WebHomePage> createState() => _WebHomePageState();
// }

// class _WebHomePageState extends State<WebHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         SizedBox(height: 10.0),
//         IntroTextWidget(dashboardItem: 'Dashboard'),
//         SizedBox(height: 20.0),
//         // row of information cards
//         SizedBox(
//           height: 150,
//           width: double.infinity,
//           child: ListView(
//             shrinkWrap: true,
//             physics: ClampingScrollPhysics(),
//             scrollDirection: Axis.horizontal,
//             children: introCardsList.map((card) {
//               return card;
//             }).toList(),
//           ),
//         ),
//         //Property and Tenant tables
//         SizedBox(height: 10.0),
//         Responsiveness.isDesktop(context)
//             ? SizedBox(
//                 width: double.infinity,
//                 height: getSizeFromContext(context).height / 2,
//                 child: Row(
//                   children: [
//                     Expanded(flex: 2, child: PropertyInformationCardWidget()),
//                     Expanded(child: TenantInformationCardWidget()),
//                   ],
//                 ),
//               )
//             : Column(
//                 children: [
//                   PropertyInformationCardWidget(),
//                   TenantInformationCardWidget(),
//                 ],
//               ),
//         SizedBox(height: 10.0),
//         //Chats & Finances
//         Row(
//           children: [
//             SizedBox(
//               width: double.infinity,
//               height: getSizeFromContext(context).height * .70,
//               child: Row(
//                 children: [
//                   Expanded(child: ChatsCardWidget()),
//                   Expanded(flex: 2, child: TenantInformationCardWidget()),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
