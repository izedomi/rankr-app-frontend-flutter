import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../app/enum/keyboard_type.dart';
import 'media_query.dart';

TextInputType inputType(KeyboardType textInputType) {
  if (textInputType == KeyboardType.email) {
    return TextInputType.emailAddress;
  }
  if (textInputType == KeyboardType.decimal) {
    return const TextInputType.numberWithOptions(decimal: true);
  }
  if (textInputType == KeyboardType.number ||
      textInputType == KeyboardType.phone ||
      textInputType == KeyboardType.bvn ||
      textInputType == KeyboardType.accountNo ||
      textInputType == KeyboardType.passcode ||
      textInputType == KeyboardType.decimal) {
    return TextInputType.number;
  }
  return TextInputType.visiblePassword;
}

List<TextInputFormatter> inputFormatter(KeyboardType textInputType,
    {int? fieldLength}) {
  if (textInputType == KeyboardType.decimal) {
    return [
      LengthLimitingTextInputFormatter(fieldLength ?? 10),
      CurrencyTextInputFormatter(
        locale: 'en_US',
        decimalDigits: 0,
        symbol: ' ',
      ),
      //LengthLimitingTextInputFormatter(fieldLength),
      // FilteringTextInputFormatter.allow(
      //     RegExp(r"^(?!0+\.0+$)\d{1,3}(?:,\d{3}|\d)*(?:\.\d{2})?$"))
    ];
  }
  if (fieldLength != null) {
    return <TextInputFormatter>[
      LengthLimitingTextInputFormatter(fieldLength),
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
    ];
  }

  if (textInputType == KeyboardType.number) {
    // return <TextInputFormatter>[
    //   //  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
    // ];
    return [
      FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
      // FilteringTextInputFormatter.allow(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))')),

      // FilteringTextInputFormatter.allow(
      //     RegExp(r"^(?!0+\.0+$)\d{1,3}(?:,\d{3}|\d)*(?:\.\d{2})?$")),
    ];
  }
  if (textInputType == KeyboardType.accountNo) {
    return <TextInputFormatter>[
      LengthLimitingTextInputFormatter(10),
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
    ];
  }
  if (textInputType == KeyboardType.phone ||
      textInputType == KeyboardType.bvn) {
    return <TextInputFormatter>[
      LengthLimitingTextInputFormatter(11),
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
    ];
  }

  if (textInputType == KeyboardType.otp) {
    return <TextInputFormatter>[
      LengthLimitingTextInputFormatter(6),
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
    ];
  }
  if (textInputType == KeyboardType.passcode) {
    return <TextInputFormatter>[
      LengthLimitingTextInputFormatter(4),
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
    ];
  }
  return <TextInputFormatter>[];
}

KeyboardType getKeyBoardType(String type) {
  if (type.toLowerCase() == "decimal") {
    return KeyboardType.decimal;
  }
  if (type.toLowerCase() == "number") {
    return KeyboardType.number;
  }
  if (type.toLowerCase() == "string") {
    return KeyboardType.regular;
  }

  return KeyboardType.regular;
}

textFieldHeight(context) {
  double textFieldHeight = 48.h;
  if (deviceHeight(context) <= 534) {
    return textFieldHeight = 60.h;
  }
  if (deviceHeight(context) <= 914) {
    return textFieldHeight = 56.h;
  }
  if (deviceHeight(context) <= 926) {
    return textFieldHeight = 48.h;
  }
  if (deviceHeight(context) <= 1232) {
    return textFieldHeight = 60.h;
  }

  return textFieldHeight;
}
