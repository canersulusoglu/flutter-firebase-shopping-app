// ignore_for_file: file_names
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FormValidator{
  static final FormValidator _instance = FormValidator._internal();
  factory FormValidator() {
    return _instance;
  }
  FormValidator._internal();
  
  bool? required = false;
  int? minimumCharCount = 0;
  int? maximumCharCount = 0;
  bool? isEmail = false;
  String? matchedString;
  FormValidator.validate({
    this.required,
    this.minimumCharCount,
    this.maximumCharCount,
    this.isEmail,
    this.matchedString
  });
  
  String? getMessage(context, String value){
    if(required! == true){
      if(value.isEmpty){
        return AppLocalizations.of(context)!.formValidatorRequired; //
      }
    }
    if(minimumCharCount != null && minimumCharCount! > 0){
      if(value.length < minimumCharCount!){
        return AppLocalizations.of(context)!.formValidatorMinimumCharCount(minimumCharCount!); //
      }
    }
    if(maximumCharCount != null && maximumCharCount! > 0){
      if(value.length > maximumCharCount!){
        return AppLocalizations.of(context)!.formValidatorMaximumCharCount(maximumCharCount!); //
      }
    }
    if(isEmail != null && isEmail! == true){
      if(!value.isEmail()){
        return AppLocalizations.of(context)!.formValidatorIsEmail; //
      }
    }
    if(matchedString != null){
      if(value != matchedString){
        return AppLocalizations.of(context)!.formValidatorMatchedString; //
      }
    }
    return null;
  }
}

extension EmailValidator on String {
  bool isEmail() {
    if (this == null || this.isEmpty) {
      return false;
    }

    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(this)) {
      return false;
    }
    return true;
  }
}