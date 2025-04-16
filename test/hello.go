package main

import "fmt"

func main() {
	num := 42
	pi := 3.14159
	str := "hello"

	fmt.Printf("Integer: %-5d 123\n", num) // 整数
	fmt.Printf("Float: %.2f\n", pi)        // 浮点数（保留2位小数）
	fmt.Printf("String: %10s\n", str)      // 字符串
	fmt.Printf("Hex: 0x%x\n", num)         // 十六进制
}
