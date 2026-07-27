import 'package:anyamar/views/reusable_widgets/form_elements/input_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final ValueChanged<String>? onSearch;
  final double? width;
  const SearchWidget({super.key, this.onSearch, this.width});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        width: width ?? 190, // Preferred width
        child: TextField(
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          decoration: CustomInputDecoration.textInputDecoration(
            hintText: 'Search',
            prefixIcon: const Icon(CupertinoIcons.search)
          ),

          
          // decoration: InputDecoration(
          //   hintText: 'Search',
          //   prefixIcon: const Icon(CupertinoIcons.search),
          //   border: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(10.0),
          //   ),
          // ),
          onChanged: onSearch,
        ),
      ),
    );
  }
}
