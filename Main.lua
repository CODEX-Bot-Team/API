_G.App = require('weblit-app')
_G.Bot = require("discordia").Client()
local Static = require('weblit-static')

App.bind(
	{
    host = "0.0.0.0",
    port = 8080
  }
)

--App.use(require('weblit-cookie'))
--App.use(require('weblit-logger'))
App.use(require('weblit-auto-headers'))
App.use(require('weblit-etag-cache'))
App.use(require('weblit-cors'))

App.route(
	{method = "GET", path = "/"},
	function (Request, Response)
    Response.code = 200
		Response.body = "Online, OK 200"
  end
)

App.route(
	{method = "GET", path = "/static/:path:"},
	Static(
		"./Static/"
	)
)

local Endpoints = {
	IsInGuild = require("./Endpoints/IsInGuild/Main.lua")
}

for i, v in pairs(Endpoints) do
	print("Starting Endpoint " .. i)
	v()
end

Bot:run("Bot " .. os.getenv("Discord_Token"))
App.start()