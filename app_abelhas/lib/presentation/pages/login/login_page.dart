import 'package:app_abelhas/core/di/service_locator.dart';
import 'package:app_abelhas/core/helpers/sizes_helper.dart';
import 'package:app_abelhas/core/theme/app_primitive_colors.dart';
import 'package:app_abelhas/core/theme/app_text_style.dart';
import 'package:app_abelhas/presentation/pages/login/login_cubit.dart';
import 'package:app_abelhas/presentation/widgets/custom_button.dart';
import 'package:app_abelhas/presentation/widgets/custom_text_field.dart';
import 'package:app_abelhas/presentation/widgets/custom_toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final LoginCubit _cubit;

  @override
  void initState() {
    _cubit = getIt.get<LoginCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    await _cubit.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _cubit,
        child: BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is RedirectToPage) {
                context.go(state.route);
              }
              if (state is LoginError) {
                CustomToastWidget.show(
                    type: CustomToastType.error,
                    context: context,
                    title: 'Falha ao fazer login');
              }
            },
            child: Scaffold(
              backgroundColor: Colors.green.shade600,
              body: SafeArea(
                child: Stack(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Olá!',
                                    style: AppTextStyle.displayMedium(
                                        AppPrimitiveColors.white),
                                  ),
                                  Text(
                                    'Seja bem-vindo(a)',
                                    style: AppTextStyle.headlineLarge(
                                        AppPrimitiveColors.white),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                            Container(
                              decoration: BoxDecoration(
                                  color: AppPrimitiveColors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(36),
                                      topRight: Radius.circular(36))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0),
                                child: Form(
                                  autovalidateMode: AutovalidateMode.onUnfocus,
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 40),
                                      const Text(
                                        'Acesso',
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 32),
                                      CustomTextFormField(
                                        label: 'E-mail',
                                        isRequired: true,
                                        fieldType: FieldType.email,
                                        controller: _emailController,
                                      ),
                                      const SizedBox(height: 16),
                                      CustomTextFormField(
                                        label: 'Senha',
                                        fieldType: FieldType.password,
                                        controller: _passwordController,
                                        isRequired: true,
                                      ),
                                      const SizedBox(height: 12),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: GestureDetector(
                                          onTap: () {
                                            // implementar recuperação de senha
                                          },
                                          child: const Text(
                                            'Esqueceu sua senha?',
                                            style: TextStyle(
                                              color: Colors.teal,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      BlocBuilder<LoginCubit, LoginState>(
                                        bloc: _cubit,
                                        builder: (context, state) {
                                          return CustomButtonWidget(
                                              type: CustomButtonType.primary,
                                              label: 'Entrar',
                                              isLoading: state is LoginLoading,
                                              onPressed: () {
                                                _login();
                                              });
                                        },
                                      ),
                                      SizedBox(
                                          height:
                                              displayHeight(context) * 0.07),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: EdgeInsets.only(bottom: 24),
                                          child: TextButton(
                                            onPressed: () {
                                              context.push('/register');
                                            },
                                            child: RichText(
                                              text: const TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Não tem uma conta? ',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  TextSpan(
                                                    text: 'Cadastrar-se',
                                                    style: TextStyle(
                                                      color: Colors.teal,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
