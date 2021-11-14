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

## Necessary modifications to work, if you left GHMattiMySQL made in C# (.dll)
### It is not necessary to make this change in the Creative bases.
### 1. Open **vrp/base.lua**.
### 2. In the declared function vRP.getUserIdByIdentifiers, change the order of receipts of the vRP/create_users query.
### 3. Change this if the function is equivalent, the query may be different, so if it's not the default query, only change it if you understand what you're doing.

```lua
vRP.prepare("vRP/create_user","INSERT INTO vrp_users(whitelisted,banned) VALUES(false,false); SELECT LAST_INSERT_ID() AS id")

function vRP.getUserIdByIdentifiers(ids)
	if ids and #ids then
		for i=1,#ids do
			if (string.find(ids[i],"ip:") == nil) then
				local rows = vRP.query("vRP/userid_byidentifier",{ identifier = ids[i] })
				if #rows > 0 then
					return rows[1].user_id
				end
			end
		end

		-- BEFORE ---> local rows,affected = vRP.query("vRP/create_user",{})

		local affected, rows = vRP.query("vRP/create_user",{})
		-- AFTER ^

		if #rows > 0 then
			local user_id = rows[1].id
			for l,w in pairs(ids) do
				if (string.find(w,"ip:") == nil) then
					vRP.execute("vRP/add_identifier",{ user_id = user_id, identifier = w })
				end
			end
			return user_id
		end
	end
end
```

## Based on the driver made by [ImagicTheCat](https://github.com/ImagicTheCat)
