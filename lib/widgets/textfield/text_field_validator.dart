import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/widgets/textfield/form_group.dart';

class TextFieldValidator extends StatefulWidget {
  final String? initialValue;
  final bool isEnabled;
  final Function(String)? onChange;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final TextInputType? textInputType;
  final int maxLine;
  final int? maxLength;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final bool? onlyTextField;
  final FocusNode? focusNode;

  const TextFieldValidator({
    Key? key,
    this.maxLength,
    this.inputFormatters,
    this.isEnabled = true,
    this.onChange,
    this.validator,
    this.initialValue,
    this.maxLine = 1,
    this.textInputType,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.obscureText,
    this.fillColor,
    this.onlyTextField,
    this.focusNode,
  }) : super(key: key);

  @override
  State<TextFieldValidator> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFieldValidator> {
  final key = GlobalKey<FormState>();
  FormProvider? formProvider;
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    formProvider = FormProvider.of(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (formProvider != null) {
        if (widget.validator != null) {
          final validator = widget.validator!(_controller.text) == null;
          formProvider?.validator.addAll({key: validator});
        } else {
          formProvider?.validator.addAll({key: true});
        }
      }
    });
    if (formProvider != null) {
      formProvider?.validator.addAll({key: true});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: TextFormField(
        focusNode: widget.focusNode,
        controller: _controller,
        obscureText: widget.obscureText ?? false,
        onChanged: (value) {
          if (formProvider != null) {
            formProvider?.validator[key] = key.currentState!.validate();
          }
          widget.onChange?.call(value);
        },
        initialValue: widget.initialValue,
        keyboardType: widget.textInputType,
        maxLength: widget.maxLength,
        inputFormatters: widget.inputFormatters,
        maxLines: widget.maxLine,
        onTap: () {
          widget.onTap?.call();
        },
        style: textNormalCustom(
          fontSize: 14.0,
          color: AppTheme.getInstance().getBlackText(),
        ),
        enabled: widget.isEnabled,
        decoration: widget.onlyTextField == true
            ? InputDecoration(
                hintText: widget.hintText,
                hintStyle: textNormal(
                  AppTheme.getInstance().getBlackText().withOpacity(0.5),
                  14,
                ),
                contentPadding: widget.maxLine == 1
                    ? const EdgeInsets.symmetric(vertical: 14, horizontal: 10)
                    : null,
                suffixIcon: widget.suffixIcon,
                prefixIcon: widget.prefixIcon,
                fillColor: widget.isEnabled
                    ? widget.fillColor ?? Colors.transparent
                    : AppTheme.getInstance().borderColor().withOpacity(0.3),
                filled: true,
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppTheme.getInstance().borderColor()),
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppTheme.getInstance().borderColor()),
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppTheme.getInstance().borderColor()),
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppTheme.getInstance().borderColor()),
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppTheme.getInstance().borderColor()),
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                ),
              )
            : null,
        validator: (value) {
          if (widget.validator != null) {
            return widget.validator!(value);
          }
          return null;
        },
      ),
    );
  }
}
