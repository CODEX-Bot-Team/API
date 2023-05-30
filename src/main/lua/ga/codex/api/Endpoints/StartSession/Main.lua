return function (App, Database)
    local JsonRequest = Import("ga.codex.api.Libraries.JsonRequest")
    local QueryString = require("querystring")
    local Tokens = loadstring(FS.readFileSync("./Tokens.lua"))()

    local UserDataTable = Database.table("UserData")
    local SessionTable = Database.table("Sessions")

    local function GetIpFromRequest(Request)
        return require("uv").tcp_getpeername(Request.socket)
    end

    App.route(
        {
            method = "GET",
            path = "/API/StartSession"
        },
        function (Request, Response)

            if not Request.query then return end
            if not Request.query.code then return end
            if not Request.query.url then return end

            local WebResponse, CodeData = JsonRequest(
                "POST",
                "https://discord.com/api/v8/oauth2/token",
                {
                    {'Content-Type', 'application/x-www-form-urlencoded'}
                },
                
                QueryString.stringify(
                    {
                        ["client_id"] = Tokens.ClientId,
                        ["client_secret"] = Tokens.ClientSecret,
                        ["grant_type"] = "authorization_code",

                        ["code"] = Request.query.code,
                        ["redirect_uri"] = Request.query.url
                    }
                )
                
            )

            p(CodeData)

            local UserResponse, UserData = JsonRequest(
                "GET",
                "https://discord.com/api/v8/users/@me",
                {
                    {"authorization", CodeData["token_type"] .. " " .. CodeData["access_token"]}
                }
            )

            local AuthResponse, AuthData = JsonRequest(
                "GET",
                "https://discord.com/api/v8/oauth2/@me",
                {
                    {"authorization", CodeData["token_type"] .. " " .. CodeData["access_token"]}
                }
            )

            local UserId = UserData.id

            local WriteData = {}
            UserData.flags = nil
            UserData.public_flags = nil
            UserData.TagName = UserData.username .. "#" .. UserData.discriminator
            UserData.discriminator = nil
            UserData.username = nil
            UserData.id = nil

            WriteData.DiscordData = UserData
            WriteData.id = UserId

            local New = false


            if not ({UserDataTable.get(UserId):run()})[2] then
                WriteData.New = false
            else
                New = true
                p(1)
                p(
                    UserDataTable.insert(
                        WriteData
                    ):run({ optargs = {conflict = "replace" } })
                )
            end

            local ReturnData = {
                SessionId = Request.query.code,
                SessionExpire = AuthData.expires,
                UserId = UserId,
                DiscordUser = UserData,
                DiscordAccess = {
                    AccessToken = CodeData["access_token"],
                    TokenType = CodeData["token_type"]
                },
                New = New
            }

            Response.code = 200
            Response.body = Json.encode(ReturnData)
        end
    )
end