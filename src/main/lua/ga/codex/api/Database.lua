return function ()
    local Connection = require("rethink-luvit").connect(
        {
            host = "127.0.0.1",
            port = 28015,
        }
    )

    local Found = false
    for Index, Value in pairs(({Connection.r.db_list():run()})[2][1]) do
        if Value == "Codex" then
            Found = true
            break
        end
    end
    if Found == false then
        Connection.r.db_create("Codex"):run()
    end
    
    local Database = Connection.r.db("Codex")


    local UserData = false
    local Sessions = false
    local Instances = false

    for Index, Value in pairs( ( { Database.table_list():run() } )[2][1] ) do
        if Value == "UserData" then
            UserData = true
        end
        if Value == "Sessions" then
            Sessions = true
        end
        if Value == "Instances" then
            Instances = true
        end
    end
    
    if UserData == false then
        Database.table_create("UserData"):run()
    end
    if Sessions == false then
        Database.table_create("Sessions"):run()
    end
    if Instances == false then
        Database.table_create("Instances"):run()
    end

    return Database
end