package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
	"time"
)

func main() {
	http.HandleFunc("/register", func(w http.ResponseWriter, req *http.Request) {
		defer req.Body.Close()
		b, err := ioutil.ReadAll(req.Body)
		if err != nil {
			fmt.Fprintf(os.Stderr, "failed to read request from client: %s\n", err)
			w.WriteHeader(500)
			fmt.Fprintf(w, `{"error":"failed"}`)
			return
		}

		var in struct {
			Email string `json:"email"`
		}
		if err := json.Unmarshal(b, &in); err != nil {
			fmt.Fprintf(os.Stderr, "failed to parse request '%s' from client: %s\n", string(b), err)
			w.WriteHeader(500)
			fmt.Fprintf(w, `{"error":"failed"}`)
			return
		}

		fmt.Printf("[%s] REGISTER <%s>\n", time.Now().Format(time.RFC3339), in.Email)

		w.WriteHeader(200)
		fmt.Fprintf(w, `{"ok":"registered"}`)
	})

	http.Handle("/", http.FileServer(http.Dir("./htdocs")))

	fmt.Fprintf(os.Stderr, "coming-soon listening on *:3000...\n")
	http.ListenAndServe(":3000", nil)
	fmt.Fprintf(os.Stderr, "coming-soon shutting down...\n")
}
