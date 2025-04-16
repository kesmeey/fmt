///| 为什么要写这个库
test "test" {
  let num = 123.321
  println("num: \{num}") // num: 123.321
}

///|
///| 测试所有格式化说明符类型
test "fmt_all_specifiers" {
  let formatter = @fmt.Formatter::new(
    "小写十六进制: %x\n" +
    "大写十六进制: %X\n" +
    "八进制: %o\n" +
    "科学计数法(小写): %.2e\n" +
    "科学计数法(大写): %.2E\n" +
    "通用格式(小数): %g\n" +
    "通用格式(大数，小写): %g\n" +
    "通用格式(大数，大写): %G\n" +
    "无符号整数: %u",
  )
  let args = [
    @fmt.Args_Type::Int(255), // %x
    @fmt.Args_Type::Int(255), // %X
    @fmt.Args_Type::Int(64), // %o
    @fmt.Args_Type::Double(1234.5678), // %e
    @fmt.Args_Type::Double(1234.5678), // %E
    @fmt.Args_Type::Double(3.14159), // %g (小数)
    @fmt.Args_Type::Double(123456789.0), // %g (大数)
    @fmt.Args_Type::Double(123456789.0), // %G (大数)
    @fmt.Args_Type::UInt(42), // %u
  ]
  let result = formatter.fmt(args)
  println(result)
  let expected = "小写十六进制: ff\n" +
    "大写十六进制: FF\n" +
    "八进制: 100\n" +
    "科学计数法(小写): 1.23e+03\n" +
    "科学计数法(大写): 1.23E+03\n" +
    "通用格式(小数): 3.14159\n" +
    "通用格式(大数，小写): 1.23457e+08\n" +
    "通用格式(大数，大写): 1.23457E+08\n" +
    "无符号整数: 42"
  if result != expected {
    fail!("All specifiers formatting test failed")
  }
}

///|
test "fmt_basic_text" {
  let formatter = @fmt.Formatter::new("Hello, World!")
  let args = []
  let result = formatter.fmt(args)
  println(result)
  if result != "Hello, World!" {
    fail!("Basic text formatting failed")
  }
}

///| 测试整数格式化
test "fmt_integer" {
  let formatter = @fmt.Formatter::new("%d")
  let args = [@fmt.Args_Type::Int(42)]
  let result = formatter.fmt(args)
  println(result)
  if result != "42" {
    fail!("Integer formatting failed")
  }
}

///| 测试整数宽度格式化
test "fmt_integer_width" {
  let formatter = @fmt.Formatter::new("%5d")
  let args = [@fmt.Args_Type::Int(42)]
  let result = formatter.fmt(args)
  println(result)
  if result != "   42" {
    fail!("Integer width formatting failed")
  }
}

///| 测试整数零填充
test "fmt_integer_zero_pad" {
  let formatter = @fmt.Formatter::new("%05d")
  let args = [@fmt.Args_Type::Int(42)]
  let result = formatter.fmt(args)
  println(result)
  if result != "00042" {
    fail!("Integer zero padding failed")
  }
}

///| 测试整数左对齐
test "fmt_integer_left_align" {
  let formatter = @fmt.Formatter::new("'%-5d'")
  let args = [@fmt.Args_Type::Int(42)]
  let result = formatter.fmt(args)
  println(result)
  if result != "'42   '" {
    fail!("Integer left alignment failed")
  }
}

///| 测试整数显示符号
test "fmt_integer_show_sign" {
  let formatter = @fmt.Formatter::new("%+d")
  let args = [@fmt.Args_Type::Int(42)]
  let result = formatter.fmt(args)
  println(result)
  if result != "+42" {
    fail!("Integer show sign failed")
  }
}

///| 测试浮点数格式化
test "fmt_float" {
  let formatter = @fmt.Formatter::new("%.2f")
  let args = [@fmt.Args_Type::Double(3.14159)]
  let result = formatter.fmt(args)
  println(result)
  if result != "3.14" {
    fail!("Float formatting failed")
  }
}

///| 测试浮点数宽度和精度
test "fmt_float_width_precision" {
  let formatter = @fmt.Formatter::new("%8.3f")
  let args = [@fmt.Args_Type::Double(3.14159)]
  let result = formatter.fmt(args)
  println(result)
  if result != "   3.142" {
    fail!("Float width and precision failed")
  }
}

