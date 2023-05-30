local Json = require("json")

return function()
	App.route(
		{method = "GET", path = "/isinguild/:id"},
		function (Request, Response)
			local ResponseTable = {Is = false, Reason = "Unknown"}

			local Guild = Bot:getGuild(Request.params.id)

			ResponseTable.Is = Guild ~= nil

			Response.body = Json.encode(ResponseTable)

			Response.code = 200
		end
	)
end