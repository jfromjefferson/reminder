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
      'date_hour': 'Date/hour',
      'hour': 'Hour',
      'repeat': 'Repeat',
      'settings_title': 'Settings',
      'profile': 'Profile',
      'profile_sub': 'Subtitle',
      'delete_all': 'Delete all?',
      'yes': 'Yes',
      'no': 'No',
      'move_to_trash_date': 'Moved to trash in: ',
      'category': 'Category'
    },
    'pt_BR': {
      'title': 'Lembretes',
      'new_reminder_title': 'Novo lembrete',
      'reminder_input_title': 'Título',
      'reminder_input_content': 'Conteúdo',
      'create': 'Criar',
      'date_format': 'dd/MM/yyyy',
      'date': 'Data',
      'date_hour': 'Data/hora',
      'hour': 'Hora',
      'repeat': 'Repetir',
      'settings_title': 'Configurações',
      'profile': 'Perfil',
      'profile_sub': 'Legenda',
      'delete_all': 'Deletar tudo?',
      'yes': 'Sim',
      'not': 'Não',
      'move_to_trash_date': 'Movido pra lixeira em: ',
      'category': 'Categoria'
    }
  };

}