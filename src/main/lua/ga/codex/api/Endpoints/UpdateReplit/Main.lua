return function (App, Database)
    local JsonRequest = Import("ga.codex.api.Libraries.JsonRequest")

    App.route(
        {
            method = "GET",
            path = "/API/UpdateReplit"
        },
        function (Request, Response)
            Response.body = "No token"
            if not Request.query then return end
            if not Request.query.name then return end
            if not Request.query.id then return end
            p(Request.query)
        end
    )
end