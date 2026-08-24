-- ==========================================
-- LOADER BASE64 (mau nyolong code ya? mimpi basah)
-- ==========================================

local encrypted_data = "bG9hZHN0cmluZyhnYW1lOkh0dHBHZXQoImh0dHBzOi8vcmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbS9zYXRyaWFzZXRpYXdhbjM0MzQtY29kZS9TY3JpcHQtbWVraS9yZWZzL2hlYWRzL21haW4vTWVraS1odWIubHVhIikpKCk="

local function b64decode(data)
    local b64 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    data = string.gsub(data, '[^'..b64..'=]', '')
    local pad = string.sub(data, -2)
    if pad == '==' then data = string.sub(data, 1, -3) pad = 2
    elseif pad == '=' then data = string.sub(data, 1, -2) pad = 1
    else pad = 0 end
    local res = {}
    for i = 1, #data, 4 do
        local a, b, c, d = string.byte(data, i, i+3)
        a = (string.find(b64, string.char(a), 1, true) or 2) - 1
        b = (string.find(b64, string.char(b), 1, true) or 2) - 1
        c = (string.find(b64, string.char(c), 1, true) or 2) - 1
        d = (string.find(b64, string.char(d), 1, true) or 2) - 1
        table.insert(res, string.char((a*4 + math.floor(b/16)) % 256))
        if c ~= 65 then table.insert(res, string.char((b%16*16 + math.floor(c/4)) % 256)) end
        if d ~= 65 then table.insert(res, string.char((c%4*64 + d) % 256)) end
    end
    return table.concat(res)
end

loadstring(b64decode(encrypted_data))()
