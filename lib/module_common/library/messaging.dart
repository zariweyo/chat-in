/* 
import 'dart:async';
import 'dart:io';

import 'package:chatin/module_common/library/storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MMessaging{
  late FirebaseMessaging _firebaseMessaging;

  MMessaging(){
    _firebaseMessaging = FirebaseMessaging.instance;
    //_firebaseMessaging.configure(onMessage: onMessage);
    FirebaseMessaging.onMessage.listen(onMessage);

    _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
      
    ).then((value){
      _suscribeAll();
    });

    

    /* if (Platform.isIOS) {
      _firebaseMessaging.requestPermission(sound: true, badge: true, alert: true);
      _suscribeAll();

    }else{
      _suscribeAll();
    } */
  }


  static localNotification({String? title, String? body}){
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('logo_padle_notification');
    IOSInitializationSettings initializationSettingsIOS = const IOSInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
        android:initializationSettingsAndroid, 
        iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectLocalNotification);

    AndroidNotificationDetails androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'chatin_CNS', 'chatin', 
        channelDescription: 'Chatin Notification Service',
        importance: Importance.max, 
        priority: Priority.high, 
        ticker: 'ticker',
        playSound: true,
        color: Colors.green,
        channelShowBadge: true,
        sound: RawResourceAndroidNotificationSound("alert"),
        ledColor: Colors.green,
        ledOnMs: 1500,
        ledOffMs: 3000,
        enableLights: true,
        enableVibration: true
      );

    IOSNotificationDetails iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, 
        iOS:iOSPlatformChannelSpecifics);
    
    flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics,
        payload: '0');
  }

  static void onSelectLocalNotification(String? payload) {

  }

  _suscribeAll(){
    _firebaseMessaging.subscribeToTopic("padelhub");
    _firebaseMessaging.onTokenRefresh.listen(onTokenRefresh);
    
    _firebaseMessaging.getToken().then((_tok){
      //LogFirebase.log("getToken", _tok);
      //print("getToken: "+ _tok);
      updateToken(_tok);
    });
  }

  suscribeTracksTopics(List<String> tracks) async {
    List<String> _currentTopics = await Storage.readTopicsMessaging();
    List<String> _topicTraks = [];
    tracks.forEach((_trackId) {
        _topicTraks.add("TRACK_"+_trackId);
    });

    _currentTopics.where((element) => element.startsWith("TRACK_")).forEach((_currentTopic) {
      if(!_topicTraks.contains(_currentTopic)){
        unsuscribeTo(_currentTopic);
      }
    });

    _topicTraks.forEach((_topicTrack) {
      if(!_currentTopics.contains(_topicTrack)){
        suscribeTo(_topicTrack);
      }
    });

  }

  Future<bool> suscribeTo(String _topic){
    _firebaseMessaging.subscribeToTopic(_topic);
    return Storage.saveTopicMessaging(_topic);
  }

  Future<bool> unsuscribeTo(String _topic){
    _firebaseMessaging.unsubscribeFromTopic(_topic);
    return Storage.delTopicMessaging(_topic);
  }

  Future<bool> isTopicSuscribed(String _topic) async{
    List<String> _topics = await Storage.readTopicsMessaging();

    return _topics.contains(_topic);
  }


  Future<dynamic> onMessage(RemoteMessage _data) async{

    if(_data.data['chatId']!=null){
      FlutterAppBadger.isAppBadgeSupported().then((_supported){
        if(_supported){
          FlutterAppBadger.updateBadgeCount(1);
        }
      });

      /* ChatMetadata chatMetadata = ChatController.getLastMessageForNotification(_data.data['chatId']);
      if(chatMetadata!=null){
        await localNotification(title: chatMetadata.lastMessageOwner, body: chatMetadata.lastMessage);
      } */
    }
  
    /* if(_data.notification!=null && _data.notification.title!=null){
      //localNotification(title: _data.notification.title, body: _data.notification.body);
    }

    if(_data.data['aps']!=null && _data.data['aps']['alert']!=null && _data.data['aps']['alert']['title']!=null){
      //localNotification(title: _data.data['aps']['alert']['title'], body: _data.data['aps']['alert']['body']);
    } */

  }

  static Future<dynamic> onBackgroundMessage(RemoteMessage _data) async{
    if(_data.data['chatId']!=null){
      FlutterAppBadger.isAppBadgeSupported().then((_supported){
        if(_supported){
          FlutterAppBadger.updateBadgeCount(1);
        }
      });
      
      await localNotification(title: "Chat Message", body: "Alguien te ha escrito en el chat");
    }

  }
  

  onTokenRefresh(token){
    updateToken(token);
  }

  updateToken(token){
    if(token==null||token==""){
      return;
    }

    Storage.saveTokenMessaging(token).then((result){
      //UserController.instance.user.updateToken(token);
    });
  }


} */