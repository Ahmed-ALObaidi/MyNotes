import 'package:get/get.dart';

class local implements Translations{
  @override
  Map<String, Map<String, String>> get keys => {
    "ar" : {
      "1" : "الصفحة الرئيسية",
      "2" : "عربي",
      "3" : "انكليزي",
      "4" : "تغيير الثيم",
      "5" : "اختر لغة التطبيق : "
    },
    "en" : {
      "1" : "Home Page",
      "2" : "arabic",
      "3" : "English",
      "4" : "Change Theme",
      "5" : "Choose Language : "
    },
  };

}