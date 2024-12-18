
fn main {
  // 测试代码
  let fmt = @lib.Formatter::new("123 + 321  is %d , pi is %.3f")  // 格式化字符串
  let args = [@lib.Args_Type::Int(123+321), @lib.Args_Type::Double(3.14159)]  // 参数

  let formatted = fmt.fmt(args)  // 使用fmt方法格式化
  println(formatted)  
   
}