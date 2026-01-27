import 'package:app_abelhas/core/extensions/color_extension.dart';
import 'package:app_abelhas/core/theme/app_primitive_colors.dart';
import 'package:app_abelhas/core/theme/app_text_style.dart';
import 'package:app_abelhas/data/models/user_model.dart';
import 'package:app_abelhas/presentation/providers/register_provider.dart';
import 'package:app_abelhas/presentation/widgets/custom_button.dart';
import 'package:app_abelhas/presentation/widgets/custom_text_field.dart';
import 'package:app_abelhas/presentation/widgets/custom_toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  String _userType = 'Agricultor';

  void setUserType(String value) {
    setState(() {
      _userType = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<RegisterProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                    label: 'Nome completo',
                    isRequired: true,
                    controller: _nameController),
                const SizedBox(height: 16),
                CustomTextFormField(
                  label: 'E-mail',
                  fieldType: FieldType.email,
                  controller: _emailController,
                  isRequired: true,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  label: 'Telefone',
                  fieldType: FieldType.phone,
                  controller: _phoneController,
                  isRequired: true,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  label: 'Data de nascimento',
                  fieldType: FieldType.date,
                  controller: _dateController,
                  isRequired: true,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  label: 'Criar senha',
                  fieldType: FieldType.password,
                  controller: _passwordController,
                  isRequired: true,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  label: 'Confirmar senha',
                  fieldType: FieldType.password,
                  controller: _password2Controller,
                  isRequired: true,
                ),
                const SizedBox(height: 16),
                Text('Tipo de usuário',
                    style: AppTextStyle.titleLarge(Colors.black)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    ChoiceChip(
                      label: const Text('Agricultor'),
                      selected: _userType == 'Agricultor',
                      onSelected: (selected) {
                        if (selected) {
                          setUserType('Agricultor');
                        }
                      },
                      selectedColor: AppPrimitiveColors.green.color300(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: _userType == 'Agricultor'
                              ? AppPrimitiveColors.green.color300()
                              : Colors.grey,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text('Apicultor'),
                      selected: _userType == 'Apicultor',
                      onSelected: (selected) {
                        if (selected) {
                          setUserType('Apicultor');
                        }
                      },
                      selectedColor: AppPrimitiveColors.green.color300(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: _userType == 'Apicultor'
                              ? AppPrimitiveColors.green.color300()
                              : Colors.grey,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                    )
                  ],
                ),
                SizedBox(
                  height: 64,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButtonWidget(
                      type: CustomButtonType.primary,
                      label: 'Cadastrar',
                      isLoading: provider.isLoading,
                      onPressed: () {
                        cadastrar(provider);
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void cadastrar(RegisterProvider provider) async {
    if (!_formKey.currentState!.validate()) return;
    if (_passwordController.text != _password2Controller.text) {
      return CustomToastWidget.show(
          type: CustomToastType.error,
          context: context,
          title: 'As senhas devem ser iguais');
    }
    if (_passwordController.text.length < 6) {
      return CustomToastWidget.show(
          type: CustomToastType.error,
          context: context,
          title: 'A senha deve ter no mínimo 6 caracteres');
    }
    final result = await provider.signUp(UserModel(
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
        phone: _phoneController.text,
        birthDate: _parseDate(_dateController.text),
        type: _userType,
        gender: '-'));
    if (result) {
      context.go('/home');
    } else {
      return CustomToastWidget.show(
          type: CustomToastType.error,
          context: context,
          title: 'Ocorreu um erro no cadastro');
    }
  }

  DateTime? _parseDate(String input) {
    final parts = input.split('/');
    if (parts.length != 3) throw FormatException('Formato inválido');
    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);
    return DateTime(year, month, day);
  }
}
