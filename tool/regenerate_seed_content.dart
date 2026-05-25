// Regenerates assets/content/seed_content.json with 6 categories, 30 words each,
// and category-specific questions that never contain the secret word in any
// language. Each category has its own bank of 9 thematic questions so the
// secret player can answer in a way that hints at the category-specific topic
// (e.g. movies ask about era and genre, food asks about meals and pairings).
// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

const _languages = ['pt-BR', 'en', 'es', 'hi', 'ar'];
const _categoryIds = ['food', 'movies', 'sports', 'music', 'travel', 'animals'];
const _questionsPerWord = 9;

const _categoryNames = <String, Map<String, String>>{
  'food': {
    'pt-BR': 'Comida',
    'en': 'Food',
    'es': 'Comida',
    'hi': 'भोजन',
    'ar': 'طعام',
  },
  'movies': {
    'pt-BR': 'Filmes',
    'en': 'Movies',
    'es': 'Peliculas',
    'hi': 'फ़िल्में',
    'ar': 'أفلام',
  },
  'sports': {
    'pt-BR': 'Esportes',
    'en': 'Sports',
    'es': 'Deportes',
    'hi': 'खेल',
    'ar': 'رياضة',
  },
  'music': {
    'pt-BR': 'Musica',
    'en': 'Music',
    'es': 'Musica',
    'hi': 'संगीत',
    'ar': 'موسيقى',
  },
  'travel': {
    'pt-BR': 'Viagem',
    'en': 'Travel',
    'es': 'Viaje',
    'hi': 'यात्रा',
    'ar': 'سفر',
  },
  'animals': {
    'pt-BR': 'Animais',
    'en': 'Animals',
    'es': 'Animales',
    'hi': 'जानवर',
    'ar': 'حيوانات',
  },
};

