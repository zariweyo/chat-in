import 'package:chatin/module_common/basic/m_empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MInfoMessageHTML extends StatefulWidget {
  final String html;
  final String title;
  final dynamic Function()? onPressed;

  const MInfoMessageHTML({Key? key, required this.html,this.onPressed, required this.title}) : super(key: key);

  @override
  State<MInfoMessageHTML> createState() => _MInfoMessageHTMLState();


}

class _MInfoMessageHTMLState extends State<MInfoMessageHTML> {
  ScrollController controller = ScrollController();
  bool buttonEnable = false;

  @override
  initState(){
    super.initState();
    checkEnableBlutton();
  }

  checkEnableBlutton(){
    controller.addListener(() {
      double maxScroll = controller.position.maxScrollExtent;
      double currentScroll = controller.position.pixels;
      double delta = 200.0; 
      if ( maxScroll - currentScroll <= delta) { 
        setState(() {
          buttonEnable = true;
        });
      }
    });
  }

  Widget _messageFormater() {
     return SingleChildScrollView(
       controller: controller,
      child:HtmlWidget(
        widget.html,
        textStyle: const TextStyle(
            fontSize: 13.0,
            height: 1.0,
            fontWeight: FontWeight.w300),
      )
     );
   }

   Widget _titleFormater() {
     return Text(
        widget.title,
        style: const TextStyle(
            fontSize: 18.0,
            height: 1.0,
            fontWeight: FontWeight.bold),
      );
   }

  Widget _showMessage(BuildContext context) {
    if (widget.html.isNotEmpty) {
      
      return AlertDialog(
        
          title: _titleFormater(),
          content: _messageFormater(),
          actions: <Widget>[
            InkWell(
              onTap: buttonEnable? widget.onPressed : null,
              child: Text(AppLocalizations.of(context)!.accept,
              style: TextStyle(
                color: buttonEnable? Colors.blue : Colors.grey
              ),)
            ),
          ],
        );
    } else {
      return const MEmpty();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _showMessage(context);
  }
}
