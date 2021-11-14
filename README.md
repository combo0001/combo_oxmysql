# combo_ghmatti
A middleware for FiveM servers with vRPEX framework, a trial version aimed at vRP.

## Differentials
### > Supports multiple queries (using ";")
### > If you have a condition in your query (which uses ";" without being a multiple query), and you want to do a multiple query, it needs to be the first query used in prepare.
### > Execute mode will always return integer number type the affected rows
### > The scalar mode doesn't have to change in this middleware
### > In standard query mode, multiple queries will return, when they are setters, the amount of affected rows, and when getter, they will return the selected rows.
### > Remembering that it will return multiple queries in separate variables, not an array.
### > Adaptation to accept LAST_INSERT_ID(), mysql's default syntax, impossible, as oxmysql does not accept multiple queries.

## Scripts requireds
### > [oxmysql](https://github.com/overextended/oxmysql/releases) - database driver
### > vrpex - framework

## Installation

Initially follow [installation steps](https://forum.cfx.re/t/standalone-oxmysql-lightweight-mysql-wrapper/4755120) in the database driver documentation, later on:

### > If your base for vRPEX Creative, you don't need to do this step:
#### 1. Open **vrp/cfg/base.lua**
#### 2. Change a **driver** key of the object to **oxmysql**

```lua
{
	driver = "oxmysql",
	host = "localhost",
	database = "database",
	user = "root",
	password = "password"
}
```