const _categoryQuestionTemplates = <String, List<Map<String, String>>>{
  'food': [
    {
      'pt-BR': 'Isso e mais salgado ou mais doce?',
      'en': 'Is this more savory or sweet?',
      'es': 'Esto es mas salado o mas dulce?',
      'hi': 'क्या यह अधिक नमकीन है या मीठा?',
      'ar': 'هل هذا اكثر مالحا ام حلوا؟',
    },
    {
      'pt-BR': 'Em qual refeicao do dia voce comeria isso?',
      'en': 'At which meal of the day would you eat this?',
      'es': 'En que comida del dia comerias esto?',
      'hi': 'आप इसे दिन के किस भोजन में खाएंगे?',
      'ar': 'في اي وجبة من اليوم تاكل هذا؟',
    },
    {
      'pt-BR': 'De que pais ou regiao isso e tipico?',
      'en': 'Which country or region is this typically from?',
      'es': 'De que pais o region es tipico esto?',
      'hi': 'यह आमतौर पर किस देश या क्षेत्र का है?',
      'ar': 'من اي بلد او منطقة عادة ياتي هذا؟',
    },
    {
      'pt-BR': 'Voce come isso quente ou gelado?',
      'en': 'Do you eat this hot or chilled?',
      'es': 'Comes esto caliente o frio?',
      'hi': 'क्या आप इसे गरम खाते हैं या ठंडा?',
      'ar': 'هل تاكله ساخنا ام باردا؟',
    },
    {
      'pt-BR': 'Voce come isso com talheres ou com as maos?',
      'en': 'Do you eat this with utensils or with your hands?',
      'es': 'Comes esto con cubiertos o con las manos?',
      'hi': 'क्या आप इसे चम्मच-कांटे से खाते हैं या हाथ से?',
      'ar': 'هل تاكل هذا بادوات المائدة ام باليدين؟',
    },
    {
      'pt-BR': 'Isso e considerado saudavel ou uma indulgencia?',
      'en': 'Is this considered healthy or an indulgence?',
      'es': 'Esto se considera saludable o una indulgencia?',
      'hi': 'क्या इसे स्वस्थ माना जाता है या एक भोग?',
      'ar': 'هل يعتبر هذا صحيا ام متعة مفرطة؟',
    },
    {
      'pt-BR': 'Voce encontra isso mais em restaurante ou em casa?',
      'en': 'Do you find this more often at a restaurant or at home?',
      'es': 'Encuentras esto mas en un restaurante o en casa?',
      'hi': 'क्या यह आपको रेस्तरां में अधिक मिलता है या घर पर?',
      'ar': 'هل تجد هذا في المطاعم اكثر ام في المنزل؟',
    },
    {
      'pt-BR': 'Qual bebida combinaria bem com isso?',
      'en': 'Which drink would pair well with this?',
      'es': 'Que bebida combinaria bien con esto?',
      'hi': 'इसके साथ कौन सा पेय अच्छा लगेगा?',
      'ar': 'اي مشروب يناسب هذا؟',
    },
    {
      'pt-BR': 'Voce lembra de algum lugar marcante onde provou isso?',
      'en': 'Do you remember a memorable place where you tried this?',
      'es': 'Recuerdas algun lugar especial donde lo probaste?',
      'hi': 'क्या आपको कोई यादगार जगह याद है जहां आपने इसे चखा था?',
      'ar': 'هل تتذكر مكانا مميزا جربت فيه هذا؟',
    },
  ],
  'movies': [
    {
      'pt-BR': 'Esse filme e classico ou recente?',
      'en': 'Is this movie a classic or a recent release?',
      'es': 'Esta pelicula es clasica o reciente?',
      'hi': 'क्या यह फ़िल्म पुरानी क्लासिक है या नई रिलीज़?',
      'ar': 'هل هذا الفيلم كلاسيكي ام حديث؟',
    },
    {
      'pt-BR': 'Qual o genero principal desse filme?',
      'en': 'What is the main genre of this movie?',
      'es': 'Cual es el genero principal de esta pelicula?',
      'hi': 'इस फ़िल्म की मुख्य शैली क्या है?',
      'ar': 'ما النوع الرئيسي لهذا الفيلم؟',
    },
    {
      'pt-BR': 'Em que epoca ou periodo a historia se passa?',
      'en': 'In what era or time period does the story take place?',
      'es': 'En que epoca o periodo transcurre la historia?',
      'hi': 'कहानी किस युग या काल में घटित होती है?',
      'ar': 'في اي حقبة او زمن تدور احداث القصة؟',
    },
    {
      'pt-BR': 'E animacao ou live action?',
      'en': 'Is it animated or live action?',
      'es': 'Es animacion o accion real?',
      'hi': 'क्या यह एनिमेशन है या लाइव एक्शन?',
      'ar': 'هل هو رسوم متحركة ام تمثيل حي؟',
    },
    {
      'pt-BR': 'Voce assistiria com criancas ou e mais para adultos?',
      'en': 'Would you watch it with kids, or is it mostly for adults?',
      'es': 'Lo verias con ninos o es mas para adultos?',
      'hi': 'क्या आप इसे बच्चों के साथ देखेंगे या यह मुख्य रूप से वयस्कों के लिए है?',
      'ar': 'هل ستشاهده مع الاطفال ام انه للبالغين بشكل اساسي؟',
    },
    {
      'pt-BR': 'Faz parte de uma franquia ou tem sequencias?',
      'en': 'Is it part of a franchise or does it have sequels?',
      'es': 'Es parte de una franquicia o tiene secuelas?',
      'hi': 'क्या यह किसी फ्रैंचाइज़ी का हिस्सा है या इसकी सीक्वल हैं?',
      'ar': 'هل هو جزء من سلسلة ام له اجزاء تالية؟',
    },
    {
      'pt-BR': 'Ganhou premios importantes como Oscar?',
      'en': 'Did it win major awards like the Oscars?',
      'es': 'Gano premios importantes como el Oscar?',
      'hi': 'क्या इसने ऑस्कर जैसे बड़े पुरस्कार जीते हैं?',
      'ar': 'هل فاز بجوائز كبرى مثل الاوسكار؟',
    },
    {
      'pt-BR': 'E baseado em livro ou historia real?',
      'en': 'Is it based on a book or a true story?',
      'es': 'Esta basada en un libro o en una historia real?',
      'hi': 'क्या यह किसी किताब या सच्ची कहानी पर आधारित है?',
      'ar': 'هل هو مستند الى كتاب او قصة حقيقية؟',
    },
    {
      'pt-BR': 'O cenario e cidade, campo ou um mundo fantastico?',
      'en': 'Is the setting a city, the countryside, or a fantasy world?',
      'es': 'El escenario es una ciudad, el campo o un mundo fantastico?',
      'hi': 'क्या इसका परिवेश शहर है, ग्रामीण इलाका है, या कोई काल्पनिक दुनिया?',
      'ar': 'هل تدور الاحداث في مدينة ام ريف ام عالم خيالي؟',
    },
  ],
  'sports': [
    {
      'pt-BR': 'E um esporte individual ou de equipe?',
      'en': 'Is it an individual or team sport?',
      'es': 'Es un deporte individual o de equipo?',
      'hi': 'क्या यह व्यक्तिगत खेल है या टीम का खेल?',
      'ar': 'هل هي رياضة فردية ام جماعية؟',
    },
    {
      'pt-BR': 'E praticado em local fechado ou ao ar livre?',
      'en': 'Is it played indoors or outdoors?',
      'es': 'Se practica en interiores o al aire libre?',
      'hi': 'क्या यह घर के अंदर खेला जाता है या बाहर?',
      'ar': 'هل تمارس في الداخل ام في الخارج؟',
    },
    {
      'pt-BR': 'Usa-se uma bola para praticar?',
      'en': 'Is a ball used to play it?',
      'es': 'Se utiliza una pelota para jugarlo?',
      'hi': 'क्या इसे खेलने के लिए गेंद का उपयोग होता है?',
      'ar': 'هل تستخدم كرة عند ممارستها؟',
    },
    {
      'pt-BR': 'Faz parte das Olimpiadas?',
      'en': 'Is it part of the Olympics?',
      'es': 'Forma parte de los Juegos Olimpicos?',
      'hi': 'क्या यह ओलंपिक का हिस्सा है?',
      'ar': 'هل هي جزء من الالعاب الاولمبية؟',
    },
    {
      'pt-BR': 'Exige equipamentos especiais e caros?',
      'en': 'Does it require special expensive equipment?',
      'es': 'Requiere equipo especial y costoso?',
      'hi': 'क्या इसके लिए विशेष महंगे उपकरण चाहिए?',
      'ar': 'هل تتطلب معدات خاصة ومكلفة؟',
    },
    {
      'pt-BR': 'E popular no seu pais?',
      'en': 'Is it popular in your country?',
      'es': 'Es popular en tu pais?',
      'hi': 'क्या यह आपके देश में लोकप्रिय है?',
      'ar': 'هل هي شائعة في بلدك؟',
    },
    {
      'pt-BR': 'Exige mais forca, resistencia ou agilidade?',
      'en': 'Does it demand more strength, endurance, or agility?',
      'es': 'Requiere mas fuerza, resistencia o agilidad?',
      'hi': 'क्या इसमें अधिक ताकत, सहनशक्ति या फुर्ती की आवश्यकता है?',
      'ar': 'هل تتطلب قوة اكثر ام تحملا اكثر ام رشاقة اكثر؟',
    },
    {
      'pt-BR': 'Voce costuma assistir esse esporte na TV?',
      'en': 'Do you often watch this sport on TV?',
      'es': 'Sueles ver este deporte por television?',
      'hi': 'क्या आप अक्सर इस खेल को टीवी पर देखते हैं?',
      'ar': 'هل تشاهد هذه الرياضة على التلفاز كثيرا؟',
    },
    {
      'pt-BR': 'E praticado mais no verao, no inverno ou o ano todo?',
      'en': 'Is it played mostly in summer, winter, or year-round?',
      'es': 'Se practica mas en verano, invierno o todo el ano?',
      'hi': 'क्या यह ज्यादातर गर्मियों में, सर्दियों में या पूरे साल खेला जाता है?',
      'ar': 'هل تمارس في الصيف ام الشتاء ام طوال السنة؟',
    },
  ],
  'music': [
    {
      'pt-BR': 'E algo mais antigo ou bem moderno?',
      'en': 'Is it something older or quite modern?',
      'es': 'Es algo mas antiguo o bastante moderno?',
      'hi': 'क्या यह कुछ पुराना है या काफी आधुनिक?',
      'ar': 'هل هو قديم نسبيا ام حديث جدا؟',
    },
    {
      'pt-BR': 'Tem letra cantada ou e instrumental?',
      'en': 'Does it have sung lyrics or is it instrumental?',
      'es': 'Tiene letra cantada o es instrumental?',
      'hi': 'क्या इसमें गाये गए बोल हैं या यह सिर्फ वाद्य है?',
      'ar': 'هل لها كلمات مغناة ام انها موسيقية فقط؟',
    },
    {
      'pt-BR': 'Combina mais com festa ou com momento tranquilo?',
      'en': 'Does it fit better at a party or in a quiet moment?',
      'es': 'Combina mas con una fiesta o con un momento tranquilo?',
      'hi': 'क्या यह पार्टी में बेहतर लगता है या शांत पल में?',
      'ar': 'هل تناسب الحفلات اكثر ام لحظات الهدوء؟',
    },
    {
      'pt-BR': 'E ligado a uma regiao ou tradicao especifica?',
      'en': 'Is it tied to a specific region or tradition?',
      'es': 'Esta ligado a una region o tradicion especifica?',
      'hi': 'क्या यह किसी विशेष क्षेत्र या परंपरा से जुड़ा है?',
      'ar': 'هل يرتبط بمنطقة او تقليد معين؟',
    },
    {
      'pt-BR': 'Usa mais instrumentos eletronicos ou acusticos?',
      'en': 'Does it use more electronic or acoustic instruments?',
      'es': 'Usa mas instrumentos electronicos o acusticos?',
      'hi': 'क्या इसमें अधिक इलेक्ट्रॉनिक वाद्य प्रयोग होते हैं या ध्वनिक?',
      'ar': 'هل تستخدم الات الكترونية اكثر ام صوتية؟',
    },
    {
      'pt-BR': 'Voce dancaria ouvindo isso?',
      'en': 'Would you dance to it?',
      'es': 'Bailarias escuchando esto?',
      'hi': 'क्या आप इसे सुनकर नाचेंगे?',
      'ar': 'هل سترقص عند سماعه؟',
    },
    {
      'pt-BR': 'Costuma tocar em radio popular?',
      'en': 'Is it commonly played on mainstream radio?',
      'es': 'Suena habitualmente en la radio popular?',
      'hi': 'क्या यह आम तौर पर लोकप्रिय रेडियो पर बजता है?',
      'ar': 'هل يذاع عادة على الاذاعات الشائعة؟',
    },
    {
      'pt-BR': 'Lembra alguma decada especifica?',
      'en': 'Does it remind you of a specific decade?',
      'es': 'Te recuerda a alguna decada especifica?',
      'hi': 'क्या यह किसी विशेष दशक की याद दिलाता है?',
      'ar': 'هل يذكرك بعقد زمني معين؟',
    },
    {
      'pt-BR': 'E mais comum ouvir solo ou em grupo?',
      'en': 'Is it more typically performed solo or by a group?',
      'es': 'Se interpreta mas como solista o en grupo?',
      'hi': 'क्या यह अधिकतर अकेले प्रस्तुत होता है या समूह में?',
      'ar': 'هل يقدم عادة بشكل فردي ام جماعي؟',
    },
  ],
  'travel': [
    {
      'pt-BR': 'E um destino mais urbano ou de natureza?',
      'en': 'Is it more of an urban or a nature destination?',
      'es': 'Es un destino mas urbano o de naturaleza?',
      'hi': 'क्या यह शहरी गंतव्य है या प्राकृतिक?',
      'ar': 'هل هي وجهة حضرية اكثر ام طبيعية؟',
    },
    {
      'pt-BR': 'E mais conhecido pelo litoral ou pelas serras?',
      'en': 'Is it better known for its coastline or its highlands?',
      'es': 'Es mas conocido por su costa o sus tierras altas?',
      'hi': 'क्या यह तटीय इलाकों के लिए अधिक प्रसिद्ध है या ऊँचे इलाकों के लिए?',
      'ar': 'هل تشتهر اكثر بسواحلها ام بمرتفعاتها؟',
    },
    {
      'pt-BR': 'Fica perto ou longe do seu pais?',
      'en': 'Is it close to or far from your country?',
      'es': 'Esta cerca o lejos de tu pais?',
      'hi': 'क्या यह आपके देश के पास है या दूर?',
      'ar': 'هل هي قريبة من بلدك ام بعيدة عنه؟',
    },
    {
      'pt-BR': 'O clima costuma ser quente ou frio?',
      'en': 'Is the climate usually hot or cold?',
      'es': 'El clima suele ser caluroso o frio?',
      'hi': 'क्या वहाँ की जलवायु आमतौर पर गर्म है या ठंडी?',
      'ar': 'هل المناخ عادة حار ام بارد؟',
    },
    {
      'pt-BR': 'E caro para visitar?',
      'en': 'Is it expensive to visit?',
      'es': 'Es caro visitarlo?',
      'hi': 'क्या वहां जाना महंगा है?',
      'ar': 'هل زيارته مكلفة؟',
    },
    {
      'pt-BR': 'Tem monumentos historicos famosos?',
      'en': 'Does it have famous historical landmarks?',
      'es': 'Tiene monumentos historicos famosos?',
      'hi': 'क्या वहां प्रसिद्ध ऐतिहासिक स्थल हैं?',
      'ar': 'هل بها معالم تاريخية شهيرة؟',
    },
    {
      'pt-BR': 'E muito turistico ou pouco visitado?',
      'en': 'Is it very touristy or off the beaten path?',
      'es': 'Es muy turistico o poco visitado?',
      'hi': 'क्या यह बहुत पर्यटक भरा है या कम लोगों द्वारा घूमा गया है?',
      'ar': 'هل هي مزدحمة بالسياح ام بعيدة عن المسارات المعتادة؟',
    },
    {
      'pt-BR': 'E ideal para familia ou para jovens em busca de aventura?',
      'en': 'Is it ideal for families or for young travelers looking for adventure?',
      'es': 'Es ideal para familias o para jovenes en busca de aventura?',
      'hi': 'क्या यह परिवारों के लिए आदर्श है या रोमांच की तलाश में युवा यात्रियों के लिए?',
      'ar': 'هل هي مثالية للعائلات ام للمسافرين الشباب الباحثين عن المغامرة؟',
    },
    {
      'pt-BR': 'A culinaria local e famosa?',
      'en': 'Is the local cuisine famous?',
      'es': 'La cocina local es famosa?',
      'hi': 'क्या वहाँ का स्थानीय भोजन प्रसिद्ध है?',
      'ar': 'هل المطبخ المحلي مشهور؟',
    },
  ],
  'animals': [
    {
      'pt-BR': 'Vive em terra firme, na agua ou voa?',
      'en': 'Does it live on land, in water, or does it fly?',
      'es': 'Vive en tierra firme, en el agua o vuela?',
      'hi': 'क्या यह ज़मीन पर रहता है, पानी में या उड़ता है?',
      'ar': 'هل يعيش على اليابسة ام في الماء ام يطير؟',
    },
    {
      'pt-BR': 'E um animal domestico ou selvagem?',
      'en': 'Is it a domestic or wild animal?',
      'es': 'Es un animal domestico o salvaje?',
      'hi': 'क्या यह पालतू जानवर है या जंगली?',
      'ar': 'هل هو حيوان اليف ام بري؟',
    },
    {
      'pt-BR': 'E grande ou pequeno comparado a uma pessoa?',
      'en': 'Is it big or small compared to a person?',
      'es': 'Es grande o pequeno comparado con una persona?',
      'hi': 'क्या यह इंसान की तुलना में बड़ा है या छोटा?',
      'ar': 'هل هو كبير ام صغير مقارنة بالانسان؟',
    },
    {
      'pt-BR': 'E carnivoro, herbivoro ou onivoro?',
      'en': 'Is it carnivorous, herbivorous, or omnivorous?',
      'es': 'Es carnivoro, herbivoro u omnivoro?',
      'hi': 'क्या यह मांसाहारी है, शाकाहारी है या सर्वाहारी?',
      'ar': 'هل هو لاحم ام عاشب ام قارت؟',
    },
    {
      'pt-BR': 'Pode ser perigoso para humanos?',
      'en': 'Can it be dangerous to humans?',
      'es': 'Puede ser peligroso para los humanos?',
      'hi': 'क्या यह मनुष्यों के लिए ख़तरनाक हो सकता है?',
      'ar': 'هل يمكن ان يكون خطيرا على البشر؟',
    },
    {
      'pt-BR': 'Voce conseguiria ter um como animal de estimacao?',
      'en': 'Could you keep one as a pet?',
      'es': 'Podrias tener uno como mascota?',
      'hi': 'क्या आप इसे पालतू के रूप में रख सकते हैं?',
      'ar': 'هل يمكنك تربيته كحيوان اليف؟',
    },
    {
      'pt-BR': 'E comum encontrar no seu pais?',
      'en': 'Is it commonly found in your country?',
      'es': 'Es comun encontrarlo en tu pais?',
      'hi': 'क्या यह आपके देश में आसानी से मिलता है?',
      'ar': 'هل من الشائع وجوده في بلدك؟',
    },
    {
      'pt-BR': 'E mamifero, reptil, ave, peixe ou inseto?',
      'en': 'Is it a mammal, reptile, bird, fish, or insect?',
      'es': 'Es mamifero, reptil, ave, pez o insecto?',
      'hi': 'क्या यह स्तनधारी है, सरीसृप, पक्षी, मछली या कीट?',
      'ar': 'هل هو من الثدييات ام الزواحف ام الطيور ام الاسماك ام الحشرات؟',
    },
    {
      'pt-BR': 'Aparece muito em filmes ou desenhos animados?',
      'en': 'Does it appear often in movies or cartoons?',
      'es': 'Aparece a menudo en peliculas o dibujos animados?',
      'hi': 'क्या यह अक्सर फ़िल्मों या कार्टून में दिखाई देता है?',
      'ar': 'هل يظهر كثيرا في الافلام او الرسوم المتحركة؟',
    },
  ],
};

