import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database?_database;
  DatabaseHelper._init();

  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await _initDB('app_data.db');
    return _database!;
  }

  Future<Database?> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version)
  async{
    await db.execute('''
    CREATE TABLE IF NOT EXISTS user_data(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    email TEXT UNIQUE,
    password TEXT,
    role TEXT,
    mobile TEXT
    )
    ''');

    await db.execute('''
    CREATE TABLE jobs(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    company TEXT,
    location TEXT,
    type TEXT,
    shift_timing TEXT,
    salary TEXT,
    duration TEXT,
    image TEXT,
    employer_id INTEGER,
    description TEXT
    )
    ''');

    await db.execute('''
    CREATE TABLE applications(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    job_id INTEGER
    )
    ''');

    await db.insert('jobs', {
      'title': 'Barista Assistant',
      'company': 'Coffee Corner',
      'location': 'Jagriti Vihar, Meerut',
      'salary': '450/day',
      'type': 'Part-time',
      'shift_timing': 'Morning (4 hrs)',
      'duration': 'Ongoing',
      'employer_id': 1,
      'description': 'Part-time Barista Assistant at Coffee Corner, Jagriti Vihar, Meerut. Assist with beverage preparation, cleanliness, and basic customer service. Morning shift (4 hours). Ongoing role offering ₹450 per day, suitable for flexible work'

    });

    await db.insert('jobs', {
      'title': 'Cafe Cleaner',
      'company': 'Urban Cafe',
      'location': 'Ganga Nagar, Rishikesh',
      'salary': '400/day',
      'type': 'Part-time',
      'shift_timing': 'Afternoon (2 hrs)',
      'duration': 'Ongoing',
      'employer_id': 2,
      'description': 'Part-time Cafe Cleaner needed at Urban Cafe in Ganga Nagar, Rishikesh. Responsibilities include maintaining cleanliness of seating areas, kitchen surfaces, and washrooms. Afternoon shift of 2 hours daily. Ongoing role offering ₹400 per day, ideal for candidates seeking flexible work.'
    });

    await db.insert('jobs', {
      'title': 'Waiter',
      'company': 'Foodies Hub',
      'location': 'Abu Lane, Haridwar',
      'salary': '550/day',
      'type': 'Part-time',
      'shift_timing': 'Evening (3 hrs)',
      'duration': 'Weekend',
      'employer_id': 3,
      'description':'Part-time Waiter needed at Foodies Hub, Abu Lane, Haridwar. Responsibilities include serving customers, taking orders, and maintaining table cleanliness. Evening shift (3 hours) on weekends. Role offers ₹550 per day, ideal for short-term flexible work.'
    });

    await db.insert('jobs', {
      'title': 'Delivery Executive',
      'company': 'Dominos',
      'location': 'RaniPokhri, Dehradun',
      'salary': '600/day',
      'type': 'Part-time',
      'shift_timing': 'Flexible',
      'duration': 'Weekend',
      'employer_id': 4,
      'description':'Join as a Delivery Executive with Dominos in RaniPokhri, Dehradun. Earn ₹600 per day with flexible weekend shifts. Ideal for part-time work, this role involves timely food delivery, customer interaction, and ensuring a smooth service experience.'

    });

    await db.insert('jobs', {
      'title': 'Parcel Delivery',
      'company': 'Flipkart',
      'location': 'Dehradun Road, Rishikesh',
      'salary': '650/day',
      'type': 'Part-time',
      'shift_timing': 'Morning',
      'duration': 'Ongoing',
      'employer_id': 5,
      'description': 'Work as a Parcel Delivery Associate with Flipkart on Dehradun Road, Rishikesh. Earn ₹650 per day in a part-time morning shift. Responsibilities include timely parcel delivery, handling packages safely, and maintaining good customer communication for a smooth delivery experience.'
    });

    await db.insert('jobs', {
      'title': 'Courier Helper',
      'company': 'DTDC',
      'location': 'AIIMS Road, Rishikesh',
      'salary': '500/day',
      'type': 'Part-time',
      'shift_timing': 'Afternoon',
      'duration': 'Ongoing',
      'employer_id': 6,
      'description':'Join DTDC as a Courier Helper on AIIMS Road, Rishikesh. Earn ₹500 per day with part-time afternoon shifts. Assist in sorting, loading, and delivering parcels while ensuring accuracy and supporting smooth day-to-day courier operations.'
    });

    await db.insert('jobs', {
      'title': 'Store Helper',
      'company': 'Big Bazaar',
      'location': 'Indra Nagar, Doiwala',
      'salary': '450/day',
      'type': 'Part-time',
      'shift_timing': 'Evening (3 hrs)',
      'duration': 'Ongoing',
      'employer_id': 7,
      'description':'Join Big Bazaar as a part-time Store Helper in Indra Nagar, Doiwala. Assist with stocking, organizing shelves, and helping customers. Evening shift (3 hours daily). Earn ₹450 per day with ongoing work—ideal for those seeking flexible, consistent part-time employment.'
    });

    await db.insert('jobs', {
      'title': 'Billing Assistant',
      'company': 'EasyDay',
      'location': 'Tapovan, Rishikesh',
      'salary': '500/day',
      'type': 'Part-time',
      'shift_timing': 'Afternoon',
      'duration': 'Ongoing',
      'employer_id': 8,
      'description':'Work as a Store Helper at Big Bazaar in Tapovan, Rishikesh. Earn ₹450 per day with a part-time evening shift of 3 hours. Responsibilities include assisting customers, managing stock, and maintaining store cleanliness for smooth daily operations.'
    });

    await db.insert('jobs', {
      'title': 'Mall Assistant',
      'company': 'City Mall',
      'location': 'Garh Road, Haridwar',
      'salary': '550/day',
      'type': 'Part-time',
      'shift_timing': 'Evening',
      'duration': 'Weekend',
      'employer_id': 9,
      'description': 'Join City Mall as a Mall Assistant on Garh Road, Haridwar. Earn ₹550 per day with weekend evening shifts. Responsibilities include helping customers, guiding visitors, maintaining store areas, and supporting smooth mall operations during peak hours.'
    });

    await db.insert('jobs', {
      'title': 'Math Tutor',
      'company': 'Home Tuition',
      'location': 'Saket, Dehradun',
      'salary': '700/day',
      'type': 'Part-time',
      'shift_timing': 'Evening (2 hrs)',
      'duration': 'Ongoing',
      'employer_id': 10,
      'description': 'Provide home tuition as a Math Tutor in Saket, Dehradun. Earn ₹700 per day in a part-time 2-hour evening shift. Teach math concepts, assist students with practice, and improve their academic performance through personalized guidance.'
    });

    await db.insert('jobs', {
      'title': 'Science Tutor',
      'company': 'Private Tuition',
      'location': 'Lal Kurti, Haridwar',
      'salary': '750/day',
      'type': 'Part-time',
      'shift_timing': 'Evening',
      'duration': 'Ongoing',
      'employer_id': 11,
      'description':'Provide home tuition as a Science Tutor in Lal Kurti, Haridwar. Earn ₹750 per day in a part-time evening shift. Teach science concepts, support students with assignments and practice, and help improve their academic understanding through personalized guidance.'
    });

    await db.insert('jobs', {
      'title': 'English Tutor',
      'company': 'Coaching Center',
      'location': 'Shivaji Road, Dehradun',
      'salary': '600/day',
      'type': 'Part-time',
      'shift_timing': 'Morning',
      'duration': 'Ongoing',
      'employer_id': 12,
      'description':'Work as an English Tutor at a Coaching Center on Shivaji Road, Dehradun. Earn ₹600 per day in a part-time morning shift. Teach grammar, communication skills, and writing, helping students improve fluency and academic performance through guided practice.'
    });

    await db.insert('jobs', {
      'title': 'Data Entry',
      'company': 'Freelance Work',
      'location': 'Remote',
      'salary': '300/day',
      'type': 'Part-time',
      'shift_timing': 'Flexible',
      'duration': 'Project-based',
      'employer_id': 13,
      'description':'Work as a Data Entry Executive in a remote freelance role. Earn ₹300 per day with flexible timing on a project-based arrangement. Responsibilities include accurate data entry, record maintenance, and completing tasks within deadlines.'
    });

    await db.insert('jobs', {
      'title': 'Content Writer',
      'company': 'Blog Site',
      'location': 'Remote',
      'salary': '400/day',
      'type': 'Part-time',
      'shift_timing': 'Flexible',
      'duration': 'Project-based',
      'employer_id': 14,
      'description': 'Work as a Content Writer for a blog site in a remote role. Earn ₹400 per day with flexible timing on a project-based arrangement. Responsibilities include writing engaging articles, researching topics, and delivering quality content within deadlines.'
    });

    await db.insert('jobs', {
      'title': 'Social Media Manager',
      'company': 'Startup',
      'location': 'Remote',
      'salary': '500/day',
      'type': 'Part-time',
      'shift_timing': 'Flexible',
      'duration': 'Ongoing',
      'employer_id': 15,
      'description':'Work as a Social Media Manager for a startup in a remote role. Earn ₹500 per day with flexible timing in an ongoing part-time arrangement. Responsibilities include managing social platforms, creating posts, engaging audiences, and growing online presence.'
    });
  }

  //REGISTER
  Future<int> registerUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert('user_data', user);
  }

  //LOGIN
