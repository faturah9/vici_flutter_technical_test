import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/register_bloc.dart';

class RegisUsernameInput extends StatefulWidget {
  const RegisUsernameInput({super.key});

  @override
  State<RegisUsernameInput> createState() => _RegisUsernameInputState();
}

class _RegisUsernameInputState extends State<RegisUsernameInput> {
  final _usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) => Stack(
        alignment: Alignment.centerRight,
        children: [
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              icon: Icon(Icons.perm_contact_cal),
              labelText: 'Username',
              hintText: 'Masukan Username',
            ),
            onChanged: (value) => context.read<RegisterBloc>().add(
                  UsernameChangedEvent(value),
                ),
          )
        ],
      ),
    );
  }
}
