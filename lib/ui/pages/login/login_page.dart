import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_target_sistemas/presentation/presenter/presenter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final presenter = GetIt.I<LoginPresenterStore>();

    return Scaffold(
      body: Observer(builder: (context) {
        if (presenter.redirectPage) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.pushReplacement(presenter.redirect!);
          });
        }
        if (presenter.hasError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  presenter.error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
                duration: const Duration(seconds: 2),
                backgroundColor: Theme.of(context).colorScheme.errorContainer,
              ),
            );

            presenter.setErrorNull();
          });
        }

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * .2),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorText:
                          presenter.isEmailValid || presenter.email.isEmpty
                              ? null
                              : 'Email inválido',
                    ),
                    onChanged: (value) => presenter.setEmail(value),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () => presenter.togglePasswordVisibility(),
                          icon: Icon(presenter.isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        labelText: 'Senha',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        errorText: presenter.isPasswordValid ||
                                presenter.password.isEmpty
                            ? null
                            : 'A senha deve conter no mínimo 2 caracteres e não ter caracters especiais'),
                    onChanged: (value) => presenter.setPassword(value),
                    obscureText: presenter.isPasswordVisible,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 65,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed:
                          !presenter.canLogin || presenter.isLoading == true
                              ? null
                              : () => presenter.auth(),
                      child: presenter.isLoading
                          ? const Center(
                              child: CircularProgressIndicator.adaptive(),
                            )
                          : const Text('Entrar'),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .2),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      onPressed: () => presenter.goPrivacyPolicy(),
                      child: const Text('Política de privacidade'),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
