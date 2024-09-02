--[[
Copyright (C) 2024 Curity AB. All rights reserved.

The contents of this file are the property of Curity AB.
You may not copy or use this file, in either source code
or executable form, except in compliance with terms
set by Curity AB.

For further information, please contact Curity AB.
]]

local cors = {}

local function array_has_value(arr, val)
    for index, value in ipairs(arr) do
        if value == val then
            return true
        end
    end
    return false
end

function cors.run(config)
    local origin = ngx.req.get_headers()['origin']
    if not (origin and array_has_value(config.origins, origin)) then
        return
    end

    local should_exit = false
    local vary = 'origin'

    ngx.header['access-control-allow-origin'] = origin
    ngx.header['access-control-allow-credentials'] = tostring(config.credentials)

    local method = ngx.req.get_method():upper()
    if method == 'OPTIONS' then
        should_exit = true

         ngx.header['access-control-allow-methods'] = 'GET,POST,PUT,PATCH,DELETE'
         ngx.header['access-control-max-age'] = config.max_age

         local request_headers = ngx.req.get_headers()['access-control-request-headers']
         if request_headers then
            ngx.header['access-control-allow-headers'] = request_headers
            vary = vary .. ',access-control-request-headers'
         end
    end

    ngx.header['vary'] = vary

    if should_exit then
        ngx.exit(204)
    end
end

return cors
