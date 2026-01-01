import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_text_styles.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Política de Privacidade'),
      ),
      body: ListView(
        padding: EdgeInsets.all(24.w),
        children: [
          Text(
            'Política de Privacidade',
            style: AppTextStyles.h3,
          ),
          SizedBox(height: 16.h),
          Text(
            'A sua privacidade é importante para nós. É política do Completa Aí respeitar a sua privacidade em relação a qualquer informação sua que possamos coletar no aplicativo, e outros sites que possuímos e operamos.',
            style: AppTextStyles.bodyMedium,
          ),
          SizedBox(height: 16.h),
          Text(
            'Solicitamos informações pessoais apenas quando realmente precisamos delas para lhe fornecer um serviço. Fazemo-lo por meios justos e legais, com o seu conhecimento e consentimento. Também informamos por que estamos coletando e como será usado.',
            style: AppTextStyles.bodyMedium,
          ),
          SizedBox(height: 16.h),
          Text(
            'Apenas retemos as informações coletadas pelo tempo necessário para fornecer o serviço solicitado. Quando armazenamos dados, protegemos dentro de meios comercialmente aceitáveis para evitar perdas e roubos, bem como acesso, divulgação, cópia, uso ou modificação não autorizados.',
            style: AppTextStyles.bodyMedium,
          ),
          SizedBox(height: 16.h),
          Text(
            'Não compartilhamos informações de identificação pessoal publicamente ou com terceiros, exceto quando exigido por lei.',
            style: AppTextStyles.bodyMedium,
          ),
          SizedBox(height: 16.h),
          Text(
            'O nosso aplicativo pode ter links para sites externos que não são operados por nós. Esteja ciente de que não temos controle sobre o conteúdo e práticas desses sites e não podemos aceitar responsabilidade por suas respectivas políticas de privacidade.',
            style: AppTextStyles.bodyMedium,
          ),
          SizedBox(height: 16.h),
          Text(
            'Você é livre para recusar a nossa solicitação de informações pessoais, entendendo que talvez não possamos fornecer alguns dos serviços desejados.',
            style: AppTextStyles.bodyMedium,
          ),
          SizedBox(height: 16.h),
          Text(
            'O uso continuado de nosso aplicativo será considerado como aceitação de nossas práticas em torno de privacidade e informações pessoais. Se você tiver alguma dúvida sobre como lidamos com dados do usuário e informações pessoais, entre em contato conosco.',
            style: AppTextStyles.bodyMedium,
          ),
          SizedBox(height: 24.h),
          Text(
            'Compromisso do Usuário',
            style: AppTextStyles.h4,
          ),
          SizedBox(height: 12.h),
          Text(
            'O usuário se compromete a fazer uso adequado dos conteúdos e da informação que o Completa Aí oferece no aplicativo e com caráter enunciativo, mas não limitativo:',
            style: AppTextStyles.bodyMedium,
          ),
          SizedBox(height: 12.h),
          Text(
            'A) Não se envolver em atividades que sejam ilegais ou contrárias à boa fé e à ordem pública;',
            style: AppTextStyles.bodyMedium,
          ),
          SizedBox(height: 8.h),
          Text(
            'B) Não difundir propaganda ou conteúdo de natureza racista, xenofóbica, jogos de sorte ou azar, qualquer tipo de pornografia ilegal, de apologia ao terrorismo ou contra os direitos humanos;',
            style: AppTextStyles.bodyMedium,
          ),
          SizedBox(height: 8.h),
          Text(
            'C) Não causar danos aos sistemas físicos (hardwares) e lógicos (softwares) do Completa Aí, de seus fornecedores ou terceiros, para introduzir ou disseminar vírus informáticos ou quaisquer outros sistemas de hardware ou software que sejam capazes de causar danos anteriormente mencionados.',
            style: AppTextStyles.bodyMedium,
          ),
          SizedBox(height: 24.h),
          Text(
            'Mais informações',
            style: AppTextStyles.h4,
          ),
          SizedBox(height: 12.h),
          Text(
            'Esperamos que esteja esclarecido e, como mencionado anteriormente, se houver algo que você não tem certeza se precisa ou não, geralmente é mais seguro deixar os cookies ativados, caso interaja com um dos recursos que você usa em nosso aplicativo.',
            style: AppTextStyles.bodyMedium,
          ),
          SizedBox(height: 16.h),
          Text(
            'Esta política é efetiva a partir de 1 de Janeiro de 2026.',
            style: AppTextStyles.bodySmall,
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
