package main

import (
	"fmt"
	"net"
	"net/http"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		addrs, err := net.InterfaceAddrs()
		if err != nil {
			http.Error(w, "Internal Server Error", http.StatusInternalServerError)
			return
		}
		for _, addr := range addrs {
			if ipNet, ok := addr.(*net.IPNet); ok && !ipNet.IP.IsLoopback() {
				if ipNet.IP.To4() != nil {
					fmt.Fprintf(w, "Hello, I am from %s", ipNet.IP.String())
					return
				}
			}
		}
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
	})

	fmt.Println("Server is starting on port 80...")
	http.ListenAndServe(":80", nil)
}
