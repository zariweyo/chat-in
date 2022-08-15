import 'package:chatin/module_chat/index.dart';
import 'package:chatin/module_common/library/launch_detector.dart';
import 'package:chatin/module_hive/adapters/chat_message_field_hive.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatMessageRichText extends StatelessWidget{
  final ChatMessage message;
  
  const ChatMessageRichText({Key? key, 
    required this.message,
  }) : super(key: key);

  TextSpan printRichText(String message){
    List<String> parts = message.split(RegExp(r' '));
    return 
      TextSpan(
        children: parts.map((stringRender) {
          LaunchDetectorType detectorType = LaunchDetector.detector(stringRender.trim());
          if(detectorType!=LaunchDetectorType.none){
            return TextSpan( 
              text: "$stringRender ",
              style: const TextStyle(
                color: Colors.blueAccent
              ),
              recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    switch(detectorType){
                      case LaunchDetectorType.phone:
                        launchUrl(Uri.parse("tel:${stringRender.trim()}"),
                          mode: LaunchMode.externalApplication
                        );
                        break;
                      case LaunchDetectorType.url:
                        String uriRenderSt = stringRender.trim();
                        
                        if(!uriRenderSt.toLowerCase().startsWith("//")){
                          uriRenderSt = "http:$uriRenderSt";
                        }

                        if(!uriRenderSt.toLowerCase().startsWith("http")){
                          uriRenderSt = "http://$uriRenderSt";
                        }

                        launchUrl(Uri.parse(uriRenderSt),
                          mode: LaunchMode.externalApplication
                        );
                        break;
                      case LaunchDetectorType.email:
                        launchUrl(Uri.parse("mailto:${stringRender.trim()}"),
                          mode: LaunchMode.externalApplication
                        );
                        break;
                      case LaunchDetectorType.none:
                      default:
                        break;
                    }
                    
                  });
          }

          return TextSpan( 
            text: "$stringRender ");
        }).toList()
      );
  }

  printSelectable(String messageStr){
    List<String> lines = messageStr.split("\n");

    return SelectableText.rich(
      TextSpan(
        children: lines.map((e) => printRichText("$e\n")).toList()
      ),
      textAlign: TextAlign.left
    );
  }

  printNum(ChatMessageFieldHive fieldNum){

    return Container(
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(5)
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(left: 2),
      child: SelectableText(
        fieldNum.value,
        textAlign: TextAlign.right,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    List<ChatMessageFieldHive> fields = message.fields ?? [];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: printSelectable(message.message),
        ),
        ...fields.map((e) => printNum(e)).toList()
      ],
    );
  }

}