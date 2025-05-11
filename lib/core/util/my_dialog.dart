// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:elegant_notification/resources/stacked_options.dart';
import 'package:fitness_app_premium/core/util/my_color.dart';
import 'package:fitness_app_premium/core/util/my_dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDialog {
  void showSuccessToast(
      {required String msg,
      String title = "Successful",
      required BuildContext context}) {
    ElegantNotification.success(
      isDismissable: false,
      position: Alignment.topCenter,
      toastDuration: const Duration(milliseconds: 2300),
      animation: AnimationType.fromTop,
      title: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      description: Text(msg,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyLarge!),
      shadow: BoxShadow(
        color: Colors.green.withOpacity(0.2),
        spreadRadius: 2,
        blurRadius: 5,
        offset: const Offset(0, 4),
      ),
    ).show(context);
  }

  void showInfoToast(
      {required String msg,
      String title = "Opps !!",
      required BuildContext context}) {
    ElegantNotification.info(
      isDismissable: false,
      position: Alignment.topCenter,
      toastDuration: const Duration(milliseconds: 2300),
      animation: AnimationType.fromTop,
      title: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      description: Text(msg,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyLarge!),
      shadow: BoxShadow(
        color: MyColor.bluePrimary.withOpacity(0.2),
        spreadRadius: 2,
        blurRadius: 5,
        offset: const Offset(0, 4),
      ),
    ).show(context);
  }

  void showFailedToast(
      {required String msg,
      String title = "Failed",
      required BuildContext context}) {
    ElegantNotification.error(
      stackedOptions: StackedOptions(
        key: 'topRight',
        type: StackedType.below,
        itemOffset: const Offset(0, 5),
      ),
      position: Alignment.topRight,
      toastDuration: const Duration(milliseconds: 2300),
      animation: AnimationType.fromRight,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      description: Text(msg,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyLarge!),
    ).show(context);
  }



  Future<bool> showExitPopup(BuildContext context) async {
    return showAlertDialog(
      context: context,
      title: _getExitTitle,
      content: _getExitSubContent,
      actions: _getExitActionButtons(context),
    );
  }

  Future<bool> showAlertDialog(
      {required BuildContext context,
      required Widget title,
      required Widget content,
      required List<Widget> actions}) async {
    final f = Platform.isAndroid
        ? await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              elevation: 0,
              title: Column(children: [title, MyDimens.cmDivider]),
              content: content,
              actions: actions,
            ),
          )
        : await showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title: Column(children: [title, MyDimens.cmDivider]),
              content: content,
              actions: actions,
            ),
          );
    return f ?? false;
  }

  Widget get _getExitTitle => const Text(
        'Exit App',
        style: TextStyle(
            fontFamily: "poppins_regular", fontWeight: FontWeight.bold),
      );
  Widget get _getExitSubContent => const Text(
        'Do you want to exit SoowGood?',
        style: TextStyle(
            fontFamily: "poppins_regular",
            fontSize: 14,
            fontWeight: FontWeight.w600),
      );
  List<Widget> _getExitActionButtons(BuildContext context) => [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(false),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(MyColor.skySecondary),
          ),
          child: const Text(
            'No',
            style: TextStyle(color: MyColor.bluePrimary),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              //SystemNavigator.pop();
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(MyColor.bluePrimary),
            ),
            child: const Text(
              'Yes',
              style: TextStyle(color: MyColor.ashhLight),
            ),
          ),
        ),
      ];
}