///| 测试浮点数零填充
test "fmt_float_zero_pad" {
  let formatter = @fmt.Formatter::new("%08.3f")
  let args = [@fmt.Args_Type::Double(3.14159)]
  let result = formatter.fmt(args)
  println(result)
  if result != "0003.142" {
    fail!("Float zero padding failed")
  }
}

///| 测试字符串格式化
test "fmt_string" {
  let formatter = @fmt.Formatter::new("%s")
  let args = [@fmt.Args_Type::String("test")]
  let result = formatter.fmt(args)
  println(result)
  if result != "test" {
    fail!("String formatting failed")
  }
}

///| 测试字符串宽度
test "fmt_string_width" {
  let formatter = @fmt.Formatter::new("%10s")
  let args = [@fmt.Args_Type::String("test")]
  let result = formatter.fmt(args)
  println(result)
  if result != "      test" {
    fail!("String width formatting failed")
  }
}

///| 测试字符串左对齐
test "fmt_string_left_align" {
  let formatter = @fmt.Formatter::new("'%-10s'")
  let args = [@fmt.Args_Type::String("left")]
  let result = formatter.fmt(args)
  println(result)
  if result != "'left      '" {
    fail!("String left alignment failed")
  }
}

///| 测试小写十六进制格式化
test "fmt_hex_lower" {
  let formatter = @fmt.Formatter::new("%x")
  let args = [@fmt.Args_Type::Int(255)]
  let result = formatter.fmt(args)
  println(result)
  if result != "ff" {
    fail!("Lowercase hex formatting failed")
  }
}

///| 测试大写十六进制格式化
test "fmt_hex_upper" {
  let formatter = @fmt.Formatter::new("%X")
  let args = [@fmt.Args_Type::Int(255)]
  let result = formatter.fmt(args)
  println(result)
  if result != "FF" {
    fail!("Uppercase hex formatting failed")
  }
}

///| 测试八进制格式化
test "fmt_octal" {
  let formatter = @fmt.Formatter::new("%o")
  let args = [@fmt.Args_Type::Int(8)]
  let result = formatter.fmt(args)
  println(result)
  if result != "10" {
    fail!("Octal formatting failed")
  }
}

///| 测试科学计数法格式化
test "fmt_scientific" {
  let formatter = @fmt.Formatter::new("%.2e")
  let args = [@fmt.Args_Type::Double(1234.5678)]
  let result = formatter.fmt(args)
  println(result)
  if result != "1.23e+03" {
    fail!("Scientific notation formatting failed")
  }
}

///| 测试通用格式化 (g)
test "fmt_general" {
  let formatter = @fmt.Formatter::new("%g")
  let args = [@fmt.Args_Type::Double(123456789.0)]
  let result = formatter.fmt(args)
  println(result)
  if result != "1.23457e+08" {
    fail!("General format for large numbers failed")
  }
}

///| 测试无符号整数格式化
test "fmt_unsigned" {
  let formatter = @fmt.Formatter::new("%u")
  let args = [@fmt.Args_Type::UInt(42)]
  let result = formatter.fmt(args)
  println(result)
  if result != "42" {
    fail!("Unsigned integer formatting failed")
  }
}

///| 测试多个格式化指定符
test "fmt_multiple_specifiers" {
  let formatter = @fmt.Formatter::new("Name: %s, Age: %d, Height: %.2f")
  let args = [
    @fmt.Args_Type::String("John"),
    @fmt.Args_Type::Int(30),
    @fmt.Args_Type::Double(1.85),
  ]
  let result = formatter.fmt(args)
  println(result)
  if result != "Name: John, Age: 30, Height: 1.85" {
    fail!("Multiple format specifiers failed")
  }
}

///| 测试特殊浮点值 (inf, nan)
test "fmt_special_float_values" {
  let inf_formatter = @fmt.Formatter::new("%f")
  let inf_args = [@fmt.Args_Type::Double(1.0 / 0.0)]
  let inf_result = inf_formatter.fmt(inf_args)
  println(inf_result)
  if inf_result != "inf" {
    fail!("Infinity formatting failed")
  }
  let nan_formatter = @fmt.Formatter::new("%f")
  let nan_args = [@fmt.Args_Type::Double(0.0 / 0.0)]
  let nan_result = nan_formatter.fmt(nan_args)
  println(nan_result)
  if nan_result != "nan" {
    fail!("NaN formatting failed")
  }
}

