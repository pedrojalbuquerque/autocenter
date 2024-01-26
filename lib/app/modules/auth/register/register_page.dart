import 'package:autocenter/app/core/ui/theme_extensions.dart';
import 'package:autocenter/app/core/validatores/validators.dart';
import 'package:autocenter/app/core/widgets/auto_center_field.dart';
import 'package:autocenter/app/core/widgets/auto_center_logo.dart';
import 'package:autocenter/app/modules/auth/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _loginEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<RegisterController>().addListener(() {
      final controller = context.read<RegisterController>();
      var success = controller.success;
      var error = controller.error;
      if (success) {
        Navigator.of(context).pop();
      } else if (error != null && error.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _loginEC.dispose();
    _passwordEC.dispose();
    _confirmPasswordEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Auto Center',
                style: TextStyle(
                  height: 1.2,
                  fontSize: 25,
                  color: context.primaryColor,
                )),
            Text('Cadastro',
                style: TextStyle(
                  height: 1.2,
                  fontSize: 18,
                  color: context.primaryColor,
                )),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: ClipOval(
            child: Container(
              color: context.primaryColor.withAlpha(20),
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.arrow_back_ios_outlined,
                size: 20,
                color: context.primaryColor,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Card(
            elevation: 5,
            color: Colors.blueGrey[50],
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width * .13,
                    child: const FittedBox(
                      fit: BoxFit.fitHeight,
                      child: AutoCenterLogo(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          AutoCenterField(
                            controller: _loginEC,
                            label: 'Login',
                            validator: Validatorless.multiple(
                              [
                                Validatorless.required('Login é obrigatório.'),
                                Validatorless.min(4,
                                    'Login tem que ter pelo menos 4 caracteres'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          AutoCenterField(
                            controller: _passwordEC,
                            label: 'Senha',
                            validator: Validatorless.multiple(
                              [
                                Validatorless.required('Senha é obrigatório.'),
                                Validatorless.min(5,
                                    'Senha tem que ter pelo menos 6 caracteres'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          AutoCenterField(
                            controller: _confirmPasswordEC,
                            label: 'Confirma Senha',
                            obscureText: true,
                            validator: Validatorless.multiple(
                              [
                                Validatorless.required(
                                    'Confirma senha é obrigatório.'),
                                Validators.compare(
                                    _passwordEC, 'Senha são diferentes.')
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                              onPressed: () {
                                final formValid =
                                    _formKey.currentState?.validate() ?? false;
                                if (formValid) {
                                  final login = _loginEC.text;
                                  final password = _passwordEC.text;
                                  context
                                      .read<RegisterController>()
                                      .registerUser(login, password);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                              child: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Text('Salvar'),
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
          ),
        ),
      ),
    );
  }
}
