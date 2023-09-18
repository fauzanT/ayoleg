import 'package:in_app_update/in_app_update.dart';
import 'dart:convert';
import 'dart:io';
import 'package:ayoleg/models/model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<AppUpdateInfo?> _checkForUpdate() async {
  try {
    return await InAppUpdate.checkForUpdate();
  } catch (e) {
//Throwing the exception so we can catch it on our UI layer
    throw e.toString();
  }
}

Future<void> checkForImmediateUpdate() async {
  try {
//Call and get the result from the initial function
    final AppUpdateInfo? info = await _checkForUpdate();

//Because info could be null
    if (info != null) {
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        InAppUpdate.performImmediateUpdate();
      }
    }
  } catch (e) {
    throw e.toString();
  }
}

Future<void> checkForFlexibleUpdate() async {
//Here, you'll show the user a dialog asking if the user is wiilling
//to update your app while using it

  try {
//We'll check if the there is an actual update
    final AppUpdateInfo? info = await _checkForUpdate();

//Because info could be null. If info is null, we can safely assume that there is no pending
//update

    if (info != null) {
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
//The user starts the flexible updates, when it's done we'll ask the user if they want to go ahead with the update or not
        await InAppUpdate.startFlexibleUpdate();
      }
    }
  } catch (e) {
    throw e.toString();
  }
}

Future<void> completeFlexibleUpdate() async {
//Here, the user has downloaded and queued up your new update, it's time to
//actually install it!

  try {
    await InAppUpdate.completeFlexibleUpdate();
  } catch (e) {
    throw e.toString();
  }
}
