import 'package:flutter/cupertino.dart';
import 'package:test_app/data/constants/commons.dart';

class AiWidget extends StatefulWidget {
  const AiWidget({super.key});

  @override
  State<AiWidget> createState() => _AiWidgetState();
}

class _AiWidgetState extends State<AiWidget> {
  bool introCardIsHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (event) => setState(() => introCardIsHovered = true),
      onExit: (event) => setState(() => introCardIsHovered = false),
      child: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: Card(
            elevation: introCardIsHovered ? 10.0 : 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 10.0,
              ),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.chat_bubble,
                    size: 14,
                    color: introCardIsHovered
                        ? AppColorsConstant.greenColor
                        : null,
                  ),
                  const SizedBox(width: 5.0),
                  Text(
                    'AI Assistant',
                    style: TextStyle(
                      fontSize: 14,
                      color: introCardIsHovered
                          ? AppColorsConstant.greenColor
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
