-------- SETUP LANGUAGES
lang = {}

Translate = function(key, ...)
    return lang[key] and string.format(lang[key], ...) or ("NO_TRANSLATION > " .. key)
end


--------------------------
