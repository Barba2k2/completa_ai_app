import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_text_styles.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Termos de Uso'),
      ),
      body: ListView(
        padding: EdgeInsets.all(24.w),
        children: [
          Text(
            '1. Termos',
            style: AppTextStyles.h4,
          ),
          SizedBox(height: 12.h),
          Text(
            'Ao acessar ao aplicativo Completa Aí, concorda em cumprir estes termos de serviço, todas as leis e regulamentos aplicáveis e concorda que é responsável pelo cumprimento de todas as leis locais aplicáveis. Se você não concordar com algum desses termos, está proibido de usar ou acessar este aplicativo. Os materiais contidos neste aplicativo são protegidos pelas leis de direitos autorais e marcas comerciais aplicáveis.',
            style: AppTextStyles.bodyMedium,
          ),
          SizedBox(height: 24.h),
          Text(
            '2. Uso de Licença',
            style: AppTextStyles.h4,
          ),
          SizedBox(height: 12.h),
          Text(
            'É concedida permissão para baixar temporariamente uma cópia dos materiais (informações ou software) no aplicativo Completa Aí, apenas para visualização transitória pessoal e não comercial. Esta é a concessão de uma licença, não uma transferência de título e, sob esta licença, você não pode: modificar ou copiar os materiais; usar os materiais para qualquer finalidade comercial ou para exibição pública (comercial ou não comercial); tentar descompilar ou fazer engenharia reversa de qualquer software contido no aplicativo; remover quaisquer direitos autorais ou outras notações de propriedade dos materiais; ou transferir os materiais para outra pessoa ou \'espelhar\' os materiais em qualquer outro servidor.',
            style: AppTextStyles.bodyMedium,
          ),
          SizedBox(height: 12.h),
          Text(
            'Esta licença será automaticamente rescindida se você violar alguma dessas restrições e poderá ser rescindida pelo Completa Aí a qualquer momento. Ao encerrar a visualização desses materiais ou após o término desta licença, você deve apagar todos os materiais baixados em sua posse, seja em formato eletrônico ou impresso.',
            style: AppTextStyles.bodyMedium,
          ),
          SizedBox(height: 24.h),
          Text(
            '3. Isenção de responsabilidade',
            style: AppTextStyles.h4,
          ),
          SizedBox(height: 12.h),
          Text(
            'Os materiais no aplicativo Completa Aí são fornecidos \'como estão\'. Completa Aí não oferece garantias, expressas ou implícitas, e, por este meio, isenta e nega todas as outras garantias, incluindo, sem limitação, garantias implícitas ou condições de comercialização, adequação a um fim específico ou não violação de propriedade intelectual ou outra violação de direitos.',
            style: AppTextStyles.bodyMedium,
          ),
          SizedBox(height: 12.h),
          Text(
            'Além disso, o Completa Aí não garante ou faz qualquer representação relativa à precisão, aos resultados prováveis ou à confiabilidade do uso dos materiais em seu aplicativo ou de outra forma relacionado a esses materiais ou em sites vinculados a este aplicativo.',
            style: AppTextStyles.bodyMedium,
          ),
          SizedBox(height: 24.h),
          Text(
            '4. Limitações',
            style: AppTextStyles.h4,
          ),
          SizedBox(height: 12.h),
          Text(
            'Em nenhum caso o Completa Aí ou seus fornecedores serão responsáveis por quaisquer danos (incluindo, sem limitação, danos por perda de dados ou lucro ou devido a interrupção dos negócios) decorrentes do uso ou da incapacidade de usar os materiais em Completa Aí, mesmo que Completa Aí ou um representante autorizado tenha sido notificado oralmente ou por escrito da possibilidade de tais danos. Como algumas jurisdições não permitem limitações em garantias implícitas, ou limitações de responsabilidade por danos consequentes ou incidentais, essas limitações podem não se aplicar a você.',
            style: AppTextStyles.bodyMedium,
          ),
          SizedBox(height: 24.h),
          Text(
            '5. Precisão dos materiais',
            style: AppTextStyles.h4,
          ),
          SizedBox(height: 12.h),
          Text(
            'Os materiais exibidos no aplicativo Completa Aí podem incluir erros técnicos, tipográficos ou fotográficos. Completa Aí não garante que qualquer material em seu aplicativo seja preciso, completo ou atual. Completa Aí pode fazer alterações nos materiais contidos em seu aplicativo a qualquer momento, sem aviso prévio. No entanto, Completa Aí não se compromete a atualizar os materiais.',
            style: AppTextStyles.bodyMedium,
          ),
          SizedBox(height: 24.h),
          Text(
            '6. Links',
            style: AppTextStyles.h4,
          ),
          SizedBox(height: 12.h),
          Text(
            'O Completa Aí não analisou todos os sites vinculados ao seu aplicativo e não é responsável pelo conteúdo de nenhum site vinculado. A inclusão de qualquer link não implica endosso por Completa Aí do site. O uso de qualquer site vinculado é por conta e risco do usuário.',
            style: AppTextStyles.bodyMedium,
          ),
          SizedBox(height: 24.h),
          Text(
            '7. Modificações',
            style: AppTextStyles.h4,
          ),
          SizedBox(height: 12.h),
          Text(
            'O Completa Aí pode revisar estes termos de serviço do aplicativo a qualquer momento, sem aviso prévio. Ao usar este aplicativo, você concorda em ficar vinculado à versão atual desses termos de serviço.',
            style: AppTextStyles.bodyMedium,
          ),
          SizedBox(height: 24.h),
          Text(
            '8. Lei aplicável',
            style: AppTextStyles.h4,
          ),
          SizedBox(height: 12.h),
          Text(
            'Estes termos e condições são regidos e interpretados de acordo com as leis do Brasil e você se submete irrevogavelmente à jurisdição exclusiva dos tribunais naquele estado ou localidade.',
            style: AppTextStyles.bodyMedium,
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
