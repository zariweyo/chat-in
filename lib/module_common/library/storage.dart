import 'dart:async';

import 'package:chatin/module_common/library/rsa_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage{

  static String rsaPublicKey = "rsa_public_key";
  static String rsaPrivateKey = "rsa_private_key";
  static String tokenMessaging = "token_messaging";
  static String topicMessaging = "topic_messaging";


  static Future<bool> saveRSAKeys(RSAHelperModel rsaData) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result1 = await prefs.setString(Storage.rsaPublicKey, rsaData.private);
    bool result2 = await prefs.setString(Storage.rsaPrivateKey, rsaData.public);
    
    return result1 && result2;
  }

  static Future<RSAHelperModel> readRSAKeys() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? pubKey = prefs.getString(Storage.rsaPublicKey);
    String? privKey = prefs.getString(Storage.rsaPrivateKey);


    if(pubKey!=null && privKey!=null || pubKey=="" || privKey==""){
      RSAHelper rsaHelper = RSAHelper();
      RSAHelperModel rsaResult = await rsaHelper.generateRSAPairs();
      await saveRSAKeys(rsaResult);
      return rsaResult;
    }

    return RSAHelperModel(
      private: privKey ??="",
      public: pubKey ??=""
    );
  }

  static Future<bool> saveTokenMessaging(String token) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = await prefs.setString(Storage.tokenMessaging, token);

    return result;
  }

  static Future<String> readTokenMessaging() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Storage.tokenMessaging);

    return token ??= "";
  }

  static Future<bool> saveTopicMessaging(String topic) async{
    List<String> topics = await readTopicsMessaging();
    topics.add(topic);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = await prefs.setString(Storage.topicMessaging, topics.join(","));

    return result;
  }

  static Future<bool> delTopicMessaging(String topic) async{
    List<String> topics = await readTopicsMessaging();
    if(!topics.contains(topic)){
      return false;
    }

    topics.removeWhere((element) => element==topic);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = await prefs.setString(Storage.topicMessaging, topics.join(","));

    return result;
  }

  static Future<List<String>> readTopicsMessaging() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? topicsString = prefs.getString(Storage.topicMessaging);


    if(topicsString==null){
      return [];
    }

    return topicsString.split(",");
  }


}