///| 测试整数和浮点数组合格式化
test "fmt_combined_formatting" {
  let formatter = @fmt.Formatter::new("%+05d | %8.3f | %-10s")
  let args = [
    @fmt.Args_Type::Int(42),
    @fmt.Args_Type::Double(3.14159),
    @fmt.Args_Type::String("test"),
  ]
  let result = formatter.fmt(args)
  println(result)
  if result != "+0042 |    3.142 | test      " {
    fail!("Combined formatting failed")
  }
}

///| 测试Printf风格的格式化
test "fmt_printf_style" {
  let formatter = @fmt.Formatter::new("Integer: %d, Float: %.2f, String: %s")
  let args = [
    @fmt.Args_Type::Int(123),
    @fmt.Args_Type::Double(45.678),
    @fmt.Args_Type::String("hello"),
  ]
  let result = formatter.fmt(args)
  println(result)
  if result != "Integer: 123, Float: 45.68, String: hello" {
    fail!("Printf style formatting failed")
  }
}

///| 测试边界情况 - 空格式字符串
test "fmt_empty_format_string" {
  let formatter = @fmt.Formatter::new("")
  let args = []
  let result = formatter.fmt(args)
  println(result)
  if result != "" {
    fail!("Empty format string test failed")
  }
}

///| 测试字符格式化
test "fmt_char" {
  let formatter = @fmt.Formatter::new("%c")
  let args = [@fmt.Args_Type::Char('A')]
  let result = formatter.fmt(args)
  println(result)
  if result != "A" {
    fail!("Character formatting failed")
  }
}

///| 测试字符宽度和对齐
test "fmt_char_width_align" {
  let formatter = @fmt.Formatter::new("'%5c' '%-5c'")
  let args = [@fmt.Args_Type::Char('A'), @fmt.Args_Type::Char('B')]
  let result = formatter.fmt(args)
  println(result)
  if result != "'    A' 'B    '" {
    fail!("Character width and alignment failed")
  }
}

///| 测试布尔值格式化
test "fmt_bool" {
  let formatter = @fmt.Formatter::new("%t %t")
  let args = [@fmt.Args_Type::Bool(true), @fmt.Args_Type::Bool(false)]
  let result = formatter.fmt(args)
  println(result)
  if result != "true false" {
    fail!("Boolean formatting failed")
  }
}

///| 测试布尔值宽度和对齐
test "fmt_bool_width_align" {
  let formatter = @fmt.Formatter::new("'%8t' '%-8t'")
  let args = [@fmt.Args_Type::Bool(true), @fmt.Args_Type::Bool(false)]
  let result = formatter.fmt(args)
  println(result)
  if result != "'    true' 'false   '" {
    fail!("Boolean width and alignment failed")
  }
}

///| 测试所有格式化说明符包括新增的字符和布尔类型
test "fmt_all_specifiers_extended" {
  let formatter = @fmt.Formatter::new(
    "整数: %d\n" +
    "浮点数: %.2f\n" +
    "字符串: %s\n" +
    "字符: %c\n" + // 新增
    "布尔值: %t\n" + // 新增
    "小写十六进制: %x\n" +
    "大写十六进制: %X\n" +
    "八进制: %o\n" +
    "科学计数法(小写): %.2e\n" +
    "科学计数法(大写): %.2E\n" +
    "通用格式(小数): %g\n" +
    "通用格式(大数，小写): %g\n" +
    "通用格式(大数，大写): %G\n" +
    "无符号整数: %u",
  )
  let args = [
    @fmt.Args_Type::Int(42),
    @fmt.Args_Type::Double(3.14159),
    @fmt.Args_Type::String("hello"),
    @fmt.Args_Type::Char('Z'), // 新增
    @fmt.Args_Type::Bool(true), // 新增
    @fmt.Args_Type::Int(255),
    @fmt.Args_Type::Int(255),
    @fmt.Args_Type::Int(64),
    @fmt.Args_Type::Double(1234.5678),
    @fmt.Args_Type::Double(1234.5678),
    @fmt.Args_Type::Double(3.14159),
    @fmt.Args_Type::Double(123456789.0),
    @fmt.Args_Type::Double(123456789.0),
    @fmt.Args_Type::UInt(42),
  ]
  let result = formatter.fmt(args)
  println(result)

  // 检查包含新格式说明符的结果
  if result.contains("字符: Z") == false ||
    result.contains("布尔值: true") == false {
    fail!("Extended formatting test failed")
  }
}
