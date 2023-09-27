
package main

import (
	"log"
	"net/http"
	"os"
)

const (
	DEFAULT_PORT = "18888"
)

func main() {
	var port string
	if port = os.Getenv("PORT"); len(port) == 0 {
		port = DEFAULT_PORT
	}

	http.Handle("/", http.FileServer(http.Dir("static")))
	log.Printf("Starting app on :%+v\n", port)
	http.ListenAndServe(":"+port, nil)
}

