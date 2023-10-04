import 'package:flutter/material.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/widgets/button/button_right_radius.dart';

import 'form_group.dart';

class CustomTextRightButton extends StatefulWidget {
  final String hintText;
  final String buttonText;
  final List<Color> gradient;
  final TextInputType textInputType;
  final bool isShowClearText;
  final Function(String) textChange;
  final String? Function(String?)? validator;
  final int? maxLength;
  final Color? textButtonColor;
  final Function onTapButton;

  const CustomTextRightButton({
    Key? key,
    required this.hintText,
    required this.textChange,
    required this.textInputType,
    required this.isShowClearText,
    this.maxLength,
    required this.onTapButton,
    required this.gradient,
    this.textButtonColor,
    required this.buttonText,
    this.validator,
  }) : super(key: key);

  @override
  State<CustomTextRightButton> createState() => _CustomTextRightButtonState();
}

class _CustomTextRightButtonState extends State<CustomTextRightButton> {
  final key = GlobalKey<FormState>();
  FormProvider? formProvider;
  late final TextEditingController _controller;
  bool disable = true;

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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              onChanged: (value) {
                if (formProvider != null) {
                  formProvider?.validator[key] = key.currentState!.validate();
                }
                widget.textChange.call(value);
              },
              maxLength: widget.maxLength ?? 20,
              keyboardType: widget.textInputType,
              style: textNormalCustom(
                color: AppTheme.getInstance().getBlackText(),
                fontSize: 14,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppTheme.getInstance().borderColor(),
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    bottomLeft: Radius.circular(6),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppTheme.getInstance().borderColor(),
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    bottomLeft: Radius.circular(6),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppTheme.getInstance().borderColor(),
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    bottomLeft: Radius.circular(6),
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppTheme.getInstance().borderColor(),
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    bottomLeft: Radius.circular(6),
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppTheme.getInstance().borderColor(),
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    bottomLeft: Radius.circular(6),
                  ),
                ),
                counterText: '',
                hintText: widget.hintText,
                hintStyle: textNormal(
                  AppTheme.getInstance().hintTextColor(),
                  14,
                ),
              ),
              validator: (value) {
                if (widget.validator != null) {
                  return widget.validator!(value);
                }

                return null;
              },
            ),
          ),
          Expanded(
            child: ButtonRight(
              title: widget.buttonText,
              titleColor: widget.textButtonColor,
              gradient: LinearGradient(
                colors: widget.gradient,
              ),
              onPressed: widget.onTapButton,
            ),
          ),
        ],
      ),
    );
  }
}
