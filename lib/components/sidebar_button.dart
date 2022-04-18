import 'package:flutter/material.dart';
import 'package:flutter_first/constants.dart';
import 'package:flutter_first/model/sidebar.dart';

class SideBarButton extends StatelessWidget {
  SideBarButton({required this.triggerAnimation});

  final Function triggerAnimation;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        triggerAnimation();
      },
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      highlightColor: Colors.transparent, //hold button color
      splashColor: Colors.transparent, //tap button color
      constraints: BoxConstraints(
        maxWidth: 40,
        maxHeight: 40,
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: kShadowColor,
                offset: Offset(0, 12),
                blurRadius: 16,
              )
            ]),
        child: Image.asset(
          'asset/icons/icon-sidebar.png',
          color: kPrimaryLabelColor,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
      ),
    );
  }
}