void main() {
  final localizationsFile = File('tool/data/word_localizations.json');
  final localizations =
      (jsonDecode(localizationsFile.readAsStringSync()) as Map<String, dynamic>)
          .map(
            (key, value) => MapEntry(
              key,
              (value as Map<String, dynamic>).cast<String, String>(),
            ),
          );

  final sourceFile = File('assets/content/seed_content.json');
  final source = jsonDecode(sourceFile.readAsStringSync()) as Map<String, dynamic>;
  final sourceCategories =
      (source['categories'] as List<dynamic>).cast<Map<String, dynamic>>();
  final byId = {for (final c in sourceCategories) c['id'] as String: c};

  final categories = <Map<String, dynamic>>[];
  for (final categoryId in _categoryIds) {
    final category = byId[categoryId];
    if (category == null) {
      throw StateError('Missing category $categoryId in source seed.');
    }
    final words = (category['words'] as List<dynamic>)
        .cast<Map<String, dynamic>>();
    if (words.length < 30) {
      throw StateError('Category $categoryId has fewer than 30 words.');
    }

    final templates = _categoryQuestionTemplates[categoryId];
    if (templates == null || templates.length != _questionsPerWord) {
      throw StateError(
        'Category $categoryId requires $_questionsPerWord question templates.',
      );
    }

    final rebuiltWords = <Map<String, dynamic>>[];
    for (final word in words.take(30)) {
      final wordId = word['id'] as String;
      final localized = localizations[wordId];
      if (localized == null) {
        throw StateError('Missing localization for word "$wordId".');
      }
      final value = localized;
      final questions = <Map<String, dynamic>>[];

      for (var index = 0; index < _questionsPerWord; index += 1) {
        final template = templates[index];
        final text = <String, String>{};
        for (final language in _languages) {
          final localizedTemplate = template[language];
          if (localizedTemplate == null) {
            throw StateError(
              'Missing $language template for question ${index + 1} in $categoryId.',
            );
          }
          text[language] = localizedTemplate;
        }
        _assertNoWordLeak(wordId: wordId, value: value, text: text);
        questions.add({
          'id': '$wordId-q${index + 1}',
          'text': text,
        });
      }

      rebuiltWords.add({
        'id': wordId,
        'value': value,
        'questions': questions,
      });
    }

    final categoryName = _categoryNames[categoryId];
    if (categoryName == null) {
      throw StateError('Missing category name localization for $categoryId.');
    }

    categories.add({
      'id': categoryId,
      'iconKey': category['iconKey'],
      'name': categoryName,
      'words': rebuiltWords,
      'primary': category['primary'],
      'secondary': category['secondary'],
    });
  }

  final seed = <String, dynamic>{
    'schemaVersion': source['schemaVersion'],
    'languages': _languages,
    'minQuestionsPerWord': source['minQuestionsPerWord'],
    'maxQuestionsPerWord': source['maxQuestionsPerWord'],
    'categories': categories,
  };

  _validateSeed(seed);

  final encoder = JsonEncoder.withIndent('  ');
  sourceFile.writeAsStringSync('${encoder.convert(seed)}\n');

  final wordCount = categories.length * 30;
  print(
    'Wrote ${categories.length} categories, $wordCount words, '
    '$_questionsPerWord category-specific questions each (no word leaks).',
  );
}

