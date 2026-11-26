import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import 'input_styles.dart';

/// Campo de data que abre o calendário ao ser tocado.
class CampoData extends StatelessWidget {
  const CampoData({
    super.key,
    required this.rotulo,
    required this.valor,
    required this.onChanged,
    this.primeiraData,
    this.ultimaData,
  });

  final String rotulo;
  final DateTime valor;
  final ValueChanged<DateTime> onChanged;
  final DateTime? primeiraData;
  final DateTime? ultimaData;

  Future<void> _selecionar(BuildContext context) async {
    final escolhida = await showDatePicker(
      context: context,
      initialDate: valor,
      firstDate: primeiraData ?? DateTime(2000),
      lastDate: ultimaData ?? DateTime(2100),
      helpText: rotulo,
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
    );
    if (escolhida != null) onChanged(escolhida);
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RotuloCampo(rotulo),
          Semantics(
            button: true,
            label: '$rotulo: ${Formatters.data(valor)}',
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => _selecionar(context),
              child: InputDecorator(
                decoration: InputStyles.compacto(
                  suffixIcon: const Icon(
                    Icons.calendar_today_outlined,
                    size: 18,
                    color: AppColors.textoSecundario,
                  ),
                ),
                child: Text(Formatters.data(valor), style: InputStyles.textoCampo),
              ),
            ),
          ),
        ],
      );
}
