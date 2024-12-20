# fmt

%s %d %f %X  %x用法样例

```
fn main { 
 // 定义格式化字符串
    let fmt_str = "Hello %s, you have %05d unread messages. Pi is approximately %.2f. Hex value: %08X It also equals %6x.";

    // 初始化Formatter
    let formatter = Formatter::new(fmt_str);

    // 定义参数
    let args: Array[Args_Type] = [
        Args_Type::String("Alice".to_string()), // %s 替换为 "Alice"
        Args_Type::Int(42),                    // %05d 替换为 "00042"
        Args_Type::Double(3.14159),            // %.2f 替换为 "3.14"
        Args_Type::Int(255),                   // %08X 替换为 "000000FF" (大写十六进制)
        Args_Type::Int(255),                   // %6X 替换为""(小写十六进制)
    ];

    // 使用Formatter进行格式化
    let result = formatter.fmt(args);

    // 打印结果
    println(result);

}
```

```
Hello Alice, you have 00042 unread messages. Pi is approximately 3.14. Hex value: 000000FF It also equals     ff.
```



科学技术法 %e %E 用法样例

```
fn main { 
 // 示例：科学计数法格式化
    let fmt_str = "Scientific notation: %10.3e, Uppercase: %12.2E";

    // 初始化Formatter
    let formatter = Formatter::new(fmt_str);

    // 定义参数
    let args: Array[Args_Type] = [
        Args_Type::Double(0.00012345), // 科学计数法格式化（小写）
        Args_Type::Double(-98765.4321), // 科学计数法格式化（大写）
    ];

    // 使用Formatter进行格式化
    let result = formatter.fmt(args);

    // 打印结果
    println(result);

}
```

```
Scientific notation:  1.234e-04, Uppercase:   -9.-87E+04
```

