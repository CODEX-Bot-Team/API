return {

    InfoVersion = 1, -- Dont touch this

    ID = "codexapi", -- A unique id 
    Version = "1.0.0", -- The package version

    Name = "Codex API", -- The name of the project, can use spaces
    Description = "API for Codex", -- Description

    Author = {
        Developers = {
            "Codex Team",
            "CoreByte"
        },
        Contributors = {}
    },

    Dependencies = {
        Luvit = {
            "creationix/weblit",
            "creationix/coro-http",
            "luvit/secure-socket",
            "luvit/querystring",
            
            "truemedian/rethink-luvit"
        },
        Dua = {}
    },

    Contact = {
        Website = "http://codex-bot.ga", -- Homepage
        Source = "https://github.com/codex-bot-team", -- Github repro
        Socials = {}
    },

    Entrypoints = {
        Main = "ga.codex.api.Main"
    }

}
