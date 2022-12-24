import 'package:base/src/base/view_helpers.dart';
import 'package:base/src/base/cubit_state.dart';
import 'package:base/src/base/cubit_states.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'view_extensions.dart';

/// Extensions on Build context
extension BuildContextExtensions on BuildContext {
  Widget buildProgress(CubitState state) {
    return ViewHelpers.buildProgress((state as CubitLoadingState).loadingStatus,
        textStyle: const TextStyle());
  }

  Widget buildBadge(String text,
      {Color color = Colors.transparent,
      required TextStyle textStyle,
      EdgeInsets padding = const EdgeInsets.all(8)}) {
    /* If count is 0, don't show the widget */

    return Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(
                8) // use instead of BorderRadius.all(Radius.circular(20))
            ),
        child: Text(text, style: textStyle).applyPadding(padding));
  }

  Widget buildExpandableText(String text) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 190),
      child: ExpandableText(
        text,
        expandText: "show more",
        maxLines: 1,
        collapseText: "show less",
        linkColor: Colors.blue,
        urlStyle: TextStyle(fontSize: 14),
      ),
    );
  }

  Widget buildFailureAlert(String text,
      {Color color = Colors.transparent,
      EdgeInsets padding =
          const EdgeInsets.only(left: 0, right: 5, bottom: 5, top: 5)}) {
    /* If count is 0, don't show the widget */
    var textStyle = const TextStyle()
        .copyWith(color: Colors.red, fontWeight: FontWeight.bold);
    return Align(
            alignment: Alignment.centerLeft,
            child: Text(text, style: textStyle))
        .applyPadding(padding);
  }

  Widget buildValidationErrors<T>(CubitState<T> state) {
    if (state is CubitFailureState<T>) {
      //failure state with validation errors...
      //Form the valdation errors..
      var errStyle = const TextStyle().copyWith(color: Colors.red);

      List<Widget> errorFields = [];
      errorFields.add(Text(state.failureMessage, style: errStyle));
      errorFields.add(ViewHelpers.buildVerticalSpacer());

      state.errors?.forEach((e) => errorFields.add(
          Text("- ${e.error}", style: errStyle).applyPadding(
              const EdgeInsets.symmetric(horizontal: 10, vertical: 2))));

      return Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: errorFields);
    } else {
      //No validation errors...
      return ViewHelpers.buildEmptyWidget();
    }
  }

  Widget buildSubmissionStatus<T>(CubitState<T> state) {
    if (state is CubitSubmittingState<T>) {
      //Submission in Progress..
      return ViewHelpers.buildProgress(state.submittingMessage,
          textStyle: const TextStyle());
    } else if (state is CubitFailureState<T>) {
      //Failure state.. Validation errors
      return buildValidationErrors(state);
    } else {
      //Neithr submited/success/failure..
      //No widget required
      return ViewHelpers.buildEmptyWidget();
    }
  }

  Future<T?> showPopupWithResult<T>(Widget widget) {
    /* Create the popup */
    var popup = AlertDialog(
        contentPadding:
            const EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
        //Just create a statck with a close cirlce outsize
        content: widget);

    //Show the popup..
    return showDialog<T>(
        context: this,
        builder: (BuildContext context) {
          return popup;
        });
  }

  Widget _buildConfirmationPopup(
      BuildContext context,
      String title,
      String text,
      Future<void> Function() okAction,
      Future<void> Function() cancelAction) {
    //Just render in column

    Color color = Theme.of(context).colorScheme.secondary;
    TextStyle buttonStyle = TextStyle(
        color: color,
        fontSize: 13,
        letterSpacing: 1.5,
        fontWeight: FontWeight.bold);
    TextStyle textStyle = const TextStyle(fontSize: 13);

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Divider(thickness: 2),
          Text(text, style: textStyle),
          //Divider(),

          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextButton(
                    child: Text("Yes", style: buttonStyle),
                    onPressed: () async {
                      //Just call the OK action and close the popup

                      await okAction();

                      //close the popup
                      Navigator.of(context).pop();
                    }),
                TextButton(
                    child: Text("No", style: buttonStyle),
                    onPressed: () {
                      //Just call callback here

                      cancelAction();

                      //close the popup
                      Navigator.of(context).pop();
                    })
              ])
        ]);
  }

  /// Just a simple OK popup
  Widget _buildOkPopup(BuildContext context, String title, String text) {
    //Just render in column

    Color color = Theme.of(context).colorScheme.secondary;
    TextStyle buttonStyle = TextStyle(
        color: color,
        fontSize: 13,
        letterSpacing: 1.5,
        fontWeight: FontWeight.bold);
    TextStyle textStyle = const TextStyle(fontSize: 13);

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Divider(thickness: 2),
          Text(text, style: textStyle),
          //Divider(),

          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextButton(
                    child: Text("OK", style: buttonStyle),
                    onPressed: () async {
                      //close the popup
                      Navigator.of(context).pop();
                    }),
              ])
        ]);
  }

  /// Cobnfirmation popup
  Future<void> showConfirmation(
      String text,
      String title,
      Future<void> Function() okAction,
      Future<void> Function() cancelAction) async {
    TextStyle headingStyle = const TextStyle(
        fontSize: 13, letterSpacing: 1.5, fontWeight: FontWeight.bold);

    //  var popup =

    //Show the popup..
    await showDialog(
        context: this,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(title, style: headingStyle),
              contentPadding: const EdgeInsets.only(
                  top: 20, bottom: 10, left: 20, right: 10),
              //Just create a statck with a close cirlce outsize
              content: _buildConfirmationPopup(
                  context, title, text, okAction, cancelAction));
        });
  }

  //// Calnder
  Future<DateTime?> showCalendar(
      {required DateTime firstDate,
      required DateTime lastDate,
      required DateTime initialDate}) async {
    DateTime? date = DateTime(1900);
    //FocusScope.of(context).requestFocus(new FocusNode());
    //Show date Picker
    date = await showDatePicker(
        context: this,
        /* Cannot give a past date */
        firstDate: firstDate,
        initialDate: initialDate,
        lastDate: lastDate);

    return date;
  }

  // Shows snack bar
  void showSnackbar(String message) {
    SnackBar snackbar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        onPressed: () {
          ScaffoldMessenger.of(this).clearSnackBars();
        },
        label: "OK",
      ),
    );
    ScaffoldMessenger.of(this).showSnackBar(snackbar);
  }

  /// Shows a message box
  void showMessageBox(String message, String title) async {
    TextStyle headingStyle = const TextStyle(
        fontSize: 13, letterSpacing: 1.5, fontWeight: FontWeight.bold);
    /* Create the popup */
    //Show the popup..
    await showDialog(
        context: this,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text(title, style: headingStyle),
              contentPadding: const EdgeInsets.only(
                  top: 20, bottom: 10, left: 25, right: 10),
              //Just create a statck with a close cirlce outsize
              content: _buildOkPopup(context, title, message));
        });
  }

  /// Builds a field with a label and text value
  Widget buildFieldLabelText(
      {required String label,
      required String value,
      TextStyle? labelStyle,
      TextStyle? fieldValueStyle}) {
    //If no label is passed, take it from the Theme Label Style..
    labelStyle ??= Theme.of(this).inputDecorationTheme.labelStyle;

    //If no label is passed, take it from the Theme Label Style..
    fieldValueStyle ??= Theme.of(this).textTheme.bodyText1;

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(label, style: labelStyle),
          ViewHelpers.buildVerticalSpacer(height: 8),
          Text(value, style: fieldValueStyle),
        ]);
  }

  /// Builds Page title
  Widget buildPageTitle(String heading, {double padding = 15}) {
    return Column(children: [
      ViewHelpers.buildVerticalSpacer(height: padding),
      Text(heading, style: Theme.of(this).textTheme.headline5),
      //ViewHelpers.buildSeperator(height: 20, thickness: 1),
      ViewHelpers.buildVerticalSpacer(height: padding),
    ]);
  }

  /// Buils a field value with a label
  Widget buildFieldLabel(
      {required String label, required Widget value, TextStyle? labelStyle}) {
    //If no label is passed, take it from the Theme Label Style..
    labelStyle ??= Theme.of(this).inputDecorationTheme.labelStyle;

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: labelStyle),
          ViewHelpers.buildVerticalSpacer(height: 8),
          value,
        ]);
  }

  /// Build a Page sub heading
  Widget buildPageSubHeading(String heading) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ViewHelpers.buildVerticalSpacer(height: 5),
      Text(heading, style: Theme.of(this).textTheme.headline4).applyPadding(
          const EdgeInsets.symmetric(vertical: 8, horizontal: 10)),
    ]);
  }

  /// Buils a Page Heading
  Widget buildPageHeading(String? heading) {
    return (heading == null)
        ? ViewHelpers.buildEmptyWidget()
        : Container(
            color: Theme.of(this).secondaryHeaderColor,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ViewHelpers.buildVerticalSpacer(height: 5),
              Text(heading.toUpperCase(),
                      style: Theme.of(this).textTheme.headline3)
                  .applyPadding(
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10)),
            ]));
  }

  Widget buildStatus(String status) {
    return Card(
      margin: const EdgeInsets.all(8),
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          status.toUpperCase(),
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }

  /// Builds a page section. Typically a Card with the content
  Widget buildSection(
      {required Widget content,
      String? heading,
      EdgeInsets padding = const EdgeInsets.all(15)}) {
    bool hasHeading = (heading != null);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 0),
              )
            ]),
        child: Column(
          children: [
            (hasHeading)
                ? buildPageSubHeading(heading)
                : ViewHelpers.buildEmptyWidget(),
            content.applyPadding(padding)
          ],
        ),
      ),
    );
  }

  Widget buildAttributeValue(String key, String value, {Color? color}) {
    return RichText(
      text: TextSpan(
          text: key,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: color ?? Colors.black),
          children: [
            const TextSpan(text: " :  "),
            TextSpan(
                text: value,
                style: Theme.of(this)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: color ?? Colors.black))
          ]),
    );
  }

  Widget buildAttributeWdiget(String key, Widget child, {Color? color}) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
              text: key,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: color ?? Colors.black),
              children: const [
                TextSpan(text: " : "),
              ]),
        ),
        child,
      ],
    );
  }

  /// Builds an Input field. Basically with the label above &
  /// field below
  Widget buildInputField(
      {required String? fieldLabel,
      TextStyle? labelStyle,
      bool isMandatory = true,
      double verticalGap = 8,
      /* Gap between the label & Input field */
      required Widget field}) {
    //this._controller = new TextEditingController(text: widget.text);

    //If no label is passed, take it from the Theme Label Style..
    labelStyle ??= Theme.of(this).inputDecorationTheme.labelStyle;

    var labelField = (fieldLabel == null)
        ? ViewHelpers.buildEmptyWidget()
        : Text(fieldLabel);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        labelField,
        ViewHelpers.buildHorizontalSpacer(width: 5),
        /* Draw a * if mandatroy */
        (isMandatory
            ? const Text("*", style: TextStyle(color: Colors.red, fontSize: 18))
            : ViewHelpers.buildEmptyWidget()),
      ]),
      ViewHelpers.buildVerticalSpacer(height: verticalGap),
      field
    ]);
  }

  /// Builds the field values as a single row
  Widget buildFieldValuesRow(List<DisplayFieldValue> fields) {
    //Build each field..
    var children = fields
        .map((element) => Expanded(
            flex: element.flex,
            child: buildFieldLabelText(
                label: element.fieldLabel, value: element.fieldValue)))
        .toList();

    return Row(children: children);
  }

  /// Builds a button with item
  Widget buildButtonWithIcon(
      {required String text,
      required Icon icon,
      Future<void>? Function()? onPressedAction,
      MainAxisAlignment alignment = MainAxisAlignment.end}) {
    return Row(
        mainAxisAlignment: alignment,
        mainAxisSize: MainAxisSize.max,
        children: [
          ElevatedButton.icon(
              icon: icon,
              label: Text(text),
              onPressed: () {
                onPressedAction?.call()?.catchError((error, stackTrace) {
                  //In release mode, ERR will not be thrown.
                  //So catch the EX and throw that manually...
                  //Just rethrow the error back to catcher
                  // ignore: avoid_print
                  print(stackTrace);
                });
              })
        ]);
  }

  Widget buildButton(String text, Future<void> Function()? onPressed) {
    //Don't apply any style here as the style is applied gloablly
    //There is some issue in setting Text Style with button Theme
    //So set only that here..
    return ElevatedButton(
        child: Text(text),
        onPressed: () {
          onPressed?.call().catchError((error, stackTrace) {
            //Just rethrow the error back to catcher
            //print(stackTrace);
          });
        });
  }

  Widget buildLegends(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Row(
            children: [
              Container(
                height: 12,
                width: 12,
                color: Colors.green,
              ),
              const Text(
                " - Selected ",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(width: 10),
          Row(
            children: [
              Container(
                height: 12,
                width: 12,
                color: const Color(0xFF335797),
              ),
              Text(
                " - $title",
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class DisplayFieldValue {
  String fieldLabel;

  String fieldValue;

  int flex;

  DisplayFieldValue(
      {required this.fieldLabel, required this.fieldValue, required this.flex});
}
