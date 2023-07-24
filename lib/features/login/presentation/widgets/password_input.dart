import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/login_bloc.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({super.key});

  @override
  State<PasswordInput> createState() => PasswordInputState();
}

class PasswordInputState extends State<PasswordInput> {
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.isObscure != current.isObscure,
      builder: (context, state) => Stack(
        alignment: Alignment.centerRight,
        children: [
          TextField(
            controller: _passwordController,
            obscureText: state.isObscure!,
            decoration: InputDecoration(
              icon: const Icon(Icons.lock),
              labelText: 'Kata Sandi',
              hintText: 'Masukan Kata Sandi',
              suffixIcon: Icon(
                state.isObscure! ? Icons.visibility : Icons.visibility_off,
              ),
            ),
            onChanged: (value) => sl<LoginBloc>().add(
              PasswordChangedEvent(value),
            ),
          ),
          IconButton(
            onPressed: () {
              sl<LoginBloc>().add(
                ToggleObscureEvent(!state.isObscure!),
              );
            },
            icon: Icon(
              state.isObscure! ? Icons.visibility : Icons.visibility_off,
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
