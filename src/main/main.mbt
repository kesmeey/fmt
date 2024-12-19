
fn main {
  let fmt = @lib.Formatter::new("%s %d %.3f %x %X %o");
  let args = [
    @lib.Args_Type::String("Yuzusoft"),
    @lib.Args_Type::Int(123),
    @lib.Args_Type::Double(3.14159),
    @lib.Args_Type::Int(255),
    @lib.Args_Type::Int(255),
    @lib.Args_Type::Int(255)
  ];

  let result = fmt.fmt(args);
  print(result);  // 
}
