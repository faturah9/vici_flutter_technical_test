import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/login_bloc.dart';

class UsernameInput extends StatefulWidget {
  const UsernameInput({super.key});

  @override
  State<UsernameInput> createState() => _UsernameInputState();
}

class _UsernameInputState extends State<UsernameInput> {
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) => Stack(
        alignment: Alignment.centerRight,
        children: [
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              labelText: 'Username',
              hintText: 'Masukan Username',
            ),
            onChanged: (value) => sl<LoginBloc>().add(
              UsernameChangedEvent(value),
            ),
          )
        ],
      ),
    );
  }
}
