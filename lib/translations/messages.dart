import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'title': 'Reminders',
      'new_reminder_title': 'New reminder',
      'reminder_input_title': 'Title',
      'reminder_input_content': 'Content',
      'create': 'Create',
      'date_format': 'yyyy-MM-dd',
      'date': 'Date',
      'hour': 'Hour',
      'repeat': 'Repeat',
    },
    'pt_BR': {
      'title': 'Lembretes',
      'new_reminder_title': 'Novo lembrete',
      'reminder_input_title': 'Título',
      'reminder_input_content': 'Conteúdo',
      'create': 'Criar',
      'date_format': 'dd/MM/yyyy',
      'date': 'Data',
      'hour': 'Hora',
      'repeat': 'Repetir',
    }
  };

}