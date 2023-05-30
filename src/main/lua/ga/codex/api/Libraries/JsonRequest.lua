return function (...)
    local WebRequest = require("coro-http").request
    
    local Response, Body = WebRequest(...)

    return Response, Json.decode(Body)
end