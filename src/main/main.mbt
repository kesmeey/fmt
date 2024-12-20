///|
fn main {
  // 示例：科学计数法格式化
  let fmt_str = "Scientific notation: %10.3e, Uppercase: %12.2E"

  // 初始化Formatter
  let formatter = Formatter::new(fmt_str)

  // 定义参数
  let args : Array[Args_Type] = [
    Args_Type::Double(0.00012345), // 科学计数法格式化（小写）
    Args_Type::Double(-98765.4321), // 科学计数法格式化（大写）
  ]

  // 使用Formatter进行格式化
  let result = formatter.fmt(args)

  // 打印结果
  println(result)
}
