package main

import (
	"fmt"

	utilsgo "github.com/lideranca-sites/nx-blueprint-org/libs/utils-go"
)

func Hello(name string) string {
	result := "Hello " + name
	return result
}

func main() {
	fmt.Println(Hello("service-go"))
	fmt.Println(utilsgo.UtilsGo("service-go"))
}
