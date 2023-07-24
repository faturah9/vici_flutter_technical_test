import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/register_bloc.dart';

class RegisNameInput extends StatefulWidget {
  const RegisNameInput({super.key});

  @override
  State<RegisNameInput> createState() => _RegisNameInputState();
}

class _RegisNameInputState extends State<RegisNameInput> {
  final _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) => Stack(
        alignment: Alignment.centerRight,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              labelText: 'Nama Lengkap',
              hintText: 'Masukan Nama Lengkap',
            ),
            onChanged: (value) => context.read<RegisterBloc>().add(
              NameChangedEvent(value),
            ),
          )
        ],
      ),
    );
  }
}
