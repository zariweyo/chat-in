import 'package:chatin/module_chat/models/index.dart';
import 'package:chatin/module_common/extensions/index.dart';
import 'package:chatin/module_common/library/storage.dart';
import 'package:chatin/module_hive/adapters/chat_message_hive.dart';
import 'package:uuid/uuid.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';
// ignore: depend_on_referenced_packages
import 'package:pointycastle/asymmetric/api.dart';
import 'dart:convert';


class RSAHelper{
  late RsaKeyHelper helper;

  RSAHelper(){
    helper = RsaKeyHelper();
  }

  Future<RSAHelperModel> generateRSAPairs() async{

    RsaKeyHelper helper = RsaKeyHelper();

    var keyPair = await helper.computeRSAKeyPair(helper.getSecureRandom());

    String privateKeyString = helper.encodePrivateKeyToPemPKCS1(keyPair.privateKey as RSAPrivateKey);
    String publicKeyString = helper.encodePublicKeyToPemPKCS1(keyPair.publicKey as RSAPublicKey);

    return RSAHelperModel(
      private: privateKeyString,
      public: publicKeyString,
    );
  }

  Future<RSAHelperModel> getLocalRSAPairs(){
    return Storage.readRSAKeys();
  }

  ChatMessage encryptRSA(ChatMessage chatMessageIn,String publicKey){
    ChatMessage chatMessageMod = chatMessageIn.clone();
    var pubKey = helper.parsePublicKeyFromPem(publicKey);
    chatMessageMod.cipherData = [];
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encodedStr = "";
    try{
      encodedStr = stringToBase64.encode(chatMessageMod.message);
    }catch(err){
      encodedStr = chatMessageMod.message;
    }
    chatMessageMod.fingerRSA = const Uuid().v5(Uuid.NAMESPACE_URL, chatMessageMod.message);
    chatMessageMod.fingerRSA64 = const Uuid().v5(Uuid.NAMESPACE_URL, encodedStr);
    encodedStr.splitByLength(250).forEach((element) {
      chatMessageMod.cipherData64.add(encrypt(element, pubKey));
    });
    chatMessageMod.message.splitByLength(250).forEach((element) {
      chatMessageMod.cipherData.add(encrypt(element, pubKey));
    });
    chatMessageMod.message = "*******";
    chatMessageMod.encrypType = EncrypType.rsa;
    
    return chatMessageMod;
  }

  ChatMessage? decryptRSA(ChatMessage chatMessageIn,String privKeyIn){
    try{
      ChatMessage chatMessageMod = chatMessageIn.clone();
      var privKey = helper.parsePrivateKeyFromPem(privKeyIn);
      chatMessageMod.message = "";
      String newFingerRSA = "";
      
      if(chatMessageMod.cipherData64.isNotEmpty){
        String encodedStr = "";
        for (var element in chatMessageMod.cipherData64) {
          encodedStr += decrypt(element, privKey);
        }
        Codec<String, String> stringToBase64 = utf8.fuse(base64);
        try{
          chatMessageMod.message = stringToBase64.decode(encodedStr);
        }catch(err){
          chatMessageMod.message = encodedStr;
        }
        newFingerRSA = const Uuid().v5(Uuid.NAMESPACE_URL, encodedStr);
        if(newFingerRSA!=chatMessageMod.fingerRSA64){
          return null;
        }
      }else{
        for (var element in chatMessageMod.cipherData) {
          chatMessageMod.message += decrypt(element, privKey);
        }
        newFingerRSA = const  Uuid().v5(Uuid.NAMESPACE_URL, chatMessageMod.message);
        if(newFingerRSA!=chatMessageMod.fingerRSA){
          return null;
        }
      }
      
      chatMessageMod.cipherData=[];
      chatMessageMod.cipherData64=[];
      
      chatMessageMod.encrypType = EncrypType.none;
      return chatMessageMod;
    }catch(e){
      return null;
    }
  }
}

class RSAHelperModel{
  String private = "";
  String public = "";

  RSAHelperModel({
    this.private="",
    this.public="",
  });
}