///测试进制转换函数能否转化16进制
test "to_base_16" {
  if @lib.to_base(255, 16, true) != "FF" {
    fail!("hex conversion failed: expected FF")
  }
}

///测试进制转换函数能否转化8进制
test "to_base_8" {
  if @lib.to_base(25, 8, false) != "31" {
    fail!("octal conversion failed: expected 31")
  }
}

/// 测试整数格式化及标志位
test "fmt_int_flags" {
  let formatter = @lib.Formatter::new("number is %+d")
  let args = [@lib.Args_Type::Int(42)]
  if formatter.fmt(args) != "number is +42" {
    fail!("Integer with plus sign failed")
  }
}

/// 测试基本字符串格式化
test "fmt_string_basic" {
  let formatter = @lib.Formatter::new("Hello %s!")
  let args = [@lib.Args_Type::String("World")]
  if formatter.fmt(args) != "Hello World!" {
    fail!("Basic string format failed")
  }
}

/// 测试浮点数精度控制
test "fmt_float_precision" {
  let formatter = @lib.Formatter::new("pi is %.2f")
  let args = [@lib.Args_Type::Double(3.14159)]
  if formatter.fmt(args) != "pi is 3.14" {
    fail!("Float precision control failed")
  }
}

/// 测试无符号整数基本格式化
test "fmt_unsigned_basic" {
  let formatter = @lib.Formatter::new("%u")
  let args = [@lib.Args_Type::UInt(4294967295)]
  if formatter.fmt(args) != "4294967295" {
    fail!("Basic unsigned integer format failed")
  }
}

/// 测试科学计数法
test "fmt_scientific" {
  let formatter = @lib.Formatter::new("number is %.3e")
  let args = [@lib.Args_Type::Double(0.000123)]
  if formatter.fmt(args) != "number is 1.230e-04" {
    fail!("Scientific notation failed")
  }
}

/// 测试无穷大值处理
test "fmt_infinite" {
  let formatter = @lib.Formatter::new("value is %f")
  let args = [@lib.Args_Type::Double(1.0 / 0.0)]
  if formatter.fmt(args) != "value is inf" {
    fail!("Infinite value format failed")
  }
}

/// 测试宽度填充
test "fmt_width_padding" {
  let formatter = @lib.Formatter::new("padded number is %05d")
  let args = [@lib.Args_Type::Int(42)]
  if formatter.fmt(args) != "padded number is 00042" {
    fail!("Width padding failed")
  }
}

/// 测试字符串左对齐
test "fmt_string_left_align" {
  let formatter = @lib.Formatter::new("'%-10s'")
  let args = [@lib.Args_Type::String("left")]
  if formatter.fmt(args) != "'left      '" {
    fail!("String left alignment failed")
  }
}

/// 测试字符串右对齐
test "fmt_string_right_align" {
  let formatter = @lib.Formatter::new("'%10s'")
  let args = [@lib.Args_Type::String("right")]
  if formatter.fmt(args) != "'     right'" {
    fail!("String right alignment failed")
  }
}

/// 测试左对齐
test "fmt_left_align" {
  let formatter = @lib.Formatter::new("left aligned: '%-5d'")
  let args = [@lib.Args_Type::Int(42)]
  if formatter.fmt(args) != "left aligned: '42   '" {
    fail!("Left alignment failed")
  }
}

/// 测试无符号整数零填充
test "fmt_unsigned_zero_pad" {
  let formatter = @lib.Formatter::new("%05u")
  let args = [@lib.Args_Type::UInt(42)]
  if formatter.fmt(args) != "00042" {
    fail!("Unsigned integer zero padding failed")
  }
}

/// 测试通用格式化
test "fmt_general" {
  let formatter = @lib.Formatter::new("%g %.3G")
  let args = [@lib.Args_Type::Double(123.456), @lib.Args_Type::Double(0.000123)]
  if formatter.fmt(args) != "123.456 0.123" {
    fail!("General format failed")
  }
}

/// 测试多种格式混合
test "fmt_mixed" {
  let formatter = @lib.Formatter::new("hex=%X dec=%+d float=%.2f")
  let args = [
    @lib.Args_Type::Int(255),
    @lib.Args_Type::Int(42),
    @lib.Args_Type::Double(3.14159),
  ]
  if formatter.fmt(args) != "hex=FF dec=+42 float=3.14" {
    fail!("Mixed format failed")
  }
}
