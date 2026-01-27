import 'package:app_abelhas/core/extensions/color_extension.dart';
import 'package:app_abelhas/core/theme/app_primitive_colors.dart';
import 'package:app_abelhas/core/theme/app_spacing.dart';
import 'package:app_abelhas/core/theme/app_style.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

enum CustomToastType {
  basic,
  success,
  info,
  warning,
  error,
}

enum CustomToastDuration {
  normal(Duration(seconds: 5)),
  long(Duration(seconds: 10));

  const CustomToastDuration(this.duration);

  final Duration duration;
}

class CustomToastWidget {
  static void show({
    required CustomToastType type,
    required BuildContext context,
    required String title,
    String message = "",
    String defaultMessage = "",
    CustomToastDuration durationType = CustomToastDuration.normal,
  }) {
    final appStyle = Theme.of(context).extension<AppStyle>()!;
    final backgroundColor = switch (type) {
      CustomToastType.basic => appStyle.backgroundColor,
      CustomToastType.success => appStyle.successColor,
      CustomToastType.info => appStyle.infoColor,
      CustomToastType.warning => appStyle.warningColor,
      CustomToastType.error => appStyle.errorColor,
    };
    final icon = switch (type) {
      CustomToastType.basic => FeatherIcons.info,
      CustomToastType.success => FeatherIcons.checkCircle,
      CustomToastType.info => FeatherIcons.info,
      CustomToastType.warning => FeatherIcons.alertTriangle,
      CustomToastType.error => FeatherIcons.alertCircle,
    };
    final foregroundColor = (type == CustomToastType.basic)
        ? appStyle.neutralColor
        : AppPrimitiveColors.white;
    final snackBar = _getSnackBar(
      context: context,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      title: title,
      icon: icon,
      message: message,
      defaultMessage: defaultMessage,
      durationType: durationType,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static SnackBar _getSnackBar({
    required BuildContext context,
    required Color backgroundColor,
    required Color foregroundColor,
    required IconData icon,
    required String title,
    required String message,
    required String defaultMessage,
    required CustomToastDuration durationType,
  }) {
    final textStyle = Theme.of(context).textTheme;
    return SnackBar(
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: foregroundColor,
            size: 24,
          ),
          SizedBox(
            width: AppSpacing.p16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textStyle.titleSmall?.copyWith(
                    color: foregroundColor,
                  ),
                ),
                Visibility(
                  visible: message.isNotEmpty,
                  replacement: Visibility(
                    visible: defaultMessage.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.p4),
                      child: Text(
                        defaultMessage,
                        style: textStyle.bodySmall?.copyWith(
                          color: foregroundColor,
                        ),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.p4),
                    child: Text(
                      message,
                      style: textStyle.bodySmall?.copyWith(
                        color: foregroundColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      margin: const EdgeInsets.all(
        AppSpacing.p16,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.p12,
        horizontal: AppSpacing.p16,
      ),
      shape: _CustomSnackBarShape(8.0, backgroundColor.color900().alpha400()),
      duration: durationType.duration,
    );
  }
}

class _CustomSnackBarShape extends RoundedRectangleBorder {
  _CustomSnackBarShape(this.borderRadis, this.borderColor)
      : super(borderRadius: BorderRadius.circular(borderRadis));
  final double borderRadis;
  final Color borderColor;

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final Paint backgroundPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.fill;

    final RRect topBorder = RRect.fromRectAndCorners(
      Rect.fromLTWH(rect.left, rect.top, rect.width, 4),
      topLeft: Radius.circular(borderRadis),
      topRight: Radius.circular(borderRadis),
    );
    canvas.drawRRect(topBorder, backgroundPaint);
  }
}
