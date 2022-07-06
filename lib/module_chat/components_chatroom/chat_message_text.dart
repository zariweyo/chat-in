import 'package:chatin/module_chat/index.dart';
import 'package:chatin/module_common/library/launch_detector.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatMessageText extends StatefulWidget{
  final ChatMessage message;
  
  const ChatMessageText({Key? key, 
    required this.message,
  }) : super(key: key);

  @override
  State<ChatMessageText> createState() => _ChatMessageTextState();
}

class _ChatMessageTextState extends State<ChatMessageText> {

  late ChatMessage currentMessage; 
  TextEditingController controller = TextEditingController();
  bool currentEdit = false;

  @override
  initState(){
    currentMessage = widget.message;
    controller.text = currentMessage.message;
    super.initState();
  }

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

  Widget printRichTextAll(){
    List<String> lines = currentMessage.message.split("\n");

    return SelectableText.rich(
      TextSpan(
        children: lines.map((e) => printRichText("$e\n")).toList()
      ),
      textAlign: TextAlign.left
    );
  }


  @override
  Widget build(BuildContext context) {

    return BlocSelector<ChatBloc,ChatState,bool>(
      selector: (state) {
        if(state is ChatEditMessageState) {
          currentEdit = state.message.id==widget.message.id;
        }
        if(state is ChatSaveMessageState) {
          if(state.message.id==widget.message.id){
            currentEdit = false;
          }
        }
        return currentEdit;
      },
      builder: (ctx,isEdit) => 
      isEdit?
        Row(
          children:[
            Expanded(
              child: TextField(
                controller: controller,
                maxLines: 3,
                onChanged: (newMessage) {
                  currentMessage.message = newMessage;
                },
              ),
            ),
            IconButton(onPressed: () {
              BlocProvider.of<ChatBloc>(context).add(ChatSaveMessageEvent(currentMessage));
            }, icon: const Icon(Icons.check))
          ]
        )
      :
        printRichTextAll()
    );
  }
}