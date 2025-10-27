package utilsgo

import (
	"testing"
)

func TestUtilsGo(t *testing.T) {
	result := UtilsGo("works")
	if result != "UtilsGo works" {
		t.Error("Expected UtilsGo to append 'works'")
	}
}
