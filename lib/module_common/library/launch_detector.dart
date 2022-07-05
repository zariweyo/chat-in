
enum LaunchDetectorType {
  none,
  phone,
  url,
  email
}

class LaunchDetector {
  static LaunchDetectorType detector(String str){
    Uri? tryPar = Uri.tryParse(str);
    if(tryPar!=null && tryPar.isAbsolute){
      return LaunchDetectorType.url;
    }

    String regexPhonePattern1 = r'^(?:[+0][1-9])?[0-9]{10,12}$';
    String regexPhonePattern2 = r'^[0-9]{9}$';
    var regPhoneExp1 = RegExp(regexPhonePattern1);
    var regPhoneExp2 = RegExp(regexPhonePattern2);

    if (regPhoneExp1.hasMatch(str) || regPhoneExp2.hasMatch(str)) {
      return LaunchDetectorType.phone;
    }

    String regexEmailPattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    var regEmailExp = RegExp(regexEmailPattern);

    if (regEmailExp.hasMatch(str)) {
      return LaunchDetectorType.email;
    }

    return LaunchDetectorType.none;
  }
}