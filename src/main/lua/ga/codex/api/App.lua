return function (App, Database)

    local Endpoints = Import("ga.codex.api.Endpoints.List")

    App.bind({
        host = "0.0.0.0",
        port = 5343
    })

    App.use(require("weblit")["auto-headers"])
    App.use(require("weblit-cors"))


    App.route(
        {
            method = "GET",
            path = "/"
        },
        function (Request, Response)
            Response.code = 200
            Response.body = Json.encode("OwO Whats this?")
        end
    )

    for Index, Endpoint in pairs(Endpoints) do
        Import(Endpoint)(App, Database)
    end
    
    App.start()
end