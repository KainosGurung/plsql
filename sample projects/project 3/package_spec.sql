CREATE OR REPLACE PACKAGE project3_package as
  PROCEDURE pro_department_report;
  PROCEDURE pro_student_stats;
  PROCEDURE pro_faculty_stats;
  PROCEDURE pro_histogram;
  PROCEDURE pro_enroll(sname_in IN student.sname%type, cname_in IN class.cname%type);
end project3_package;