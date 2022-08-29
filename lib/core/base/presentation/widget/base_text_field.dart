import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tcc_base_source/core/helpers/app_constants.dart';

class BaseTextField extends StatefulWidget {
  final double? height;

  final String? hintText;

  final bool? enabled;

  final bool? showOutline;

  final TextInputType? keyboardType;

  final TextInputAction? textInputAction;

  final ValueChanged<String>? onChanged;

  final List<TextInputFormatter>? inputFormatters;

  final ValueChanged<String>? onFieldSubmitted;

  final FormFieldValidator<String>? validator;

  final bool obscureText;

  final TextCapitalization textCapitalization;

  final Color? background;

  final Color? colorText;

  final Color? colorHintText;

  final Color? borderColor;

  final double borderRadius;

  final TextAlign? textAlign;

  final double? fontSize;

  final double? widthBorder;

  final EdgeInsets? margin;

  final Alignment? alignment;

  final bool? isCollapsed;

  final FontWeight? fontWeight;

  final EdgeInsets? padding;

  final double rightPosition;

  final Widget? suffix;

  final int? maxLength;

  final Function? onFocusChange;

  final TextEditingController? textEditingController;

  final bool alert;

  final String alertMessage;

  final Function? onTapSuffix;

  final Function(FocusNode focusNode)? onWidgetReady;

  final FocusNode? focusNode;

  const BaseTextField({
    Key? key,
    this.focusNode,
    this.height,
    this.hintText,
    this.enabled,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.validator,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.background,
    this.borderColor,
    this.borderRadius = 8.0,
    this.colorText,
    this.textAlign = TextAlign.start,
    this.fontSize = 14.0,
    this.widthBorder = 0.0,
    this.margin = EdgeInsets.zero,
    this.showOutline = false,
    this.alignment,
    this.isCollapsed = false,
    this.fontWeight,
    this.padding,
    this.colorHintText,
    this.rightPosition = 0.0,
    this.suffix,
    this.maxLength,
    this.onFocusChange,
    this.textEditingController,
    this.alert = false,
    this.alertMessage = '',
    this.onTapSuffix,
    this.onWidgetReady,
  }) : super(key: key);

  @override
  _BaseTextFieldState createState() => _BaseTextFieldState();
}

class _BaseTextFieldState extends State<BaseTextField> {
  FocusNode focusNode = FocusNode();

  void _onFocusChange() {
    if (widget.onFocusChange != null) {
      if (!focusNode.hasFocus) {
        widget.onFocusChange!(widget.textEditingController!.text);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.focusNode != null) {
      focusNode = widget.focusNode!;
    }
    focusNode.addListener(() {
      _onFocusChange();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.onWidgetReady != null) {
      widget.onWidgetReady!(focusNode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: widget.alignment ?? Alignment.centerLeft,
          margin: widget.margin,
          height: widget.height ?? 56.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            color: widget.alert
                ? Colors.red.withAlpha(20)
                : widget.background ?? Colors.white,
            border: Border.all(
              color: widget.alert
                  ? Colors.red
                  : widget.borderColor ?? Colors.transparent,
              width: 1.0,
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: widget.suffix != null ? 40.0 : 0.0,
                ),
                child: TextFormField(
                  maxLengthEnforcement:
                      MaxLengthEnforcement.truncateAfterCompositionEnds,
                  textAlign: widget.textAlign!,
                  textAlignVertical: TextAlignVertical.center,
                  obscureText: widget.obscureText,
                  textCapitalization: widget.textCapitalization,
                  enabled: widget.enabled,
                  controller: widget.textEditingController,
                  onChanged: widget.onChanged,
                  keyboardType: widget.keyboardType,
                  textInputAction: widget.textInputAction,
                  onFieldSubmitted: widget.onFieldSubmitted,
                  validator: widget.validator,
                  focusNode: focusNode,
                  key: widget.key,
                  maxLength: widget.maxLength,
                  style: TextStyle(
                    fontSize: widget.fontSize!,
                    color: widget.colorText ?? Colors.black,
                  ),
                  scrollPadding: const EdgeInsets.only(
                    bottom: 60.0,
                    top: 10.0,
                  ),
                  decoration: InputDecoration(
                    contentPadding: widget.padding ?? EdgeInsets.zero,
                    isCollapsed: widget.isCollapsed!,
                    border: InputBorder.none,
                    hintText: widget.hintText,
                    counterText: '',
                    labelStyle: TextStyle(
                      fontSize: widget.fontSize!,
                      color: widget.colorText ?? Colors.black,
                    ),
                    hintStyle: TextStyle(
                      fontSize: widget.fontSize!,
                      color: widget.colorHintText ?? Colors.grey,
                      fontWeight: widget.fontWeight ?? FontWeight.w400,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      borderSide: BorderSide(
                        color: widget.showOutline!
                            ? Colors.white
                            : Colors.transparent,
                        width: widget.widthBorder!,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      borderSide: BorderSide(
                        color: widget.showOutline!
                            ? Colors.black
                            : Colors.transparent,
                        width: widget.widthBorder ?? 0.0,
                      ),
                    ),
                  ),
                  inputFormatters: widget.inputFormatters,
                ),
              ),
              Visibility(
                visible: widget.suffix != null,
                child: Positioned(
                  bottom: 0.0,
                  top: 0.0,
                  right: widget.rightPosition,
                  child: GestureDetector(
                    onTap: () => widget.onTapSuffix != null
                        ? widget.onTapSuffix!()
                        : () {},
                    child: Center(
                      child: widget.suffix ?? const SizedBox(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: widget.alert,
          child: Text(
            widget.alertMessage,
            style: AppConstants.textDefault.copyWith(
              color: Colors.red,
            ),
          ),
        )
      ],
    );
  }
}
