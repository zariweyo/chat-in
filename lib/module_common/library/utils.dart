import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UtilsFunctions {
  static String generateUuid() {
    var uuid = const Uuid();
    return uuid.v4();
  }

  static String prettyDateTime(DateTime date){
    var formatter = DateFormat('dd/MM/yyyy HH:mm');
    String formatted = formatter.format(date);

    return formatted;
  }

  static String dateFormat(DateTime date,{String format="dd/MM/yyyy"}){
    var formatter = DateFormat(format);
    String formatted = formatter.format(date);

    return formatted;
  }

  static String prettyDate(BuildContext context, DateTime date){
    List<String> months = getLargeMonthsstrings(context);
    String formatted = "${date.day} ";
    formatted += "${AppLocalizations.of(context)!.ofSt.toLowerCase()} ";
    formatted += "${months[date.month-1]} ";
    formatted += "${AppLocalizations.of(context)!.ofSt.toLowerCase()} ";
    formatted += "${date.year} ";

    return formatted;
  }

  static dateIsToday(DateTime timeIn){
    DateTime today = DateTime.now().toLocal();
    DateTime localTime = timeIn.toLocal();
    if(
      today.year==localTime.year
      && today.month==localTime.month
      && today.day==localTime.day
    ) return true;

    return false;

  }

  static String prettyTime(DateTime date){
    var formatter = DateFormat('HH:mm');
    String formatted = formatter.format(date);

    return formatted;
  }

  static List<String> getLargeMonthsstrings(BuildContext context) {
    return [
      AppLocalizations.of(context)!.january,
      AppLocalizations.of(context)!.february,
      AppLocalizations.of(context)!.march,
      AppLocalizations.of(context)!.april,
      AppLocalizations.of(context)!.may,
      AppLocalizations.of(context)!.june,
      AppLocalizations.of(context)!.july,
      AppLocalizations.of(context)!.august,
      AppLocalizations.of(context)!.september,
      AppLocalizations.of(context)!.november,
      AppLocalizations.of(context)!.december
    ];
  }

}