import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:base/src/extensions/view_extensions.dart';

/// Common View Helper functions
class ViewHelpers {
  // static const INPUT_FIELD_PADDING = EdgeInsets.only(top: 8, bottom: 8);
  static const dividerColor = Color.fromARGB(255, 211, 211, 211);

  static Widget buildHorizontalSpacer({double width = 5.0}) {
    //Just build a divider with transarent color and rquired height
    return VerticalDivider(color: Colors.transparent, width: width);
  }

  static Widget buildSeperator({double thickness = 0.5, double height = 0.5}) {
    //just return a divider..
    return Divider(color: dividerColor, height: height, thickness: thickness);
  }

  static Widget buildVerticalSpacer({double height = 5.0}) {
    //Just build a divider with transarent color and rquired height
    return Divider(color: Colors.transparent, height: height);
  }

  // static String getDisplayDateTime(DateTime dateTime) {
  //   return DateFormat("dd MMM yyyy hh:mm").format(dateTime);
  // }

  // static String getDisplayDate(DateTime dateTime) {
  //   return DateFormat("dd MMM yyyy").format(dateTime);
  // }

  /// Builds an Empty Widget(). This is used in cases like building conditional
  /// widget
  static Widget buildEmptyWidget() {
    return Container(width: 0, height: 0, padding: const EdgeInsets.all(0));
  }

  /// Builds a Progress. Typically when the cubit state is loading/processing
  static Widget buildProgress(String message,
      {required TextStyle textStyle,
      Color backgroundColor = Colors.transparent,
      double progressSize = 2.0}) {
    return Container(
        color: backgroundColor,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(message, style: textStyle),
          ViewHelpers.buildVerticalSpacer(height: 20),
          const GFLoader(
            type: GFLoaderType.circle,
          )
        ]).applyPadding(const EdgeInsets.all(10)));
  }
}
