return function (StateMent, ...)
    p(...)
    p(StateMent)
    return StateMent:reset():bind(...):step()
end