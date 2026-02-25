import 'package:flutter/cupertino.dart';
import 'package:test_app/data/constants/commons.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        width: 190, // Preferred width
        child: TextField(
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: const Icon(CupertinoIcons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onEditingComplete: () => setState(() {}),
        ),
      ),
    );
  }
}
