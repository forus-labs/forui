// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'dart:io';

final List<(String, String)> locales = [
  ('af', 'Opspringer'),
  ('am', 'ፖፖቨር'),
  ('ar', 'منبثقة'),
  ('as', 'পপঅভাৰ'),
  ('az', 'Popover'),
  ('be', 'Усплывальнае акно'),
  ('bg', 'Изскачащ прозорец'),
  ('bn', 'পপওভার'),
  ('bs', 'Iskačući prozor'),
  ('ca', 'Finestra emergent'),
  ('cs', 'Vyskakovací okno'),
  ('cy', 'Ffenestr naid'),
  ('da', 'Pop op-vindue'),
  ('de', 'Popover'),
  ('de_CH', 'Popover'),
  ('el', 'Αναδυόμενο παράθυρο'),
  ('en', 'Popover'),
  ('en_AU', 'Popover'),
  ('en_CA', 'Popover'),
  ('en_GB', 'Popover'),
  ('en_IE', 'Popover'),
  ('en_IN', 'Popover'),
  ('en_NZ', 'Popover'),
  ('en_SG', 'Popover'),
  ('en_ZA', 'Popover'),
  ('es', 'Ventana emergente'),
  ('es_419', 'Ventana emergente'),
  ('es_AR', 'Ventana emergente'),
  ('es_BO', 'Ventana emergente'),
  ('es_CL', 'Ventana emergente'),
  ('es_CO', 'Ventana emergente'),
  ('es_CR', 'Ventana emergente'),
  ('es_DO', 'Ventana emergente'),
  ('es_EC', 'Ventana emergente'),
  ('es_GT', 'Ventana emergente'),
  ('es_HN', 'Ventana emergente'),
  ('es_MX', 'Ventana emergente'),
  ('es_NI', 'Ventana emergente'),
  ('es_PA', 'Ventana emergente'),
  ('es_PE', 'Ventana emergente'),
  ('es_PR', 'Ventana emergente'),
  ('es_PY', 'Ventana emergente'),
  ('es_SV', 'Ventana emergente'),
  ('es_US', 'Ventana emergente'),
  ('es_UY', 'Ventana emergente'),
  ('es_VE', 'Ventana emergente'),
  ('et', 'Hüpikaken'),
  ('eu', 'Leiho emergentea'),
  ('fa', 'پاپ‌اور'),
  ('fi', 'Ponnahdusikkuna'),
  ('fil', 'Popover'),
  ('fr', 'Fenêtre contextuelle'),
  ('fr_CA', 'Fenêtre contextuelle'),
  ('gl', 'Xanela emerxente'),
  ('gsw', 'Popover'),
  ('gu', 'પોપઓવર'),
  ('he', 'חלון קופץ'),
  ('hi', 'पॉपओवर'),
  ('hr', 'Skočni prozor'),
  ('hu', 'Felugró ablak'),
  ('hy', 'Ելնող պատուհան'),
  ('id', 'Popover'),
  ('is', 'Sprettgluggi'),
  ('it', 'Finestra di sovrapposizione'),
  ('ja', 'ポップオーバー'),
  ('ka', 'ამომხტარი ფანჯარა'),
  ('kk', 'Қалқымалы терезе'),
  ('km', 'បង្អួចលេចឡើង'),
  ('kn', 'ಪಾಪ್‌ಓವರ್'),
  ('ko', '팝오버'),
  ('ky', 'Калкып чыгуучу терезе'),
  ('lo', 'ປ໊ອບໂອເວີ'),
  ('lt', 'Išskleidžiamas langas'),
  ('lv', 'Izlecošs logs'),
  ('mk', 'Скокачки прозорец'),
  ('ml', 'പോപ്പോവർ'),
  ('mn', 'Товших цонх'),
  ('mr', 'पॉपओव्हर'),
  ('ms', 'Popover'),
  ('my', 'ပေါ်လာသောဝင်းဒို'),
  ('nb', 'Hurtigvindu'),
  ('ne', 'पपओभर'),
  ('nl', 'Popover'),
  ('no', 'Hurtigvindu'),
  ('or', 'ପପଓଭର'),
  ('pa', 'ਪੌਪਓਵਰ'),
  ('pl', 'Okno wyskakujące'),
  ('ps', 'پاپ اوور'),
  ('pt', 'Janela sobreposta'),
  ('pt_PT', 'Janela sobreposta'),
  ('ro', 'Fereastră contextuală'),
  ('ru', 'Всплывающее окно'),
  ('si', 'පොප්ඕවර්'),
  ('sk', 'Vyskakovacie okno'),
  ('sl', 'Pojavno okno'),
  ('sq', 'Dritare kërcyese'),
  ('sr', 'Искачући прозор'),
  ('sr_Latn', 'Iskačući prozor'),
  ('sv', 'Popover'),
  ('sw', 'Dirisha la haraka'),
  ('ta', 'பாப்ஓவர்'),
  ('te', 'పాప్‌ఓవర్'),
  ('th', 'ป๊อปโอเวอร์'),
  ('tl', 'Popover'),
  ('tr', 'Açılır pencere'),
  ('uk', 'Спливаюче вікно'),
  ('ur', 'پاپ اوور'),
  ('uz', 'Popover'),
  ('vi', 'Cửa sổ bật lên'),
  ('zh', '弹出框'),
  ('zh_HK', '彈出視窗'),
  ('zh_TW', '彈出視窗'),
  ('zu', 'Iwindi eliqhamukayo'),
];

void main() {
  // Replace with name of key to generate.
  const key = 'popoverSemanticsLabel';

  for (final (locale, value) in locales) {
    final arb = File('lib/l10n/f_$locale.arb');
    if (locale == 'en') {
      continue;
    }

    final data = json.decode(arb.readAsStringSync());
    data[key] = value;

    arb.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(data));
  }
}