Future<Map<String, dynamic>?>
  loginUser(String email, String password)
  async {
    final db = await database;
    var res = await db.query(
      'user_data',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if(res.isNotEmpty){
      return res.first;
    }
    return null;
  }

  Future<List<Map<String, dynamic>>>
  getJobs() async {
    final db = await database;
    return await db.query('jobs');
  }


  Future<void> applyJob(int userId, int jobId) async{
    final db = await database;
    await db.insert('applications', {
      'user_id': userId,
      'job_id':jobId,
    });
  }

  Future<bool> alreadyApplied(int userId, int jobId) async {
    final db = await database;

    var res = await db.query(
      'applications',
      where: 'user_id = ? AND job_id = ?',
      whereArgs: [userId, jobId],
    );

    return res.isNotEmpty;
  }

  Future<int> insertJob(Map<String, dynamic> job) async{
    final db = await database;
    return await db.insert('jobs', job);
  }


  Future<List<Map<String, dynamic>>>
  getApplicants(int employerId)async{
    final db = await database;

    return await db.rawQuery('''
    SELECT
    user_data.name,
    user_data.email,
    user_data.mobile,
    jobs.title,
    jobs.location
    FROM applications
    INNER JOIN user_data ON
    applications.user_id = user_data.id
    INNER JOIN jobs ON
    applications.job_id = jobs.id
    WHERE jobs.employer_id = ?
    ''',[employerId]);
  }


  Future<List<Map<String, dynamic>>>
  getApplications(int userId) async{
    final db = await database;
    return await db.rawQuery('''
    SELECT jobs.*FROM jobs
    INNER JOIN applications
    ON jobs.id = applications.job_id
    WHERE applications.user_id = ?
    ''',[userId]);
  }
}