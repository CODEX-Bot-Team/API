return function (App, Database)
    local JsonRequest = Import("ga.codex.api.Libraries.JsonRequest")

    App.route(
        {
            method = "GET",
            path = "/API/Instances"
        },
        function (Request, Response)
            Response.body = Json.encode(
                {
                    {
                        Name = "Abc",
                        Online = true
                    },
                    {
                        Name = "Def",
                        Online = true
                    }
                }
            )
            Response.code = 200
        end
    )
end