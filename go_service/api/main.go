package main

import (
	"net/http"
	"io"
	"log"
	"time"
)

func helloHandler(w http.ResponseWriter, r *http.Request) {
	io.WriteString(w, "Hello world!")
}


func main() {
	http.HandleFunc("/hello", helloHandler)
	log.Printf("Server started at %s", time.Now().Format(time.RFC3339Nano))
	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatalf("Server error: %v", err)
	}
}
