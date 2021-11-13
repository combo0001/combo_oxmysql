fx_version "adamant"
games {"gta5"}

description "A middleware for FiveM servers with vRPEX framework, a trial version aimed at vRP."

dependencies{
  "vrp",
  "ghmattimysql"
}

-- server scripts
server_scripts{ 
  "@vrp/lib/utils.lua",
  "init.lua"
}
