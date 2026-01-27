import 'package:app_abelhas/core/theme/app_primitive_colors.dart';
import 'package:app_abelhas/core/theme/app_spacing.dart';
import 'package:app_abelhas/core/theme/font/app_font_weight.dart';
import 'package:app_abelhas/presentation/widgets/custom_button.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomModalWidget {
  static Future<void> showSuccessModal({
    required BuildContext context,
    String? title,
    String? message,
    bool showCloseButton = true,
    VoidCallback? onClosed,
    bool autoClose = true,
    bool isFullscreenMode = false,
  }) async {
    // final locale = AppLocalizations.of(context)!;
    return showIconModal(
        title: title ?? 'Sucesso',
        // iconPath: AppIconPaths.iconSuccessOutline,
        context: context,
        message: message ?? '-',
        showCloseButton: showCloseButton,
        autoClose: autoClose,
        onClosed: onClosed,
        isFullscreenMode: isFullscreenMode);
  }

  static Future<void> showFailModal({
    required BuildContext context,
    String? title,
    String? message,
    bool showCloseButton = true,
    VoidCallback? onClosed,
    bool autoClose = true,
    bool isFullscreenMode = false,
  }) async {
    // final locale = AppLocalizations.of(context)!;
    return showIconModal(
        title: title ?? '-',
        // iconPath: AppIconPaths.iconFailureOutline,
        context: context,
        message: message ?? '-',
        showCloseButton: showCloseButton,
        onClosed: onClosed,
        autoClose: autoClose,
        isFullscreenMode: isFullscreenMode);
  }

  static Future<void> showIconModal({
    required String title,
    // required String iconPath,
    required BuildContext context,
    String message = '',
    bool showCloseButton = true,
    bool autoClose = true,
    bool isFullscreenMode = false,
    VoidCallback? onClosed,
    bool useDefaultIconColor = true,
  }) async {
    final textStyle = Theme.of(context).textTheme;
    return showModal(
      title: title,
      context: context,
      autoClose: autoClose,
      isFullscreenMode: isFullscreenMode,
      content: Column(
        children: [
          // AppSvgWidget(
          //   path: iconPath,
          //   height: 128,
          //   width: 128,
          //   useDefaultIconColor: useDefaultIconColor,
          // ),
          // const SizedBox(
          //   height: AppSpacing.p24,
          // ),
          Visibility(
            visible: message.isNotEmpty,
            child: Text(
              message,
              style: textStyle.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      showCloseButton: showCloseButton,
      onClosed: onClosed,
    );
  }

  static Future<void> showModal({
    required BuildContext context,
    required Widget content,
    String title = '',
    bool autoClose = true,
    bool barrierDismissible = true,
    bool showCloseButton = false,
    bool isFullscreenMode = false,
    VoidCallback? onClosed,
    EdgeInsets contentPadding = const EdgeInsets.only(
      bottom: AppSpacing.p16,
      left: AppSpacing.p16,
      right: AppSpacing.p16,
    ),
  }) async {
    final textStyle = Theme.of(context).textTheme;
    return showDialog<void>(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (BuildContext builderContext) {
        if (autoClose) {
          Future.delayed(const Duration(seconds: 4), () {
            if (builderContext.mounted) {
              Navigator.of(context).pop();
            }
          });
        }

        return RotatedBox(
          quarterTurns: isFullscreenMode ? 1 : 0,
          child: Center(
            child: SingleChildScrollView(
              child: AlertDialog(
                contentPadding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: AppSpacing.p16,
                        right: AppSpacing.p16,
                      ),
                      child: AppBar(
                        backgroundColor: AppPrimitiveColors.transparent,
                        elevation: 0,
                        automaticallyImplyLeading: false,
                        title: Visibility(
                          visible: title.isNotEmpty,
                          child: Text(
                            title,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: textStyle.titleMedium,
                          ),
                        ),
                        // actionsPadding: EdgeInsets.zero,
                        actions: [
                          Visibility(
                            visible: showCloseButton,
                            replacement: const SizedBox(
                              height: 32,
                              width: 32,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                context.pop();
                              },
                              child: SizedBox(
                                height: 32,
                                width: 32,
                                child: Center(
                                  child: Icon(
                                    FeatherIcons.x,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: contentPadding,
                      child: content,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ).then((value) {
      onClosed?.call();
    });
  }

  static Future<void> showConfirmModal({
    required BuildContext context,
    required String message,
    required String confirmLabel,
    required String cancelLabel,
    Color? iconColor,
    String title = '',
    String questionMessage = "",
    Widget? confirmIcon,
    Widget? cancelIcon,
    Future<void> Function()? onConfirm,
    Future<void> Function()? onCancel,
    IconData? iconPath,
    bool useDefaultIconColor = true,
    bool isFullscreenMode = false,
    bool popWhenOnConfirm = true,
  }) async {
    final textStyle = Theme.of(context).textTheme;
    return showModal(
      context: context,
      title: title,
      autoClose: false,
      isFullscreenMode: isFullscreenMode,
      barrierDismissible: false,
      content: PopScope(
        canPop: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: iconPath != null,
              child: Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.p12),
                child: Icon(
                  iconPath,
                  size: 128,
                  color: iconColor,
                ),
              ),
            ),
            Visibility(
              visible: questionMessage.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.p8),
                child: Text(
                  questionMessage,
                  style: textStyle.bodyLarge
                      ?.copyWith(fontWeight: AppFontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Text(
              message,
              style: textStyle.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.p16),
            CustomButtonWidget(
              type: CustomButtonType.secondary,
              label: cancelLabel,
              icon: cancelIcon,
              onPressed: () {
                onCancel?.call();
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(height: AppSpacing.p8),
            CustomButtonWidget(
              type: CustomButtonType.primary,
              label: confirmLabel,
              icon: confirmIcon,
              onPressed: () async {
                onConfirm?.call();
                if (popWhenOnConfirm) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  static BuildContext? _loadingModalContext;

  static Future<void> showLoadingModal({
    required BuildContext context,
    String? title,
    String? message,
    bool isFullscreenMode = false,
  }) async {
    // final locale = AppLocalizations.of(context)!;

    final textStyle = Theme.of(context).textTheme;
    _loadingModalContext = context;
    return showModal(
      title: title ?? '-',
      context: context,
      autoClose: false,
      isFullscreenMode: isFullscreenMode,
      content: PopScope(
        canPop: false,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.p36),
              child: CircularProgressIndicator(),
            ),
            const SizedBox(
              height: AppSpacing.p24,
            ),
            Text(
              message ?? 'Por favor, aguarde',
              style: textStyle.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void closeLoadingModal() {
    _loadingModalContext?.pop();
    _loadingModalContext = null;
  }
}
