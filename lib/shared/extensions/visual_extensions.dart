import 'package:flutter/material.dart';

import '../../core/theme/tom_visual.dart';
import '../../data/models/models.dart';

/// Liga os modelos às cores e ícones do Design System,
/// mantendo os modelos livres de dependências de interface.
extension TipoCriatorioVisual on TipoCriatorio {
  TomVisual get tom => this == TipoCriatorio.apiario ? TomVisual.amarelo : TomVisual.verde;

  IconData get icone =>
      this == TipoCriatorio.apiario ? Icons.hexagon_outlined : Icons.spa_outlined;
}

extension StatusColoniaVisual on StatusColonia {
  TomVisual get tom => switch (this) {
        StatusColonia.ativa => TomVisual.verde,
        StatusColonia.atencao => TomVisual.amarelo,
        StatusColonia.problema => TomVisual.vermelho,
        StatusColonia.inativa => TomVisual.cinza,
      };
}

extension PrioridadeVisual on Prioridade {
  TomVisual get tom => switch (this) {
        Prioridade.alta => TomVisual.vermelho,
        Prioridade.media => TomVisual.amarelo,
        Prioridade.baixa => TomVisual.verde,
      };
}

extension AtividadeVisual on Atividade {
  TomVisual get tom => tipo == TipoAtividade.revisao ? TomVisual.verde : TomVisual.amarelo;
}
