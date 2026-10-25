mixin Loggable {
  void log(String message) {
    print('[LOG] $runtimeType: $message');
  }
}

// abstract base class from week 9 
abstract class Student {
  final String studentID;
  final String name;
  final String program;
  // private field for encapsulation
  final Map<String, double> _grades = {};

  Student(this.studentID, this.name, this.program);
  // getters
  double get passingGrade;
  String get level;

  Map<String, double> get grades => Map.unmodifiable(_grades);

  void addGrade(String subject, double grade) {
    if (grade < 0 || grade > 100) {
      print('Invalid grade for $subject. Must be 0-100.');
      return;
    }
    _grades[subject] = grade;
    print('$name: $subject = $grade recorded.');
  }

  void removeGrade(String subject) {
    if (_grades.remove(subject) != null) {
      print('$name: $subject removed.');
    } else {
      print('$name: no grade found for $subject.');
    }
  }

  double computeAvg() {
    if (_grades.isEmpty) return 0;
    double sum = 0;
    for (var g in _grades.values) {
      sum += g;
    }
    return sum / _grades.length;
  }
  // abstract getters for different subclass results
  String get standing =>
      computeAvg() >= passingGrade ? 'Passed' : 'Needs improvement';

  void showReport() {
    print('--- $name ($studentID) | $program | $level ---');
    _grades.forEach((subject, grade) => print(' $subject: $grade'));
    print(' Average: ${computeAvg().toStringAsFixed(2)}');
    print(' Passing grade: $passingGrade = $standing');
  }
  
  Future <String> saveRecord () async {
      print ('Saving record for $name...');
      await Future.delayed (const Duration (seconds: 2));
      return 'Record for $name ($studentID) saved. '
        'Average: ${computeAvg().toStringAsFixed(2)}';
    }
}
// class 1
class UndergraduateStudent extends Student {
  final int yearLvl;
  

  UndergraduateStudent(
    super.studentID,
    super.name,
    super.program,
    this.yearLvl,
  );

  @override
  double get passingGrade => 75;
  @override
  String get level => 'Undergraduate (Year $yearLvl)';
}
// class 2
class GraduateStudent extends Student {
  final String thesisTitle;

  GraduateStudent(super.studentID, super.name, super.program, this.thesisTitle);

  @override
  double get passingGrade => 85;
  @override
  String get level => 'Graduate';

  @override
  void showReport() {
    super.showReport();
    print(' Thesis: $thesisTitle');
  }
}
// class outside the chain using mixin
class Instructor with Loggable {
  final String name;
  final String dept;

  Instructor(this.name, this.dept);

  void submitGrade(Student student, String subject, double grade) {
    log('$name submitted $grade for ${student.name} in $subject');
    student.addGrade(subject, grade);
  }
}

class Course with Loggable {
  final String code;
  final String title;
  final List<Student> _enrolled = [];

  Course(this.code, this.title);

  void enroll(Student student) {
    _enrolled.add(student);
    log('${student.name} enrolled in $code - $title');
  }

  int get enrolledCount => _enrolled.length;
}

Future <void> main() async {
  var s1 = UndergraduateStudent('2026-0001', 'Jeslyn Kyl Sesma', 'BSIT', 3);
  var s2 = GraduateStudent(
    '2026-0002',
    'Juan Dela Cruz',
    'MIT',
    'Mobile App Performance', 
  );

  var prof = Instructor('Prof. Reyes', 'College of Computing');
  var course = Course('PC16', 'Mobile Development');

  course.enroll(s1);
  course.enroll(s2);

  prof.submitGrade(s1, 'Mobile Development', 90);
  prof.submitGrade(s1, 'Integrative Programming & Technologies', 89);
  prof.submitGrade(s2, 'Mobile Development', 80);
  prof.submitGrade(s2, 'Research Methods', 84);
  s1.addGrade('Ethics', 150); // validation for rejected grade

  // application for polymorphism
  List<Student> students = [s1, s2];
  print('\n==== STUDENT REPORT ====');
  for (var s in students) {
    s.showReport();
  }

  // async demo
  print ('\n==== ASYNC: SAVING RECORDS ====');
  
  print ('Starting save for ${s1.name}...');
  var pending = s1.saveRecord();
  print ('Main continues: doing other work while saving...');
  
  var result1 = await pending;
  print (result1);
  
  var result2 = await s2.saveRecord();
  print (result2);
  
  print ('All records saved.');
  print ('\nEnrolled in ${course.code}: ${course.enrolledCount}');
  
}
