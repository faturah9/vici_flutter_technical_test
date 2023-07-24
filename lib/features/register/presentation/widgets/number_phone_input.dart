import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/register_bloc.dart';

class NumberPhoneInput extends StatefulWidget {
  const NumberPhoneInput({super.key});

  @override
  State<NumberPhoneInput> createState() => _NumberPhoneInputState();
}

class _NumberPhoneInputState extends State<NumberPhoneInput> {

  final _numberPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) =>
          previous.numberPhone != current.numberPhone,
      builder: (context, state) => Stack(
        alignment: Alignment.centerRight,
        children: [
          TextField(
            controller: _numberPhoneController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              icon: Icon(Icons.phone),
              labelText: 'Nomor Telepon',
              hintText: 'Masukan Nomor Telepon',
            ),
            onChanged: (value) => context.read<RegisterBloc>().add(
                  NumberPhoneChangedEvent(value),
                ),
          )
        ],
      ),
    );
  }
}