void _assertNoWordLeak({
  required String wordId,
  required Map<String, String> value,
  required Map<String, String> text,
}) {
  for (final entry in text.entries) {
    for (final word in value.values) {
      if (_containsWord(entry.value, word)) {
        throw StateError(
          'Question leaks word "$word" for $wordId (${entry.key}): ${entry.value}',
        );
      }
    }
  }
}

bool _containsWord(String question, String word) {
  final normalizedQuestion = _normalize(question);
  final normalizedWord = _normalize(word);
  if (normalizedWord.isEmpty) {
    return false;
  }
  if (normalizedWord.contains(' ')) {
    return normalizedQuestion.contains(normalizedWord);
  }
  final pattern = RegExp(
    r'(^|[^a-z0-9\u0600-\u06FF\u0900-\u097F])'
    '${RegExp.escape(normalizedWord)}'
    r'([^a-z0-9\u0600-\u06FF\u0900-\u097F]|$)',
  );
  return pattern.hasMatch(normalizedQuestion);
}

String _normalize(String input) => input
    .toLowerCase()
    .replaceAll(RegExp(r'[^a-z0-9\u0600-\u06FF\u0900-\u097F\s]'), '');

void _validateSeed(Map<String, dynamic> seed) {
  final categories = seed['categories'] as List<dynamic>;
  if (categories.length != 6) {
    throw StateError('Expected 6 categories, got ${categories.length}.');
  }
  for (final category in categories.cast<Map<String, dynamic>>()) {
    final words = category['words'] as List<dynamic>;
    if (words.length != 30) {
      throw StateError(
        'Category ${category['id']} must have 30 words, got ${words.length}.',
      );
    }
  }
}
