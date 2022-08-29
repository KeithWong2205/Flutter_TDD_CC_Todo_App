import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tcc_base_source/core/di/injection_container.dart';
import 'package:flutter_tcc_base_source/core/helpers/secure_storage.dart';

class FirebaseMessagingHelper {
  FirebaseMessaging? fireBaseMessaging;

  void setUpFireBase(BuildContext context, bool isUser) {
    fireBaseMessaging = null;
    fireBaseMessaging = FirebaseMessaging.instance;
    _fireBaseCloudMessagingListeners(context);
  }

  void _fireBaseCloudMessagingListeners(context) {
    _requestPermission();
    fireBaseMessaging!.getInitialMessage().then((RemoteMessage? message) async {
      if (message != null) {}
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      debugPrint('onMessage: ${message.data.toString()}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      debugPrint('onMessageOpenedApp: ${message.data.toString()}');
    });
  }

  void _requestPermission() async {
    await fireBaseMessaging!.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    fireBaseMessaging!.getToken().then((String? token) async {
      debugPrint('Firebase token : $token');
      await _saveToken(token ?? '');
    });

    fireBaseMessaging!.onTokenRefresh.listen((token) async {
      String oldToken = await sl<SecureStorage>().getCustomString(SecureStorage.firebaseToken);
      if (oldToken.isNotEmpty) {
        //TODO Remove old token.
      }
      await _saveToken(token);
    });
  }

  _saveToken(String token) async {
    await sl<SecureStorage>().saveCustomString(SecureStorage.firebaseToken, token);
    //TODO Add new token.
  }
}
