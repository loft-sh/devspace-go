package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

// main function
func main() {
	router := gin.Default()

	router.GET("/ping", func(c *gin.Context) {
		c.String(http.StatusOK, "pong")
	})
	router.GET("/pingz", func(c *gin.Context) {
		c.String(http.StatusOK, "shhhhhhh")
	})
	// 4
	router.GET("/xing", func(c *gin.Context) {
		c.String(http.StatusOK, "zong")
	})

	router.GET("/hello/:name", func(c *gin.Context) {
		name := c.Param("name")
		c.String(http.StatusOK, "Hello %s", name)
	})

	router.Run(":8080")
}
