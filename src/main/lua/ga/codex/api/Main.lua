local Package = {}

function Package.OnInitialize()

    LoadPackage("./Libraries/duabase.dua")
    LoadPackage("./Libraries/Logger.dua")
    LoadPackage("./Libraries/Replit-Helper.dua")


    local App = require("weblit").app
    local Database = Import("ga.codex.api.Database")()

    Import("ga.codex.api.App")(App, Database)
    

end

return Package