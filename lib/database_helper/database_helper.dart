import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'database_creator.dart';
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _db;

  DatabaseHelper._instance();

  Future<Database?> get db async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db;
  }
  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'my_database.db');

    await deleteDatabase(path);

    final myDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
    return myDatabase;
  }
  void _createDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $blocksTable($blocksId INTEGER PRIMARY KEY AUTOINCREMENT, $blocksTitle TEXT, $blocksDescription TEXT, $blocksPhotoPath TEXT)',
    );
    await db.execute(
      'CREATE TABLE $windowsTable($windowsId INTEGER PRIMARY KEY AUTOINCREMENT, $windowsTitle TEXT, $windowsDescription TEXT, $windowsPhotoPath TEXT)',
    );
    await db.execute(
      'CREATE TABLE $treeTable($treeId INTEGER PRIMARY KEY AUTOINCREMENT, $treeTitle TEXT, $treeDescription TEXT, $treePhotoPath TEXT)',
    );
    await db.execute(
      'CREATE TABLE $metalTable($metalId INTEGER PRIMARY KEY AUTOINCREMENT, $metalTitle TEXT, $metalDescription TEXT, $metalPhotoPath TEXT)',
    );
    await _insertInitialData(db);
  }

  Future<void> _insertInitialData(Database db) async {
    await db.insert(blocksTable, {
      blocksTitle: 'Цегла цементна',
      blocksDescription: 'Цементна цегла, або бетонна цегла, виготовляється з цементу, піску та води. Цей матеріал має високу міцність і довговічність. Вона часто використовується для будівництва фундаментів, стін та інших конструкцій, що потребують високої стійкості.',
      blocksPhotoPath: 'assets/images/img_4.png'
    });
    await db.insert(blocksTable, {
      blocksTitle: 'Цегла керамічна',
      blocksDescription: 'Керамічна цегла виготовляється з глини, яка формується у цеглу і обпалюється при високих температурах. Вона є дуже популярним будівельним матеріалом завдяки своїм відмінним теплоізоляційним властивостям, довговічності та екологічній чистоті. Керамічна цегла також має хорошу стійкість до морозу і вологи. Вона широко використовується для будівництва житлових будинків, комерційних будівель, камінів та інших конструкцій.',
      blocksPhotoPath: 'assets/images/img.png'
    });
    await db.insert(blocksTable, {
      blocksTitle: 'Пористий газобетонний блок',
      blocksDescription: 'Пористий газобетонний блок виготовляється з цементу, вапна, піску та алюмінієвого порошку. В процесі виробництва утворюються бульбашки газу, що надають матеріалу пористу структуру. Цей матеріал відзначається легкістю, високими теплоізоляційними властивостями та хорошою звукоізоляцією. Газобетонні блоки зручні у монтажі завдяки своїм великим розмірам і легкості. Вони часто використовуються для зведення зовнішніх і внутрішніх стін у житловому та комерційному будівництві.',
      blocksPhotoPath: 'assets/images/img_5.png'
    });
    await db.insert(blocksTable, {
      blocksTitle: 'Шлакоблок',
      blocksDescription: 'Шлакоблоки виготовляються з цементу і різних видів промислових відходів, таких як шлак, що є побічним продуктом металургійного виробництва. Цей матеріал відзначається високою міцністю та довговічністю. Шлакоблоки є відносно дешевими та мають хороші теплоізоляційні властивості. Вони часто використовуються для будівництва несучих стін, фундаментів та інших конструкцій, що потребують високої міцності.',
      blocksPhotoPath: 'assets/images/img_6.png'
    });
    await db.insert(blocksTable, {
      blocksTitle: 'Керамзитний блок',
      blocksDescription: 'Керамзитні блоки виготовляються з керамзиту (випаленої глини), цементу та піску. Керамзит надає матеріалу легкості та хороших теплоізоляційних властивостей. Блоки мають високу міцність і довговічність, а також відмінну звукоізоляцію. Керамзитні блоки використовуються для будівництва зовнішніх та внутрішніх стін, а також перегородок. Вони є екологічно чистими та енергоефективними.',
      blocksPhotoPath: 'assets/images/img_7.png'
    });

    await db.insert(windowsTable, {
      windowsTitle: 'Пластикові вікна',
      windowsDescription: 'Пластикові вікна виготовляються з полівінілхлориду (ПВХ), матеріалу, що відзначається високою стійкістю до впливу зовнішніх факторів, таких як ультрафіолетове випромінювання, волога та температурні коливання. Пластикові вікна мають відмінні тепло- та звукоізоляційні властивості, що робить їх популярними у сучасному будівництві.',
      windowsPhotoPath: 'assets/images/img_8.png'
    });
    await db.insert(windowsTable, {
      windowsTitle: 'Дерев\'яні вікна',
      windowsDescription: 'Дерев\'яні вікна виготовляються з натурального дерева, що надає їм привабливого та природного вигляду. Ці вікна мають відмінні теплоізоляційні властивості, оскільки дерево є природним ізолятором. Вони також забезпечують хорошу звукоізоляцію. Дерев\'яні вікна вимагають регулярного догляду, включаючи фарбування або лакування для захисту від вологи та шкідників',
      windowsPhotoPath: 'assets/images/img_9.png'
    });
    await db.insert(windowsTable, {
      windowsTitle: 'Металопластикові вікна',
      windowsDescription: 'Металопластикові вікна складаються з пластикових рам, армованих сталевими або алюмінієвими вставками для підвищення міцності. Ці вікна поєднують в собі переваги пластикових та металевих конструкцій, забезпечуючи високу тепло- та звукоізоляцію, стійкість до деформацій і довговічність. ',
      windowsPhotoPath: 'assets/images/img_10.png'
    });
    await db.insert(windowsTable, {
      windowsTitle: 'Алюмінієві вікна',
      windowsDescription: 'Алюмінієві вікна виготовляються з легкого та міцного алюмінієвого профілю. Вони мають високу стійкість до корозії, що робить їх ідеальними для використання в умовах підвищеної вологості або агресивного середовища. Алюмінієві вікна відрізняються сучасним дизайном і можуть бути виготовлені у великій кількості форм та розмірів.',
      windowsPhotoPath: 'assets/images/img_11.png'
    });
    await db.insert(windowsTable, {
      windowsTitle: 'Дерев\'яні двері',
      windowsDescription: 'Дерев\'яні двері виготовляються з натурального дерева, що надає їм естетичної привабливості та природної краси. Вони можуть бути виготовлені з різних порід деревини, що впливає на їх міцність, зовнішній вигляд та вартість. Дерев\'яні двері мають хороші тепло- та звукоізоляційні властивості, є екологічно чистими та можуть бути адаптовані до будь-якого стилю інтер\'єру. ',
      windowsPhotoPath: 'assets/images/img_12.png'
    });


    await db.insert(metalTable, {
      metalTitle: 'Стальні балки',
      metalDescription: 'Стальні балки – це конструктивні елементи, які використовуються для підтримки та розподілу навантажень у будівництві. Вони виготовляються з високоміцної сталі та можуть мати різні форми перерізу, такі як двотаврові (I-подібні), швелери (C-подібні) та кутові (L-подібні). Стальні балки застосовуються у будівництві будівель, мостів, промислових споруд та інших об\'єктів, де потрібна висока міцність і стійкість до навантажень.',
      metalPhotoPath: 'assets/images/img_17.png'
    });
    await db.insert(metalTable, {
      metalTitle: 'Металева арматура',
      metalDescription: 'Металева арматура – це стальні прути або дроти, які використовуються для зміцнення залізобетонних конструкцій. Арматура надає бетонним елементам додаткової міцності на розтяг та стиск, підвищуючи їх стійкість до навантажень. Вона може бути гладкою або з рифленою поверхнею, що забезпечує краще зчеплення з бетоном.',
      metalPhotoPath: 'assets/images/img_18.png'
    });
    await db.insert(metalTable, {
      metalTitle: 'Профільні труби',
      metalDescription: 'Профільні труби – це металеві труби з різним перерізом (квадратним, прямокутним, овальним), які використовуються у будівництві та виробництві. Вони виготовляються з високоміцної сталі і можуть мати різні розміри та товщини стінок. Профільні труби застосовуються для створення каркасів, опорних конструкцій, огороджень, меблів та інших виробів.',
      metalPhotoPath: 'assets/images/img_19.png'
    });
    await db.insert(metalTable, {
      metalTitle: 'Вироби зі сталі',
      metalDescription: 'Вироби зі сталі – це широкий спектр продукції, яка виготовляється з різних видів сталі та використовується у багатьох галузях промисловості та будівництва. До них відносяться стальні балки, арматура, профільні труби, металеві листи, стальні конструкції, механічні деталі, інструменти, побутова техніка та інші вироби. Сталь відзначається високою міцністю, довговічністю, стійкістю до корозії та механічних пошкоджень',
      metalPhotoPath: 'assets/images/img_20.png'
    });
    await db.insert(metalTable, {
      metalTitle: 'Металеві листи',
      metalDescription: 'Металеві листи – це плоскі сталеві вироби різної товщини, які використовуються у будівництві, машинобудуванні, виробництві побутових приладів та інших галузях. Вони можуть бути виготовлені з вуглецевої або нержавіючої сталі, а також можуть мати різні покриття для захисту від корозії. Металеві листи можуть бути оброблені різними методами (різання, згинання, зварювання), що дозволяє виготовляти з них різноманітні конструкції та деталі.',
      metalPhotoPath: 'assets/images/img_21.png'
    });

    await db.insert(treeTable, {
      treeTitle: 'Дерев\'яна дошка для підлоги',
      treeDescription: 'Дерев\'яна дошка для підлоги – це спеціально оброблена дошка, яка використовується як підлогове покриття. Вона виготовляється з різних порід деревини, що надає їй природного вигляду і теплої текстури. Підлогові дошки можуть бути оброблені для додаткового захисту від вологи, зношування та механічних пошкоджень. ',
      treePhotoPath: 'assets/images/img_13.png'
    });
    await db.insert(treeTable, {
      treeTitle: 'Дерев\'яні бруски',
      treeDescription: 'Дерев\'яні бруски – це пиломатеріал прямокутного перерізу, який використовується у будівництві та меблевій промисловості. Вони виготовляються з різних порід деревини та можуть мати різні розміри і форми залежно від потреб. Бруски застосовуються для створення каркасів, опорних конструкцій, як допоміжний матеріал у будівельних роботах, а також у виробництві меблів.',
      treePhotoPath: 'assets/images/img_14.png'
    });
    await db.insert(treeTable, {
      treeTitle: 'Дере\'яні ферми',
      treeDescription: 'Дерев\'яні ферми – це конструктивні елементи, які використовуються для створення каркасів дахів та інших несучих конструкцій у будівництві. Вони виготовляються з дерев\'яних брусків або дошок, які з\'єднуються у трикутні або інші геометричні форми для забезпечення високої міцності та стабільності конструкції. Дерев\'яні ферми дозволяють перекривати великі прольоти без необхідності додаткових опор, що забезпечує вільний простір у приміщенні',
      treePhotoPath: 'assets/images/img_15.png'
    });
    await db.insert(treeTable, {
      treeTitle: 'Дошка обрізна',
      treeDescription: 'Дошка обрізна – це пиломатеріал, який виготовляється шляхом розпилювання колоди на дошки, після чого з них знімаються всі бічні кромки, що робить їх рівними і гладкими. Вона використовується у будівництві, меблевій промисловості, для оздоблення інтер\'єрів та зовнішніх робіт.',
      treePhotoPath: 'assets/images/img_16.png'
    });
  }

  Future<int> insertBlocks(Map<String, dynamic> blockData) async {
    Database? db = await this.db;
    final int result = await db!.insert(blocksTable, blockData);
    return result;
  }
  Future<List<Map<String, dynamic>>> getBlockMapList() async {
    Database? db = await this.db;
    final List<Map<String, dynamic>> result = await db!.query(blocksTable);
    return result;
  }
  Future<int> insertWindows(Map<String, dynamic> windowData) async {
    Database? db = await this.db;
    final int result = await db!.insert(windowsTable, windowData);
    return result;
  }

  Future<List<Map<String, dynamic>>> getWindowMapList() async {
    Database? db = await this.db;
    final List<Map<String, dynamic>> result = await db!.query(windowsTable);
    return result;
  }

  Future<int> insertTree(Map<String, dynamic> treeData) async {
    Database? db = await this.db;
    final int result = await db!.insert(treeTable, treeData);
    return result;
  }

  Future<List<Map<String, dynamic>>> getTreeMapList() async {
    Database? db = await this.db;
    final List<Map<String, dynamic>> result = await db!.query(treeTable);
    return result;
  }

  Future<int> insertMetal(Map<String, dynamic> metalData) async {
    Database? db = await this.db;
    final int result = await db!.insert(metalTable, metalData);
    return result;
  }

  Future<List<Map<String, dynamic>>> getMetalMapList() async {
    Database? db = await this.db;
    final List<Map<String, dynamic>> result = await db!.query(metalTable);
    return result;
  }
}