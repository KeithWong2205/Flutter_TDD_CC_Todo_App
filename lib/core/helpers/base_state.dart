import 'package:flutter_tcc_base_source/core/helpers/resume_base_custom.dart';
import 'package:flutter_tcc_base_source/generated/locale_base.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends ResumeState<T>
    with Diagnosticable {
  LocaleBase? loc;

  @override
  Widget build(BuildContext context) {
    initContent();
    return const SizedBox();
  }

  void initContent() {
    loc = Localizations.of<LocaleBase>(context, LocaleBase)!;
  }
}
