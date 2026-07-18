class Student{
  String? name;
  int? rollno;
  double? marks;

  //make a constructor
  Student(String name,int rollno,double marks)
  {
    this.name=name;
    this.rollno=rollno;
    this.marks=marks;
  }

  //create a method
  void show()
  {
    print("the student name is: ${this.name}");
    print("the RollNo name is: ${this.rollno}");
    print("the marks name is: ${this.marks}");
  }
}
//crate a main method
void main()
{
  //create an object
  Student st1=Student("pranjul",101,155.32);
  st1.show();
}