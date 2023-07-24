import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vici_technical_test/injection_container.dart';

import '../bloc/register_bloc.dart';

class RegisPasswordInput extends StatefulWidget {
  const RegisPasswordInput({super.key});

  @override
  State<RegisPasswordInput> createState() => _RegisPasswordInputState();
}

class _RegisPasswordInputState extends State<RegisPasswordInput> {
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.isObscure != current.isObscure,
      builder: (context, state) => Stack(
        alignment: Alignment.centerRight,
        children: [
          TextField(
            controller: _passwordController,
            obscureText: state.isObscure!,
            decoration: InputDecoration(
              icon: const Icon(Icons.lock),
              labelText: 'Password',
              hintText: 'Masukan Password',
              suffixIcon: Icon(
                state.isObscure! ? Icons.visibility : Icons.visibility_off,
              ),
            ),
            onChanged: (value) => sl<RegisterBloc>().add(
              PasswordChangedEvent(value),
            ),
          ),
          IconButton(
            onPressed: () {
              sl<RegisterBloc>().add(
                ToggleObscureEvent(!state.isObscure!),
              );
            },
            icon: Icon(
              state.isObscure! ? Icons.visibility : Icons.visibility_off,
              color: Colors.transparent,
            ),
          )
        ],
      ),
    );
  }
}
