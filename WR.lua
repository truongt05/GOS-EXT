--[[
1. dofile('changelog.lua')
2. dofile('activeModule.lua'):
* commonLib.lua
* menuLoad.lua
* callbacks.lua
* prediction.lua
* Lucian.lua]]

if _G.WR_COMMON_LOADED then
    print("WR is already loaded, please unload other WR AIO script and try again !")
    return
end
_G.WR_COMMON_LOADED = true

local LoadCallbacks = {}

local currentData = {
    Champions = {
        Ashe = {
            Version = 1.04,
            Changelog = "Improved Ashe AA Reset",
        },
        Blitzcrank = {
            Version = 1.03,
            Changelog = "Fixed bug on R KS",
        },
        Corki = {
            Version = 1.05,
            Changelog = "OnDash Typo Fix",
        },
        Darius = {
            Version = 1.04,
            Changelog = "Improved Dmg Calculation",
        },
        Draven = {
            Version = 1.03,
            Changelog = "Draven Initial Release",
        },
        Ezreal = {
            Version = 1.03,
            Changelog = "Ezreal LastHit Fix",
        },
        Jax = {
            Version = 1.02,
            Changelog = "Improved Jax AA Reset",
        },
        Jhin = {
            Version = 1.02,
            Changelog = "Jhin Initial Release",
        },
        Kalista = {
            Version = 1.02,
            Changelog = "Kalista Initial Release",
        },
        Lucian = {
            Version = 1.05,
            Changelog = "Improved Dmg Calculation",
        },
        Olaf = {
            Version = 1.01,
            Changelog = "Improved Dmg Calculation",
        },
        Riven = {
            Version = 1.05,
            Changelog = "Riven Dmg Calc Update",
        },
        Sion = {
            Version = 1.03,
            Changelog = "Sion Initial Release",
        },
        Syndra = {
            Version = 1.02,
            Changelog = "Improved Dmg Calculation",
        },
        Talon = {
            Version = 1.01,
            Changelog = "Talon Initial Release",
        },
        Teemo = {
            Version = 1.02,
            Changelog = "Teemo Initial Release",
        },
        Thresh = {
            Version = 1.00,
            Changelog = "Thresh Initial Release",
        },
        TwistedFate = {
            Version = 1.02,
            Changelog = "TF Initial Release",
        },
        Twitch = {
            Version = 1.04,
            Changelog = "Improved Dmg Calculation",
        },
        Varus = {
            Version = 1.01,
            Changelog = "Varus Initial Release",
        },
        Vayne = {
            Version = 1.04,
            Changelog = "Improved Vayne AA Reset",
        },
        Vladimir = {
            Version = 1.06,
            Changelog = "Vladimir Initial Release",
        },
        Xayah = {
            Version = 1.00,
            Changelog = "Xayah Initial Release",
        },
    },
    Loader = {
        Version = 1.05,
    },
    Dependencies = {
        commonLib = {
            Version = 1.15,
        },
        prediction = {
            Version = 1.01,
        },
        changelog = {
            Version = 1.01,
        },
        callbacks = {
            Version = 1.01,
        },
        menuLoad = {
            Version = 1.04,
        },
    },
    Utilities = {
        baseult = {
            Version = 0,
        },
        evade = {
            Version = 0,
        },
        tracker = {
            Version = 0,
        },
        orbwalker = {
            Version = 0,
        },
    },
    Core = {
        Version = 1.01,
        Changelog =
        "Welcome to Project WinRate - The Most Advanced Script Ever on EXT!\n\n" ..
        "We work to deliver the best scripting experience possible through our\n" ..
        "solid developers experience and HQ codebase, where creativity reigns\n" ..
        "over most limitations brought by an External Platform. \n\n" ..
        "Thanks to the seamless implementation of our AutoUpdate system we\n" ..
        "can ensure you're always up to date without any impact on your game\n" ..
        "experience!\n\n\n\n\n\n\n\n" ..
        "                                 If you want to support us, head to the forums where you can upvote\n" ..
        "                                 the thread, leave a nice comment or even make a Donation. "
        ,
    },
}

if currentData.Champions[myHero.charName] == nil then
    print("[WR AIO]: " .. myHero.charName .. ' is not supported !')
    return
end

local LogoSpirites, HeroSpirites
do
    local function Base64Decode(data)
        local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
        data = string.gsub(data, '[^'..b..'=]', '')
        return (data:gsub('.', function(x)
            if (x == '=') then return '' end
            local r, f = '', (b:find(x) - 1)
            for i = 6, 1, -1 do r = r..(f % 2 ^ i - f % 2 ^ (i - 1) > 0 and '1' or '0') end
return r;
        end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
            if (#x ~= 8) then return '' end
            local c = 0
            for i = 1, 8 do c = c + (x:sub(i, i) == '1' and 2 ^ (8 - i) or 0) end
return string.char(c)
        end))
    end
    
    local function Save(path, str)
        path = SPRITE_PATH .. path
        if FileExist(path) then return end
        local output = io.open(path, 'wb')
        output:write(Base64Decode(str))
        output:close()
    end
    
    local name = myHero.charName:lower()

    LogoSpirites = {'/WR__LogoMain.png', '/WR__LogoBlack.png', '/WR__LogoStars.png'}
    HeroSpirites = {'/WR_' .. name .. '0.png', '/WR_' .. name .. '1.png', '/WR_' .. name .. '2.png', '/WR_' .. name .. '3.png', '/WR_' .. name .. '.png'}
    
    local Spirites = {
        LogoBlack = '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',
        LogoMain = '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',
        LogoStars = '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',
        ashe = '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',
        ashe0 = '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',
        ashe1 = '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',
        ashe2 = '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',
        ashe3 = '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',
        blitzcrank = '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',
        blitzcrank0 = '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',
        blitzcrank1 = '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',
        blitzcrank2 = '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',
        blitzcrank3 = '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',
        corki = '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',
        corki0 = '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',
        corki1 = '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',
        corki2 = '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',
        corki3 = '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',
        darius = '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',
        darius0 = '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',
        darius1 = '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',
        darius2 = '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',
        darius3 = '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',
        draven = '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',
        draven0 = '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',
        draven1 = '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',
        draven2 = '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',
        draven3 = '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',
        ezreal = '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',
        ezreal0 = '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',
        ezreal1 = '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',
        ezreal2 = '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',
        ezreal3 = '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',
        jax = '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',
        jax0 = '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',
        jax1 = 'iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAbrSURBVEhLnZRbTJvnHcY/bGN/NjbxAWxjO8Y2xmB8CBDAgHE4B3A4E0JCORWWEAVIQkjSQUhoA01DurKsKTm1ybpUW5TMSZZmS9pO21ot2rS7StMW9WKalO2imqbdbze/vZBVu+guqn3So++9eN//8/wPz18S3wmB1P8LpVpKZZoFMqWUUadIGdTqlFpWpxQq5Vd3pI8E+KZQqRVodSp0OgnXViW1jWZGJ1wMj+XSu9tJPG7Gas9A1qlJS9t8s8nytUD/C7JWSbZNRa5bSen2DGYXwiydL2P/9HY6e0KUx1xUJrKpT5px5KhRqzfffTMClULCalPi9WmIlujoHd5Ksi9IRWWE4u0xGpvqSSaT+PM9xOr1BIJaVBrFxtuvE6RtQKS3meKLNFEpJRxOJeGolv7hLPKKMnB782lp66R/YJRjx+c4/+Y5cj15dA9lU1yuQyV/RbARRChUiCBKgY1gKtV/oRRQpEtk5ajwh2UGXrYQ27EFo9lIe3cHBw/v59jiJL1726jaoRdnJ/6QjM6oEgQKKZW2EUiko9GkCYizLJG+AdFIvVmFJkPahCFLydY8DbEaLYcXchg9LEpUW0BdcyWxRITqej9rN8N07snE5lVjFoIkSSWl0kVQWafEsEWFrBckehFwAwahemuGuKjBZFdhdWsEgUxJmZqu3VruPu1i7HiZ6I0Jh8vE7OkGbjysJlYrYxNC7H61qIyYY7VQqtlUq8BoS0drUaCzpKG3SFhsCtwBoUgE9wRkfCL1eJ2Wk0tulq5X49+WRbI0yr76atFsO5fv1TM45cIbVuIqkpFUWimlMyrIsCiRzRLZuWrBriPTJmF2KcjJEwSFerxFJnz5MmXVBg7MWjl90U8wYqbAa2aoqZzF4X66qirEVFm59EGCpt1ZOENKJFk4MEMoNjplzMI4FreEs0BLTr4Gm0+JO6jCIZSHKqwUFWdQVWdgctZOIJRJU0WIlZmXOH60l7Uzh3h0c5mpsWZ2drtY/G6UWKsByZAlpbbYJUwOMYb5CnIjauyBNDwRGW9UR16xhoIymdJaA20DuTR3WdjVZyLszmFANLd/tJVQVym+QhsHDrQxe7ybuhYfAxNOTr0VEiWSpZTZqcJZJJpSlIa3XE1BlZbcEhWlTVuIJU0kOvViYrJYfifK7FIAV76W8ZoqdlRuw9e6neCuMgIHkrgaQuQ2RhnfV0FcOHrlcukLH2zsF0eBjpBQWRhXU5hIpyypJd6tp33UyfBhO9++4KBv3EZzh5v8oIXJnTVEiwM4d0TwlOZT3BXDE/fjrI8w1FzC/pFihg75/2M04dTMTDWhMlHXQQdtExaaRgzsOmBkesXB+v0wjQNmSqIOpoYamBtPcqQnSX1pgKG2Gho6G0nubWZwpIXBZCV9ySirr/bTNyxKtEkgnGwUhnJ7VLT32Ti2HGHhcpBT7+Wx+iMPY/NuxqfLGBwsZHGqiZVj/bz12iSNosnLBwe4vnqUtXOHuLgyycG+aiZejnPuXA8nlna8IJC1afj9Mu3tVno6nEyMFjK3JDbl5TAjJ5wkx+28craea1f2MT6xjWOTddy9e4Zzi6NMCdXrl6Z4fWEvE/2VtLf4+d7bY7x9ZYh3bvW+IDCblDS32jg6U8abp2p5cjXJnUvNHJksZ/ViC2fXq3lp3sHM+RLOr7dzdD7O3MlGzl8YErsoSFmlka59QeaWW5ieT7B4oYWFtUYWbkTEFIlVkZWdTnNbNjNzAXxuPeVeFwMNBZzeX8HSkSquXGnjxk87uPCDBGdvxrn2sz1cvNXJBz+ZYX65ibFJH0P7i+gaDjB+MsrCpRreeL+ZS/d2Imm1ipTRnI5brII9I1baOuzkGq3YDSYKHBZqgna643m8cryaH37Wz7uftnDhXi3rT1p57+Nefv75Au8/2cO1R+1c/bCDB7+ZFP9eVm83cP1hD5IxU5tKl5VkiOUWT8iMjDtIhCN0b6tjW04BZjkTo0bGlalnZ42Pd8Wj+8/2ce23rax/Wset33Vw//cDvPaJh8UP/Xz/l0N850ETtz/fy5mLSbEqZDmVrk7HbEqjLmGjJZHPcLyPCneYrVushKxeInYPHmM2WdoMXFl65l9t4Fd/muaT5zP8+I8j3Hs2xhtPi1h9GuXjPx/m0RfjXH3Qw507k0hKpSplNGjJy9MSC3tojJRSaPeSYTQSsIvVkFdBuaOQUJYwmMmKWavHqNDyrZE4v3h2gi/+tcbTL8/w0fNpHv/lEL8W58d/mOPxZye5uja4OUVPDLp0ykM+it1BHJk5mHUGvMXF5Hr9JJxRwtl+CgWBX2RUYHYSsOSKsmVTGQ5w4+YEX/7zLn/nEc+5zd94yF//cY+VhT3ICol/A1RgoSZ3UfnNAAAAAElFTkSuQmCC',
        jax2 = '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',
        jax3 = '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',
        jhin = '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',
        jhin0 = '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',
        jhin1 = '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',
        jhin2 = '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',
        jhin3 = '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',
        kalista = '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',
        kalista0 = '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',
        kalista1 = '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',
        kalista2 = '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',
        kalista3 = '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',
        lucian = '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',
        lucian0 = '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',
        lucian1 = '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',
        lucian2 = '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',
        lucian3 = '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',
        olaf = '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',
        olaf0 = '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',
        olaf1 = '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',
        olaf2 = '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',
        olaf3 = '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',
        riven = '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',
        riven0 = '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',
        riven1 = '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',
        riven2 = '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',
        riven3 = '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',
        sion = 'iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAbNSURBVEhLhZZbbFxXGYVPPDd7Zjxn7vfbmfvVnpvHHnscjy9jx64ndmzHjp1LnchViCLauDShtFSIpFVUCdGiorpFfakCD6AKqIQQ6kuDkEolXngDCbUghHjigQISEip8/B4HqTwgHpb2Ppp91tr/v9beZxRF0e8piuHo/0P/aBwQKJ95/s/4v6AYHgwbLMSsah+aIHGM4RMkBbEhM5rFTHhQxaYYOduZomS1ER8cljV2EjZZI+uixxzH64/nwzaG9GaOBY6OSTfDQTb6CPTHzajMoxHWQ16uNZpsN+eZT9Q5HGnxq9e+ybcP9tlxu9j0OthORjmrRVmOBQRhHovHWIpEcA9ZTwRSInA+GmY7GhVE2I5FuBAX8qCPp+d73Fi7QSM7y0iwzlSwxl6ixntP3uHjt97g3nSTNaeNjaTGajwk5EF6WoSl8GcEMlLShXicXVHePR5lN1thH892N3lm8zbl8AQ53yiNyBiTWouKv0zFGOKt9cv84+e/4LWNc+wMDbKlNzDlsLEq76/EYv8tcFGLs6fF2BOB8yEfz5ye5+7F5+nkF4W8QjU+xZnqGr36GouFOcYCZWaNQX5//Tk+/ekHvG0y8bKisCsoGQ3MBHz4htQTgbyq8ngiymURuCTl7Ub9fHF1n161R9FfYyzZYWlim525A3Y6V9ma2KJX7rLsLfLw+iF88jc+7izwIyF/+5SRSwM6RnU6bAP6E4GC6uAgFeNA+ngtGeNqKs7WaJfRQJ20p0wz36U3e5HzC/ucn7vMXucyV5f22c61+eD+K/Dpv/jT60d8y6zwJfHhC7LJJ0JBvAbTiUBJdXEzo3EzrXEjHedz2SSdeJWMo0DWP8pEeYnJygrd8Q16Usn62Dq70+fpJcf54dpN+N0f+ecvP+LDvWvczriEI8wl2XDIbD8RGHW4OMxpHGY1bmXi3JKxExmhGhkn569SlOQ0svNMlVdpZ+boFhbZEJHHMlN8NdXmrz9+H975GX++9RXenSnyeiPPtUSYkKXvgf6o7nByRwTu5AWFJDezOTaEbHviEhNCnPFUSNilGleJSnCMJTF6t7XJC+UtzuojvBKt8Pd33+OT+1/nHeH5cH+DO1JFUOIvAspR0+Xk2WKO51ozIpTiyfEV5pMztCMtruTO0s2uSFSbUkm1L1KVuO4E2ryodtmTCvcdOX5y8Hn+8t0HvCRGf+/MMj9YnyWo73ugPxpXbbzcO8fjjTnuyg72M3nGYlM0vXVuD7XYdjVJO/OUY01a4kfRW6MTanAu12E3v8BasMHzoRJ/ePqQu54Y1/1p3n9ij5jukcCcx8MLq1fIWgK8OprrV9EMTzJbXJWW1JkI1CSuVRYnd1hqX2SyvNyvpCnE7XCVtjfHjjPFr28ccq/UYUYZ5NXuJBmb7aRFZxNpnprZZVAxc7+U4c3xIjujC6QDVQKWOGkhKqVnqKWnqaZmSQn5dKZDPdCgmz5NyexlVo3wYnGaDVWjIQJ3akVqLveJwFoyx64YpygWrvo1vt+ucmlskagzTdZbkQR1yMbGCdtzhK1ZUu4K6+0dItYEDYlxwmCnY5I7yBBiyl+gG5QUZYpETmKqHPUiMaquolTgIi2p+EaxyUG9i83gYqG8Qi3VIu4ukZBTnZBElcT8mjaF1+ij7M6TlY3UTH7Kx8+2MPdWz3GQn8Zlch4LDBxdjAX5cmWcvLOAatZIG+PUHGlcBg/NWIuoXSOmphnPzNMudin764TVDE6dE1VnIesbwa13ElAcZIZ93N3Yltt1Ateg61hAf3QhGuA3vUkedupCHMesCzB4yiEtyuEYcJKNNtDcBRxmF15rhIglTTpUwym9Nyl6fEYnoQEL7gErdsXEbCTPaUmVKq17VEGEj840+O3OIldGJzAqNhKWMAk1hl2n4rYEcUgLfAYHSTWEbzCO0+DDobeSVwMkdXacYqxDGUITsZzRS8ESw6rvH7SBo8tyez7cWOM7h19judKR3pvw64VMPEibT4hdAy7iQz6CMk/Z44z4UtQ9GgWTm5TBiV/nICYepKxBsoKCTcNm6rdIOVpKjXJr5Sl2Tt9kXg5PetiNR28nJMgYVDImj5D4iepc+CTKmpiXtUdoaWM0EuNUtCaNZEvOxzwrp7fYmtlio3UOvz164kHYkaQgR38kMiMJqeNXhokb3dJ/K45TZjFPFWKb/CEIMpVp06kssjDWk2tcPqOJlsR4mmZ5jk5tmd74Gqvy22ypi3XQ0Rd4YBCDhge9OIXANuTBLDs3DgxjOobOhqE/WvA6IoR8adzig2r2YZEW2MweXGoY53BA3vdilyC4LD48w34MOjP/BlHSY+ay14XxAAAAAElFTkSuQmCC',
        sion0 = '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',
        sion1 = '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',
        sion2 = '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',
        sion3 = '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',
        syndra = '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',
        syndra0 = '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',
        syndra1 = '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',
        syndra2 = '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',
        syndra3 = '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',
        talon = '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',
        talon0 = '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',
        talon1 = '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',
        talon2 = 'iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAeZSURBVEhLHZb7c5TlFcc3yWb33Uuy794vSTabZHPdsLnuJptskiWQCyEkKyHXTcgFJCAgohCoAipGEAHFoqAwKOLQEfqi1hsytl6KRWurndbpOO3Y2tYf2k77Q/+DT0/44czzzp5nv9/nfJ/vOe+rs+TG95v1rVqePqbl58Q0NadVU/Vtmmrokkhp+UqPpiq9Ev2aXRmUNSW/r+xJag7Jewzdmmtln/zPnNMkOHGJlVUiJ67pLPrYBzZDJzZjEruyBrupX2IQu3UUR94kTtsk9vwM9rxp3JYpvOY0HvMATtM6nJYBPPnD+PI34jH2oOa0oRrbBCuBzdCCmtuGTtUnNLshhSokqqkX1ZLGaZ/F7dmPN3AMv/8ErtAJ3NU/pjB8Gr/3IF7LmEQar1WAbSMUFO6lvOMsoegSqtIuWPG7YTckhEAksFuGBXgA1boBNX8Ku3ofDscSDvthXEWnsEXOkt96GXv3mwTX/4KCqos48+ZwmEbwuLdS3HIGf8dzWAu34nCPYTcKiZKQfNcKQa+2IoeaJ4mCgziiL+OMvYZ7/Xt4Nr6LZ+gGlv53sY7fxNR3FXfn61Qu/I6SlqsEmo/jjhzG6tiKNbwX16qDONU0LmMXLqVTZEyhs5s3aS7bLE7vblzh87jr3sAfu4Fv9W/xzv2A69h/8Zz+DsvCR5hn30RX/gRKx4s0PPMtlaMvkGPsQ609TknrWSoc2yk09t4F9yqrcZu6hSAvo7mKjuAMn8Ve9gKu1W/hT/+cwPzvCR7+C97l/2Cd/wrHvs/I7T1PsOs61YlXcUX2yfNRvOteJNzxOv7cMXymISrNmyhRBu8SBEx9IlHwoGaPXcJRcwlX19u4N36Jo/9r7OlvcW77noKT/8S//A3G1E/IrjpEm8h27ua/iDYtkeWYo3T+PYo9j1ClTBMwbyAol99knKZUSO4SmIeua9bNt1F73seZeBt79TtYu/9A/sz3qPf9gHXhO8zrb6GrPoNO2Uw4cYrp+esMNS/hqj1E5ZZbcn8ZSuX0DZIvMN9DrXGMRsMkhab16AwP3tGsU5+ihs+hVkolEx9TsPBLgmOfEBq7Q2j7b2h59a/ET33BwNxVIsmzOMUMqkjhaztJZPEWAaP0hnENZbI2K7NCtom4cYoa0yg6085faY7aa9hDp3EOXiPQeIES30nKfEcJB5+jrPEtmg99w4abf+fxF//I9GNfYi0+SI4yStk9F1jz2r/xlR8RkpXekNObpmlUZqiRfMI0g8418bEWKP0p7qpzBMtPUGbfTUn+HGF1kSrPAap8T9I4c4vpT/7H8P5PMRUfIFcsrVgmUdwbKR8/Q9OhX9N474dUFD1KiX6QmNxBvTFDTMh0at01zVWjEag4TlCAi5QeiozdhGRchC3jVJq2UJu4RGrpE5I7rtG68zoWc4Y8r5xOF5dowlr0ENX3fkDjztvUlD9OlWGMduMMUWVKbFr9iuZue52Qa1HAN1AgMyaorKNcnmuMQ1Rlp4n2XBYrvkRB6mky7/1AWXyZQPQw2fp+srJlHNwlGpNufpmK7svUenfRlpuh2SCH8Ky7pgUbzlNkmqLQPEJQXFAiI6BaNKwXXSOGWeo3/Yy1D9zGu/oKyWN3qN34jABKl+rS5Mr+hq3LWH0D6PRpbLFlYn03SOgmSRgyUsH+L7RQxVGKjdIgAhwWB1QpE9RKtBimiJu20zL1PpGM+L3tZSIdl+h89BZlqYeFYBiPZw+puecxB0bwdx0kuvcOrbGLdGZPkpTe0DmOfK2VlByi1JCmQhlhlQDHRbukYZq1+s2sNe+kevANitZfJ158nEZxWLTjCl1HPqd2/Aqlq55i/fgFQsMnaFm+TbD0JVqV++lXFugzbRWJ5j/UQpETVOg3EDGO0Jw7TjJ3im59hrRujiHbA6jVR/GHHiOTfT+bsnaQUvZR7TtL1cRnJJ/6ioL2k7jKHyC67QbeyCvUm/aSNi4yZNohBKnLWlHT86L1MA2GUbmcFfAphrPm6cmfoT3xI0rq92DObmcmaxezWfczkbOdQcMu6mxHiY19QN2ud1DsWwjPXKDn6j9YVfQIAzmLDBt3ofN2CEHjeVZZJ0XzMVL6aTZkz9PhnqCmYZK2oSfpTD+N05MkkpNkj+5B7s3eI9XsvEsSty5RN7rynngWo7xLht79G6ljn9Nu2cOEfg86f/dVrbjxIg32RdaKtfqNC0QDQ5TXj9Lc/TCJ3scJhdbhdyXwBdpZ45pib/YSi1kHmM1+kF7TfuKe83Q99DE10xdl3Oyk/8qf6B24xGbdbnQlJYe1cM2zNNt20JO7QFVgHaW1w9REpyXmCJXfg0eNEQr2EInKnKlMk0wuESubl8scZEi5jwHDw3R4lll9+s9UZC7jqNhN8+A55nLFaTV5s1pt4AAxGRFrDAtUeHsoLFxNsbuNIrWZotAghf4UPlsTpcE+6uLbqIhO4ZaKbM4Gyu1rGBW5RrIfocf1JM0zMvJ7z+FoeIpx9WmZwkrmZjxPOs+6m17jNlZZ+vALmF9tJGAXAtE+XNxPffMWyqtH8XnkC8RUj9fWhicvLl8djVTldzOWu08M8JBUc4DuOo1k50cMuS7wf1Ix4ILf96M9AAAAAElFTkSuQmCC',
        talon3 = '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',
        teemo = 'iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAdXSURBVEhLXZYJUFTnHcBXYDn25O19L8sewAJ7wALLDYJ4gAJRQIiIKAhVkxKlYjX1JpKqjY4iMTWaauox6eiMR1tNYp0mttMZ6njVThqPVtM4jbWdydTWSRt/fbBxptM385/33ve+//f7/uf3JBJJQodEIh2LScI38v/vkm/uSaJMjMf9jzyf81ye6z3XkUiPTJHKSVEJKDQ6VFo9akGHQqVBa7Sh0adhNGWh0diRJakxyBV4U5VELGaK3C50BgNKUSdVp0OtN6DSCOQ7tCwoySDHYWTCgjGNOJjuc2HL9JIW9OPO8eL0evAFijC6StBbIkTMbnp9ZnqCdlZFc1mUXcLKqjLeHppPRXWIUGEOvlAmXZU+bq6p4emhRaydFY4BitP17OkuY/d3msjMD2D2OCdhJrsPSbxaFBl9Dj2dIvQnB7by9+vvs3ruK2yPBvn89EZaSzy8NN3Lu32FfNyUy9WKIHeaomyuzI4BfHoVh5cUcO1gF68ONmN0O7Fmp5PmtePUyuiIWDnfXMRYRwd/+/VZ7m7fxlh5BR/609hZGUSvTqAuU87O+T5+sTjMqy4doxlWhmv9EwDpmEunpLvYxqHefN7f1Mi+9iJezTaTZ0qlPWyhMVvPwiwbF+ureFd0z1qXhk6rktlmBWFTMuUBLfWVVqqiOtrK9GxsyuJ4II3hYk/MgpBo/qo6N21hAy+VuxnuKOB3NV7qJBK0qiR8hiSq/EbWz8pmUUBBY7HAjFKNuKBAXUSUvFRmFmtYOjeLlfNzubC5mU/bC1hfMQmQjmllKdRk6mgKmGmvC7G/r5GLVT6601QE0hQ0ZKppyNFS41HityaRY08hw5iMVpGAS0jGLz5nOlMoD6vprrUyfmApz26eoGdWZAKQNCYolbgNCvLSDPTNb+BMdwPLQlaiATUz/EkU2BLRy+OwihbNUkrpd2spVkmpTZWw0BbPgCeBFksiOUIKRS41W6qNPHpvgP4XKmIuUor5nx/JoCTbweKSEKsLfUTcakq8Kdh18WjjpjA7OY4Rl4phj0CzOYVuu4QFVgmt4n1XmZyj0wTWBcRvYtxaxXn7pxtZVemKAVw2I51lforNAvUBK9PCNvLdcjLMMrKVybQZ5OwKWrklpvHBGTl8PzuBZT4pm4rU7K0xMxRScbBOy/m+Ui6vmc+RtlKOt+XTGTTFYuDRqPEnJFJgFUS/Bch3KsgwybAlJVAjxNOkieP2juXw8AJcfYs7KwoYiyq53uXldl8mF5vExV/0c/+d1Tw+tYVPdvRyZWMbg2JqTwL8Og31eoHeaBa1YSc+rRRDYhxlqik0GSWcnKqB+5eIXX+GCyN8saaWayLo+spi7u1Zwhcf7OHx5X3cO76ej9Z1cK5/Bn3TQzEXpZkN9ItVt2pmhExxx1ZZPBVCHHPNUxiptHGt3cuzzz/m689ucWPzcv51ZgeMH+Pp+HGe3P2ALx9e4tHVIzw4s4XLW7s49WI5F4fmsLC+IAYQBDEFxfJeOD2ITirBlSJlmTuZ4UIV//5uKRx6ma/ujjPqsrJVLDJObOXh4Q08+vle/vHbY/x1/CB/OrmBj77XztnFVVzojXKir4bW0twYwGQ0UFnqp6U2hJAUR5FGxmiViw87Azwd7YG/jPM1X3L73BhPRhbx2caFXB7p4/753Tw4vZ0ru1ZwdsUcRidqqMzNDwu87C7IZY7HGouBxaAlGnHRWhdBr0ik0a7k8kATT07/AB6Pw39uwz9v8ezGKW6+tpgbb63jj2d3cWX/IOdWt/JOezm7p+bQJzbNmQnx9OgMDBUFmZWbHrPAYtQQykujvlrMIJ+RqRYZ9/cNwJX34A/n4N7P4JNzPLn4NnePbeH6vlX8alsPP13dwuGOUrZVZVBtTiU/IYUerYVenZXudAfTxGY4aYHHpKVZbLlBERLM91CVY+bB0fXwywN8deYNuPQmTy+M8vu9A1xaO4+z36rhZFclx9pLeL3MR6NVS12SirWCg28LVgbsaaybFqI4d7LQpGNO0UUzi+wUR71k5aUzry7Mp0c2cVt0xZ09g9wcWcpvhlrE4NVypqOEHzcEWC9uaIFDR6dCw3qlg51GPysF0QtyOYu8JvYuncrUQm8MYNIKRMXeU5hvIZQr8Mq8KIeXz2XD7CjDzaXsb63kjboABxpyGIo4aTFraVNp6ZMb2WrM5E1HmMFUFxlxiTiT4qm0KlhR5qVMPBNiAJ2a0gIb1cUWqgsMTCuy0VyezoyIBbdMzgs6J8EUFXVaE9XJKpaorOyzBjjqyOM1m5/lznReFhfrD4rntF2FUy0lQ2zzJllyDGCf6EGVbuaKqVkfNVNXaqerwUd9iZ18QcM8lZNalYWVtgCDRjcbjR62WbPpFiz0e+xsbynkR0urWJBvEw+gJLGnyaiyq3FrVZOAI0rxT8Ft0+EWM8FlVpPhSCU3TYPfqcWlS8WdnEq6TIVXnkpYaSBbriGQoiRTJWd6rpOGcDq5on7QZSHgMOBQyMRWI0WVmMJ/ATssBEDVtS2DAAAAAElFTkSuQmCC',
        teemo0 = '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',
        teemo1 = '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',
        teemo2 = 'iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAfaSURBVEhLNZV7VJR1HsZnW3fTTBhghrlfYAaGGWZgLgwOc2cYYWC4iYiEQgJKXvCGWGJp3jKviaW4VqaladibrVAbWWG6aialZqWni6e23TrW5ta2ndOes3vOZ193z/7x/PP+8ft8n+/7nOcrGT9esSLlLp0gSzEJihSLKKugknoEY1pUMEnLBO0dMcEkiwhZ0qhQqA8K0ahXsKSVC1pJraCWVAo6SUIw/rpcMI4rE2SSiFCe8ArH3gwKe48VCyXeiCCRTtSOZEpzUKfbRTlEuTDKolhkSUwpSfzOUkLhIDZDjFipD2taAr2kBqc+hiU1gfGOalFJNL8qJxYMcexknNcuhWmoDZB9ZxJJ+u3JM2xoMqxo0vPRy7zkKqrJVzZiSq9k5r0+ip0RZnVNxqmNYJoQY94yOysHNHSvzsGVFcZlK6F1jpvBoQBnrwXo2ZKPalwAo6QCSabUImhl+WhktyF2zIoITk0LXkMbufJKVOMjTK2P8MjWMBkS8fG2EFe/SHDuSoz9J2x0PGBmw04rx19x8/JrLvoGDNyzSo0vVIA334tEJbUKermD2xCtrIA8RTmRvDbCOe2ikwTpkjCNUyMMHAjis/jYujHKtz/M5/tbSxg54+fBxw28eyHM6GgxzxzNYfSsl6WPaanpNJKYUvA/gEHuRCezo03z4DLHqYs2EjF1YM6sJFfvp3KKhz0nrCxb6mDZ3AB//UcPN/7czpHhbPY8r+WlkQKG3/Dy1hkv71/ysWafjs5VWkLuYiRqqU0wylzoM5zoU0PUVMRpq2khrJ+HPq2U2YtyOP3BNAZPRcXvHpaL/+L6d42cuepn9N1ijp/MZedhLQMvGNh71Mj2A0pW702nIp5PJFL0f4Abfbobc1qSnp4E99XNJ6zuRowqcxfncuuXPk6d6yButbF2VZRL39Rx8dM4X99cyNtjPobPehi7Fue5oRzW7LmLvh2pBIvyaVqadxvgEAGTyU734ZJ3kMxfwYzcxwipFmGR1tI03cH1m00cPhTEpTSzcV0DP/97D5/cvJfPv1jAy3/08NalED/92M3Qabv4+Dh6H5WxfLuGxh6rCEjzCOaMGCZpKcWZc5mqGqBZvZ86EeQzNpMMuHj/T+Xs3u7DeLeKDavaGTzcx+XLO/n+p+2ceM/ByJifCx9WcGDYyLanMhkYMjN7eSGF9igSY1pQsMlqyZPWUKfaSrfuJG05e3lkSz3Jgi5C2SFGz1exdmEIU6qWRJGbzulJrlw+wsWr9/P6hXIufTKNK59V8/71OL9/28KcHgc2m+i4IILELFaCWz6LorR2Futfoc94hi7rUyya/gDNefvw6Wu5v30KsytLUN8ppy4U5NTrB3ho6XSqAtksW+DhxlftnL8a5+CQlaWrc3EVeXC6J5OfE0Tils0UosoVJOUPs8U0xjrTWWZrX6Bh/BBrPBeoKmhmZjDGFIcX5SQ5A7sWsG39TILWDBbN8XPo8HT6d8VZt8lP/yEfde12CkWXOmkJit+GkZRkzhOq1duZo36G3Tkfs8l0kfuUr9CtOcnb9/yNaUVNzIlWkafKprrMxrZ1jTRX+qkOFHN/r5/Nj1axfn0pwkg5w2MRki0uMseFkI27DRBXFFWtFGZoD7Em60325X3EVsMYO42f8VLNNbqKenGpjEQsdnJ0Kko8Rqa4g8yt7OShWX0sruulLfQAdYU9tNbW01gTRSONobgzimpCWFQZkoR2o3CfcYgnLO9xMPdjBj2fMtR6laSlEe2kTOYFwziN2WLLKuiM9bCt+Xnm+7fQUriaKssi/IZ2PMp2zBMbUY+rQjMxjm5SHPXdMZR3xZAk9Y8KfbmjHLJ/zEHHFd7p+oqYuY58jYH+Ne10BILoMjJoCDQzuOQCvYGDdDieoMw2G29Wo1iMDdhV9eTJazGlVWFIrRAHi6OcGEUxUVzRVPN2YYf7LC+4rvNq60c8ea+AL3Uy53bv4EjfEgyZGvJ0Dg4s/APrQidote+izryZKuNaktlrqTA9SCBrPgWqGWgnVKAUJ1ellIqBCKNOCSGZZe0X9gUv8mLgOh/2f01HfDlNOX4GGhqZnKJHm5HFzpYjPFl5nhUOgfm251lgO0ZX7os0ZPUT0S0XHczApp1KZaKUYIkPVWoARYoY69QSJHMdTwhHyz/idMtf+PH8L0SdVSgkKeh/k4MvJ8Hv5h3l5abr7HK+y2b3aVY6RphnGaTOuBO/ZhmFypnkpk8jUlxNz5pi7NnFooMiVOJl1KSLbbrC/7TwetOX/DwIx58dRjHByNymJTy98CXe6r3GSP0X7C96j13e86wqGKHNvJ8qw3qiuiX4dF0U6VpxaWfh1NVhUySxKBNY1CGyM4vQy31IDk49K9zY9ROXT1yhJTabN58d5e9PwsmGGzwdOMce9ztscL5Bt+1FWnP3M928m3rTDhKmTZQbN1FmeJhgVjdeYwsOXRKrpgyTsgSDXGxosaUlI4s/EL4RfuDhORu4MfIZXz51i1Pumwy6P2Gg6CLrCt6gx3qcTsshZpgHSGZtJKLppVi5gMLMWdgz68XLF8YkL8Yod6EVpckoFGNdKKZPBFx67vPXbp38J9++eotvN/+LUfd37MsfY719mMW5zzDT2E9CsxKfohOXrAVLWrXYvOWYU8oxSEPo0if/95boxZ2rpU7kKaLuFjXRSeYkD/8BtiFwscxeIlwAAAAASUVORK5CYII=',
        teemo3 = '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',
        thresh = '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',
        thresh0 = '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',
        thresh1 = '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',
        thresh2 = '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',
        thresh3 = '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',
        twistedfate = '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',
        twistedfate0 = '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',
        twistedfate1 = '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',
        twistedfate2 = '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',
        twistedfate3 = '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',
        twitch = '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',
        twitch0 = 'iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAcfSURBVEhLRZXpc1PXGcaP7pWuFrxIsqx9X73IlvAuL3i3ARs7toGaOGE1pqYYMGYLjgllscHgQHEhLCZhcCBOuTTtEAqTkpSZ9kNn0namM/3W6WT6te3/8PSRnbQfnjlXOve+v3c77xFy1HFCSbhVJWJX5aBVFT7LqiSfVZW8XN3m/4u/f9iTvTZVuPgfJX+/Chf33dx38Vs3bfntqpDCjldy3A1d2A45aPufdCE7dMFCaAOWVemCVihhB5TImrQBOySPFVoP97wWyL4CSD4bhN8CyWuD1ltIO04IybvqDWR3AbR8Qeen0ewLfNYSpA1zL8q9uA2GhHNNcef3cO77qQD3uWa/zYI0BEoeAr0ECDtDK+QfNjNkB+Xks90CTaEZktMMbYSGy1wwpL0U13I3DKVcf4BROgK1URoPFdDrbCRWGrdCcBXCTICFRq00SIiUNVxIb+z0ym6Gxm2hUR8MNWEY6oIwVIdgWM/fKccaMOWCPumEUuqArrgQuhhTy/RqA4yQURKQq0qWfEjmfGgdVkZAT9xOhkoxRNlphT7igrEmAkMLIU0EZEG1HkL9BAagTfG9ZMEqTClhNIxKzqYx4SYgz6hqzLnQ2LJpodz0hIa1WeMeB4SdYbqZ57IAlEYa7o7B0E5tCEOp9UGk7fD21yK+vRlKuhAGRqMtdkMqoVJeAhRZlcJemHZsgmB6BFOT9VzjKODvfAhrLj0tgVwWgWBR9c0xmHpKoLQEYWqPo/bEbvTdvYBNlyZhqvFAz9QpZezKlJ8OBLMAoypl0rDfPAl9fQrCpIdw5CO3NcNQ+UKRB953+9Bw9igkFlEU2ZC3MQ7fwS6MvPwEA7+6g9wL+5Ce3gNjJsD0MW2Va+nT14cJsPFAbFgP8+EdKLx0aNVjEfUjd2w7/Ivvo+pn0+j64i76XjxCydmDhHUifWEcba8fIvPkOqzHhhFemERwvAdKhoaZNkMtIY1haNN+AuJ+VbRXQddaCe+rW1g3NgRRVwaxqxcFc4fR+vwOuv/4DPFP51H+yRxaXz1G1++eoeu3T2CcHIHn8hQSBOb0l8PUFoa+mu3cwFpV+KCJeQhIhFRRl4RmSyMsC0cR+noJttN7IYY3QIxvhji6FcoHo1DOj2HdrdOQ5idgun8BZV8+RvXyIqKXplCRTU8PC99TDMMmqpJRZLsonq1BxEsAPe6ug358EPbP5xH46gESv1mCZXkWYvpdiLGNEBP9MHx4DKGHV6HMjMF48wxij26ieGkersPDMHYmYOiIQd8Ygq7ICyXmh1TKxuBpU0WGgNpy6MYGYPzxEGwr8zCrC3A8uwHlyji8d8+i/usVdLxaxoaXT9D55tdoe/MUFS+WEfn8FpwLJ7BuUzU7h22ZcEG42AwBnoF4tgY2kyrKWe26FOSeDDQtKRiGuxAgIOfqOIJXJlHzYB4lc8dx+G+/x81//xOt6m1k3qyg7g/PEHx2G8F7l5E4PkajDrZzHM7Oes4vgrwECa9DlWIBiPIo5IZy6FuroR9oR96REeSMDiB97xKKzx1B/4vPsPHlY1z713d4+8tH+NEXD9Fwdw7BmZ/Acf4Qyj88g+TUfqQmR9F0/RyCe7dBFLAj5UhQ1SeLoImw4sVB6BiJcXMz5M2NEBUJRNkloaun0Pb0PnpfrWDy29cYevRzRCbeQYCGnbdnYGDxzTemUH3nApInDyB1jfXJRlTAgyp8LlWOBiEFCPByNLg4npMRyI2VkNtqoO9tQPjeecRvTCPFNJXxQ113PXIObEPexNswjW2FbXoMeecOQDrQh7xTO1G1fA251UVrEYiITxUeTj3OIrk0DqWpGpp0grMkCm1FKUdDJbS1pcgf7IB5sB2a+iSU7gxMI73QDXdCbGuB2E5trkP+yEa0fXYDRRePY91IHwoOsgNFyKXqmipgOTgCJ/Poe7oID1sx+xz5+DIqvvoUtr1DUAZbod/SjNydvfDNTqJs6SI6n3+M/m9+gY5ffoSW5w/Q96cXqL9/aRVuf28CzqOjEIZje9SchdMwTu2BvLsP+smdcC5eRMHMYZho2LhvCPHlBVj2DiB39yByju2BeWYclpkDaPlmBW/99TX2/eNbHPvuz2j6y3NIQ2yQhgrkJGNwdbCO2tGtqrabDyEPtDWlMO7ohZ4Fjtw6hzL2eIBdYd+/HbGfTnG+c/ZXJaHrzMA8+hYdOQN5sBkVsydw6j9/R3rmCAelBfmsn3t7L+KH9vNODnpVfcgHW30F8nmi85g7/5X3kP/OFjjGR7B+7gyKzx9HanEW5sYq3rfs9VLWpzLGiHtZgzZEdw0hemgXzwFvMz9HddCN8L4dKD1JoL2t/mXt5ffRvvwRMrMzsNSl4ZmbRnLpOvI2ZGBtqoJjuB81DxcR2D0MEeYlEwtBMAWiqhiarLIjIezilckxwREv8y7xbemCoyWD/wJQBp0x2dW3rwAAAABJRU5ErkJggg==',
        twitch1 = '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',
        twitch2 = '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',
        twitch3 = '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',
        varus = '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',
        varus0 = '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',
        varus1 = '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',
        varus2 = 'iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAapSURBVEhLjZZ7bJPnFcY/25/vdnyJY8dObOI4NzvOFXIzS9NcCOOSkBYYlyRNgAY6Ahm0WWnFQC0NUKABxlhHQdzEZUN8rGK9wdZ2A41tirZ2F6FdpO6PoWrV/tjGOmlClfbb+ZzCIrWaZunojf2+73nOec55zhtlS/Hhr47EL2ijiVe0J2J7tZWxo9qO2ITWHxrRvuhfrq30L9MafPO0r6ce1Q4m52khS0wL26Na1BHStgYLtSGfT1MURVPF9HWmGY1GTTmUnry2P32ZtSUa40X7GIkdYCh6gEOzxngkNMCXAo/Q7e+gJbeRk1UL2VfeTtwRpcNXyGyXj4lIIVsjebhVE6rRhKIYMCiKrAomk3zfUDSpnWs4waaywzwa2cnm/HV0BwZZHRlkf/EymnwZ5ufUUueIk2MOcqSmjfNz2jiZrKTHn4ddnB6OF7C/JE7c6eQLuV5MMwFGonu0JxN7ONM0Tld4lK7Aah73Z0i6W+kLtvGiRF3uSjLXleBhT5glvnze61rAP/uHuT4wiE8AVIOBg6UJ3m1r4Ucdc6nP86MYFCwWC8pY9BltRWgLu9KDHKoZJOVdTIennuGcEsLWCgbirbxU3yl/F/JEfoyjkSivNLVw5/AR+M2vWNPRjkWiHQkG+Fl3O5z8FqfXD2czMFusKIsDQ9qm8ApahetXm/p5urSHsLOVh90JelxhLKYY48kWJmoyeKy57MiP8mxeiKpwPs+vHea17duY7cshYLMykCrj+uQ+Prx0gYUlCQx6TWq9q7SB4Ap6/V0sLpjPO20rWRTMUOdNMR4pZbE7LDwHOJDpYEdbF/OcHr5dUsLeSAS/RFnsdNAQ8GYjzvIu1l5Rzq75nXhsKkqjd4lW5+llqXcOZZ5Gttct5GbfME8VVguvVTwXCrPUF6FYor/+2Bpu9iziG4li9kQKOFdeilt3LHwbTYYHILpJ22K3Sga9vgVa1Jmhxq5zXM6Xw0l+vWELt5f389pD7dS7czgVjzMptFxqmgtvvsGdM6dJmlTOppO8XpemSLi22WyEJJuZIEa9i3ZEMlralcZjCTPmC/F6NM73Oxdy743r/OO7V8hI8RrtDn5YU81TxXFe3v6MFPfnbG5qwCtOrjbUcamhgU63kx1lCWkG6ZxPAbJtOhZOayOhShThudTu52IgxIXKGv546iz87jajNaksr8sK8rnWModyo0JvbZIra/vx2+2UiN3s7uLmkl6mmuawuiiKcSZAoS2s7U3UELUHUNQcHvMGuegJ0G2z8PaTm3nzKxux6RfE8fMlMd7ONJFrMJGwmUkHclkeDnE+WcRH64Zh7wRXlvbgnAkgkWsbYinWFSbEiQubxc3Zojjjfi8hk8L3+hYyP5ibvWCWYl6oTfNuSwNOVaiQwha7HDxdk+an69fAB3/g7ukTVM4EsKgBLemJcry+iaBDHJldVHty+HFdNaUWM2E5lPH7MIpa9Szi8tsP6qs4V50iR/g2mVVsqkqDBPFcXw9/uXKZE/PasuKTYYfiVv2aYshhV3Mra5J1RBxClUFloqqCq82zhX8jBpNZBCfR6CAGs4wMD3/ONDNZUoxXOifkdVErQehRV4rozi3qkHnmnj6vKnatyOphrDzJVM9iDogCLRY7hXYb7y/vYaO0qF/asMLvESBlWp1Sg63RCB+1t7K7sIBUMMix2VU8FPBkQVxCZaHDNk2RUVG1sNnBZHUl/9r9AlOjG7FLxLp4xhprmRoaZK2kv780hkuUaTAacErn5EsWl4XGv60b4uSsKFNzG9lZWZoFuG/qNED2cSAil35x6CC/P3Mqq86mgJ9VMgJ+OS6i61vEDWnXYp9TgI2khI7+ohi78zz8ZFkvdzdt5gOh7NqCbqy6qsV0n9NdJAD3H4iUqPadraMkhNcyh4PTMuNvLZjHx8e/yV9fepFFogX9rNNsYVTa873mGm5VFPHx157l3oXz/GnDOjJeZ5bKBwCqIs+afDEIqi6oTrmYck9Lvs7h4q2uNv596wb89jaPx2d9+loZpEMsDOXnyRvQzL3jL8Pf7/LJdy6yKj8Xk3TbAwD5ZAF0u5/JTIuajRxd0MUn16+yNdP43zNSaH0Nyv62VJL3d26HD+9wqK8Xa/aM4bMAn2sSjUvWiba53Fg/gEeKfH/PKHu6+PT9CrFXB1dy99gR6v052f3/CyAbsVHFLuu2qjIqvdOXP2tGCmQ91trIvvo0Vn1860JTVfUtVf4j0NH+lxlVM1bVhlvG8uftm8SHYjZhkYwyfje5Lps8mVb+A0eIfGp07D+VAAAAAElFTkSuQmCC',
        varus3 = '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',
        vayne = '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',
        vayne0 = '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',
        vayne1 = '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',
        vayne2 = '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',
        vayne3 = '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',
        vladimir = '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',
        vladimir0 = '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',
        vladimir1 = 'iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAcWSURBVEhLTZRZbBvXFYaHM0NSu7gMOVwkSpRJyRIp0lot0aK1WRIpy5KoLXZt2bKszYsWL1Icb8jiFE5dB63jwEgLNy5StHYzSNoCRVIECIoCRYH2oQ9FX1v0sU99CIo+fj1U/dCHH/feM2fOf/5zzr1KW/mJ3az7nDXi37BGzR3ruHnDmjSvCXZf4YY16r9sDRjnrSFjRXw2rFxQYG5Zw8ZlKy/7fHDVypvL+xgyV6xhc1X81q18aNNS2iomvxzyrjPmu8zxwC5TwdvMh24zF7rHbLCIO0yIfcx3hYngHlOh18n5rjMd2mQ1vs5kcIOZ2h2xbwmuMhG+igTmePFcs4vS7pqzsu5l+r0XGDQucsy3ybh/h0n/dcEN8rIOGpcY8W0xE7or53dYOXiNOz3j7KWGWYoOkTNPcSK4xZh5jRHzCqOBDcEa40KkDLmWrXHPFfKiIu8VJ882o94NCbTCmF8cfTvMBd5iqeYhZ2p3mQzNs9eWZ60+y5lgF4uhBGl7hFlzkLORCyzU3iLn3yQXuChKtlAKrkvWjHuLcdca04Ix12mOuQv0u2fIB+bIGetcDD/iSvQRq9FlspUx8kYzJz1pJqsaKXjaWIvOsRPf5lbLY87V70qJ32YqcIfJ8G2UrpIBq6d8jHRZhmZnI2E9QFtJPdO+Q1KWQ2TdR+h39TPvzzEXXOB0KE+vM0qbXkvSFmKq+jBXIwvcan7MRv2PmPDmWGu4xWLkQxbrPkBp1GJWwh4nKTJT9hrqNZMp5wHeNnopmGm6qhtocjYw7W7ndc8Qs1XtJCV4jx7lfEUrm0Y7l2KTzBirLAUusVCVYad2ib3Y+6L6OUqTFrJSWoBOPUy3ZJ9WvRxVgzwrz7BZlSJoL6NWdxF3+ngv0MuJkjiD5TEehwd4FO5jxzxMwThK2tlHvjIrpG1cDi3yRuNDNiM/QElqHiur15DVQwzIOihIqT62nAnuVLYTq3BRodoYNaPsmt28VnqQLXeK864Uq+WtLDuSnChr4VRlC5vVaW4E2qWMsxSCV1gK30fp1YLWgEie1huY1RvJi/Q+1aTgaORJxRGuV3cyLlnPepIsSsDxkiZ6xfc1RxNnyxqZr4jxpreDi5VJlqVkBU+CnGuAY94ChcBVlB7NtJb0g1zSk8zrcc5ojWTUADdLE/ymqp9flR/lekkH/Y4GjtljZKVfMyUtzJbEMFQXdqWcpcomvu/pZlyGpFMwJfuO0g6Oe06iZKUH9+1tvOVoE4IW7uvd7ArZeQl0zhHjrP3g/8rgiDMn+yFJZq00TcZeJ4MRotluUqf52KtM8LS6m1VJ5nRVQobFK2Qxucmqaa3bE3xdMcQjZydrWoJbegdF0pt6K587M/yz7ATfkXVPkrjt7GDG0cy7JRlWStrJSam6ZUCabH6x1/FReTcLMsYx1U2z5hYFasQa1aJsa0l+XzbAb0uzfObI8HN7L392DPKvslE+K+3ngQT82NHHy9I+VhytPHMOsu1s57IjxaR+QAakll65F12Kn6z0cEjz0yskyoLSZE2rcfkYZkWL80B++Km9h18IwZd6hhd6Lx/K/rti+8SR5Q9lg5wTZT/T+3nfcZglR4IXziwFewNTeh0TQjQsYz+lRZiQXip55YC1JjXPi4rT4vTjih7OKM1s2xJ8KkG/EoLf6X38yTnMf0qPS8mOsG1v5Y+OUR7L97v2Yjm7eSJ+BZmub4maGZnEUS3EgpAoHsWwMmodu/YkbzqTfOHq45eePh7ZD/HXshG+8czzTdUsVM7zb0eO7+ld/NoxwMcS/B29k48k8Lbexg9F7bf1dhaEZFGGZUyrZUwurFKlVFoutVqaFNhnXpcx/UCa97nzMF/Zj/D3kmH+4Rjhb/owfxElLyXgTT0lY93CA/0Qz/cJUjzUOvlEzewTnNSbWBfbEZuJElJcVp3NLbfXz0FpTIctyDGlnjVbnKf2FM/0NJ9qXXwtGT6RTFf0ZvakB/ck+FOxP1d7uCDBXsr3h1qHvAg1kmiTELXQU1TgUcqsiOImLiQxWQ8J64AtQr+tnrzawJwtxqysOTUqJUjzEwn6hpbiXSF4YethSW3m/D5BHzktJgmG5LmJ0iKNPiAxFZcoqFZc+BQPEcWgXvHRLOiQqeqWOmZVeZ/UCKdk0u7Y0rynprgnd+Wu2kJGmtit13NR7O1qmKjmIWGTF9nmw2+rwrCVohjSZEMMLmETMgxR4ZGPISFsUkxaRdFhJUi/EmZIfh4RdZ0yISF5EOskyza1lqiMY41mUKf7CNoMvMU4NpeQGEUCj+UTZ0Oeaa9NoHpkL2RC6BYyl8BXVCg/VGsu3AKvLjbxDwlM8fXLWjwX/3dLYoasPtUgqIaKBK4v/BLUJ46GBDX2977/g/8ViknIWdSaosovKO6L6ov24rloD8g0+l/5+1U//wVO9H/J/kcowAAAAABJRU5ErkJggg==',
        vladimir2 = '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',
        vladimir3 = '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',
        xayah = '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',
        xayah0 = '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',
        xayah1 = 'iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAfeSURBVEhLHZYJUFXXHcbPu29le0JEBERBUVERUUABMYCACLLv4oIK74mgIBCeKKKCuOIO1bhgqzGOE72grVbjQoyNmqZuaSJxDXFXlIw1xjZpZ/rrae7MmXPvnTvnf8/3/b/vO8JBcbCZhVk1C3vVQwxWfUSQGisy1KnKDDVVm6qm6lLVZEOymmBIkM8Z6nTtHLVQV6zOMsxS8w3T1UT5LlokqjFKopogv09QMtQdLi2qxWmWXNNZFb2E86e9NM64C3cGiyACRQz5ipVyfRVp+hTyjHnMtCtgumkGhcZi5hsqqTOuoMxuAUUmCwnadDkySdflkSLnOvt6VvZaQX/Fm/c0fRBOwlXtLfoxQAxnhIgiRmRiU1ZgNVpJMyVSajcXq4OVMqdyqkxVzNWX0mBqpM5uKenaHJL1WUzWp5Gsy0HugkqTjTFiPH5iNJ4aL4RZuKhewg9fEUykSMOqlLLa2EixqRCr/PPVjnXYzOXUOtvY5/oHGhwb2Oq4ia0OW0jWZpNpyidFn02qvE9UMplmKGC8JpogEc5AzXCEpxiq+ooQAsT7ZImZNOgb2Gn/OxaZyqk3L6bFdR11bpWs7reUq2Mvsc5lNacGtrHfeT8pSi5RmilMN85hltFCpCaJHF0ucUo84ZpI/OW6wleSOkyEEiKxX2qoZ4/jXo55tfORWyt7e7fQHrSflrGN7H+/mbsFN6i2m8+lief4xOMI07RFxOvSqHFaSut7e4mVfFiNhWQrGUzUxBKsmYAYLguM1IQSJeJYaVzKSfNRLvt38HX4X7gw6hg3pl5g5+hmMjxzaPJeRLkmn5PTT/B5wEVshuUUmkr42PUj2voeYrFrDQtkI9Q7LWaq5CZKk4AIEOPUUWIcU5QE1piW8WdzG18FdPAg/wpv6rq4b7lJsVMJoZo4FkoIi0Uu67I3cWPGTQ66HOS4uZ1O92vcjrlOq1cz9cZKyu0t5OrSyZIQCsm2OkWfyhrXBrY5baPd+RBXI8/yatlt3q5/SteS56TYWUiTcGSbSskRRfhpAjhj+ZQ3BU/5Naabd8Xd9Cx4xiW/c2w017LUcQE5Eq4c2WUiyZShtni1YHGYS522gaPen/Co5Ft+LLrHfxb/zP2i+yzxWMuSARtY5b+VNE2eJG84W7KaeNPUQ3fNY/714Ttez37F4/FdnAs5wYfOG9nUfz1znSyI9Z4b1do+y8gy5LNeu5Fr076gK/QKryZ/D+vgesEVZhus2Fw2UOi4mNnaAsZoAxlj9qc8tIIiv7lUB9i4WXST7rznPKl8yAGPXWz2bOB04J8Qa/o2qRWO1ZSbKtmmaeH28m94OPMOL/we8q76Lc8PPGdD7gbGayMYqQui1lxHnD6WvsJbjkF4Sw0NEAMIl31/pOQIdPyXv/qcZofbGv6WcRkxz6NCLfO0Uar/gG3KTs7EnuHXxz28yn5Ez/xnvGl7ydmmM0wyJ1FmWk6z824maZOJEKmEayczRheGm3DDmmjl7bO3/Hz5J64GXubiyM+5W30HESuNbElgI3N6lbHd3MpBxyN0brvOv8+9pqfiCb+0vcY2pIZUYwGHXTpYZN9AjCwQr80jWs7DxRjywvL4/9X9qJs9mTu4lnyVR1lPOBopIUrWTlUTnfNYM34LVU717HM8zIFeKveLv+Zl7R0er7pDvmshU5Uqufg68h1KSLDLZbR+HF7Sw+L8JnHls+tsXr6FINcgCZk354s6eFH2kpP2XyCq7OrVaCWL2f3LOBp/iubeu2j3aOOs91E6U69zp6qTkiE2sh1KCTO8T5hdBIGG0dJ9+xBgCMQSYGWS5xQ8JA+DxBAy7FMpd6/gu/RbvAv6BWHV1agLTStIlF20bOBazk+5wIXhp7kUfJbvC+7xovYF3628R4FLNf7aUYxQRhCoCcFTcSPaKZoMh1xCpY8l6JLJMeUSb4ghyZDOsYDj9Pj+A5GoFKo2+1U09m1ihhRS06DNdFsf8K68m+7sLh6k/cCzlU8pcLLhI7cfLMIYKyIYoLgzwRRFvrmASJ30HW2wdGRfaZrDKO+9kDcT3/Ig7IEkWcxR5zlIB+2zj9Z++zg5+jjfxnxJZ0ontzJv01P9I1998HfSXC34modJnw9kpBgr4RjGaCWMWF0S/RQv+sqCA4UPw8RgSl3LeT73Bc9XvUREiwJ1mt7GIT+pQGMrbe7tnPQ+wQnP09Keb3K3tIszlZ/x7uw/+ebcTS4cu8j2xbvxdw+WARXMGGUcQ5TBDFR88NV4/6byKrcl/HT4LfcbHiLixXQ1RZnHzgntHPY9znbtHppdmjnguY+PB+3DYrYwVJK3e/YOfmjtgje/dSSdt25RklXCCI0/45QI/LS+cgeeEkYftk3azpOTzzjo0yY5MOWrFnMNlt6ruJh0lV3m38tcXS6jskQ6bIxMJn+JrZ9sSV8mGuNJH5JDTvg0YgMTiO4VR4RGxqxmMoOUgYy3D2PR4GquVFznfPqXbLbbgQhWotVIGdaJoox692Y299tKjX0tuQ45hOhHMlIZKqEYJVUbKe1goiw4jlESmmAxQUZsrIzJZHK1s0g3ZFPpWkG+Wx6bRrTQEXWZxt4bEYFK4KkJShwJioV8YSNPUyqVGsdYaWghGmlqUqlRugjS7acQLTMjVqo3w5hDqiGTJHnqmKabhVU7n5mySLgsHiI77FDcHzkV2kGN81r+B/2jjrnWa5nLAAAAAElFTkSuQmCC',
        xayah2 = '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',
        xayah3 = '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',
    }
    
    Save('MenuElement' .. HeroSpirites[1], Spirites[name .. '0'])
    Save('MenuElement' .. HeroSpirites[2], Spirites[name .. '1'])
    Save('MenuElement' .. HeroSpirites[3], Spirites[name .. '2'])
    Save('MenuElement' .. HeroSpirites[4], Spirites[name .. '3'])
    Save('MenuElement' .. HeroSpirites[5], Spirites[name])
    
    Save('MenuElement' .. LogoSpirites[1], Spirites['LogoMain'])
    Save('MenuElement' .. LogoSpirites[2], Spirites['LogoBlack'])
    Save('MenuElement' .. LogoSpirites[3], Spirites['LogoStars'])
end

-- changelog
do
    local charName = myHero.charName
    local Timer = Game.Timer
    local DrawColor = Draw.Color
    local DrawLine = Draw.Line
    local DrawRect = Draw.Rect
    local DrawText = Draw.Text
    --
    local mainText = currentData.Core.Changelog
    local champText = currentData.Champions[charName].Changelog
    --
    local Color = {
        Black = DrawColor(0, 15, 15, 15),
        White = DrawColor(237, 255, 255, 255),
        Grey = DrawColor(200, 20, 20, 20),
    }
    --
    local delta = 0
    --
    local wrSprite, starSprite
    
    local function DrawRectOutline(x, y, width, height, thic, color)
        local A = {x = x - width / 2, y = y - height / 2}
        local B = {x = x - width / 2, y = y + height / 2}
        local C = {x = x + width / 2, y = y + height / 2}
        local D = {x = x + width / 2, y = y - height / 2}
        DrawLine(A.x, A.y, B.x, B.y, thic, color)
        DrawLine(B.x, B.y, C.x, C.y, thic, color)
        DrawLine(C.x, C.y, D.x, D.y, thic, color)
        DrawLine(D.x, D.y, A.x, A.y, thic, color)
    end
    
    class "Changelog"
    
    function Changelog:__init()
        self:CheckSprites()
        --[[Animation Stuff]]
        self.stage = 1
        self.endT = Timer() + 2
        self.StageDuration = {1, 0.5, 0.3, 1, 0.5}
        --[[Dimension Stuff]]
        local res = Game.Resolution()
        self.x = res.x / 2
        self.y = res.y / 2
        self.width = res.x --If anyone want to change sizes..
        self.height = res.y --If anyone want to change sizes..
        --[[Initialization]]
        self.Load = true
        self.loadTime = Timer()
        Callback.Add("Draw", function() self:OnDraw() end)
        Callback.Add("WndMsg", function(...) self:WndMsg(...) end)
    end
    
    function Changelog:CheckSprites()
        wrSprite = Sprite('MenuElement\\' .. LogoSpirites[2])
	    starSprite = Sprite('MenuElement\\' .. LogoSpirites[3])
	    starSprite:SetScale(0.33)
	end
	 
	function Changelog:OnDraw()
	    if not self.Load or Timer() - self.loadTime < 1 then return end --couldnt get Callback.Del to work :/
	    --
	    self:UpdateStage()
	    --
	    local mod = ((self.stage <= 2 or self.stage == 5) and delta) or (self.stage == 4 and 1 - delta) or 1
	    local args = {1.00 + 0.5 * mod, -0.74 * self.y * mod} --stages 2,3 and 4
	    if self.stage == 1 then
	        args = {0.01 + 0.99 * mod}
	        self:Stage1(mod)
	    elseif self.stage == 2 then
	        self:Stage2(mod)
	    elseif self.stage == 3 then
	        self:Stage3(mod)
	    elseif self.stage == 4 then
	        self:Stage4(mod)
	    elseif self.stage == 5 then
	        args = {1.00 - 0.99 * mod}
	    end
	    --
	    self:SpriteAnimation(args)
	end
	 
	function Changelog:Stage1(scale)
	    DrawLine(self.x, self.y - self.height, self.x, self.y + self.height, 2 * self.width, Color.Black)
	    Color.Black = DrawColor(240 * scale, 15, 15, 15)
	end
	 
	function Changelog:Stage2(scale)
	    self:Stage1(1)
	    DrawLine(self.x * 0.823, self.y * 0.5, self.x * 0.823 - self.x * 0.3125 * scale, self.y * 0.5, 4, Color.White)
	    DrawLine(self.x * 1.180, self.y * 0.5, self.x * 1.180 + self.x * 0.3125 * scale, self.y * 0.5, 4, Color.White)
	end
	 
	function Changelog:Stage3(scaleForStage2)
	    self:Stage2(scaleForStage2)
	    starSprite:Draw(self.x * 0.95, self.y * 0.5)
	    starSprite:SetColor(Color.White)
	    DrawRect (self.x * 0.965, self.y * 1.64, 70, 34, Color.Grey)
	    DrawRectOutline(self.x * 1.001, self.y * 1.673, 72, 36, Color.White)
	    self:Texts()
	end
	 
	function Changelog:Stage4()
	    local b = 1 - delta
	    Color.White = DrawColor(237 * b, 255, 255, 255)
	    Color.Grey = DrawColor(200 * b, 20, 20, 20)
	    Color.Black = DrawColor(240 * b, 15, 15, 15)
	    self:Stage3(b)
	end
	 
	function Changelog:WndMsg(msg, param)
	    if self.stage == 3 and msg == 513 and param == 0 then
	        local xPos, yPos = cursorPos.x, cursorPos.y
	        if xPos >= self.x * 0.96 and xPos <= self.x * 1.04 and yPos >= self.y * 1.64 and yPos <= self.y * 1.7 then
	            self.stage = 4
	            self.endT = Timer() + self.StageDuration[self.stage]
	            wrSprite = Sprite('MenuElement\\' .. LogoSpirites[2])
	        end
	    end
	end
	 
	function Changelog:UpdateStage()
	    local t = Timer()
	    if t >= self.endT and self.stage ~= 3 then
	        if self.stage == 5 then
	            self.Load = false
	            return
	        elseif self.stage == 2 then
	            wrSprite = Sprite('MenuElement\\' .. LogoSpirites[1])
	        end
	        self.stage = self.stage + 1
	        self.endT = t + self.StageDuration[self.stage]
	    end
	    delta = (t - self.endT) / self.StageDuration[self.stage] + 1
	end
	 
	function Changelog:Texts()
	    DrawText("PROJECT WINRATE", 40, self.x * 0.85, self.y * 0.46, Color.White)
	    DrawText("Changelog: ", 30, self.x * 0.54, self.y * 0.655, Color.White)
	    DrawText(mainText, 20, self.x * 0.56, self.y * 0.737, Color.White)
	    DrawText(charName.." Changes:", 30, self.x * 1.15, self.y * 0.655, Color.White)
	    DrawText(champText, 20, self.x * 1.17, self.y * 0.737, Color.White)
	    DrawText("OK", 22, self.x * 0.99, self.y * 1.65, Color.White)
	end
	 
	function Changelog:SpriteAnimation(args)
	    if args[1] then
	        wrSprite:SetScale(args[1])
	    end
	    local w, h = wrSprite.width / 2, wrSprite.height / 2
	    wrSprite:Draw(self.x - w + 2, self.y - h + (args[2] or 0))
	end
	 
	if Timer() <= 30 then
	    Changelog()
	end
end
 
require "MapPositionGOS"
require "DamageLib"
require "2DGeometry"
 
--
local huge = math.huge
local pi = math.pi
local floor = math.floor
local ceil = math.ceil
local sqrt = math.sqrt
local max = math.max
local min = math.min
--
local lenghtOf = math.lenghtOf
local abs = math.abs
local deg = math.deg
local cos = math.cos
local sin = math.sin
local acos = math.acos
local atan = math.atan
--
local contains = table.contains
local insert = table.insert
local remove = table.remove
local sort = table.sort
--
local TEAM_JUNGLE = 300
local TEAM_ALLY = myHero.team
local TEAM_ENEMY = TEAM_JUNGLE - TEAM_ALLY
--
local _STUN = 5
local _TAUNT = 8
local _SLOW = 10
local _SNARE = 11
local _FEAR = 21
local _CHARM = 22
local _SUPRESS = 24
local _KNOCKUP = 29
local _KNOCKBACK = 30
--
local Vector = Vector
local KeyDown = Control.KeyDown
local KeyUp = Control.KeyUp
local IsKeyDown = Control.IsKeyDown
local SetCursorPos = Control.SetCursorPos
--
local GameCanUseSpell = Game.CanUseSpell
local Timer = Game.Timer
local Latency = Game.Latency
local HeroCount = Game.HeroCount
local Hero = Game.Hero
local MinionCount = Game.MinionCount
local Minion = Game.Minion
local TurretCount = Game.TurretCount
local Turret = Game.Turret
local WardCount = Game.WardCount
local Ward = Game.Ward
local ObjectCount = Game.ObjectCount
local Object = Game.Object
local MissileCount = Game.MissileCount
local Missile = Game.Missile
local ParticleCount = Game.ParticleCount
local Particle = Game.Particle
--
local DrawCircle = Draw.Circle
local DrawLine = Draw.Line
local DrawColor = Draw.Color
local DrawMap = Draw.CircleMinimap
local DrawText = Draw.Text
--
local barHeight = 8
local barWidth = 103
local barXOffset = 18
local barYOffset = 10
local DmgColor = DrawColor(255, 235, 103, 25)
 
local Color = {
    Red = DrawColor(255, 255, 0, 0),
    Green = DrawColor(255, 0, 255, 0),
    Blue = DrawColor(255, 0, 0, 255),
    White = DrawColor(255, 255, 255, 255),
    Black = DrawColor(255, 0, 0, 0),
}
 
local Orbwalker
local ObjectManager
local TargetSelector
local HealthPrediction
 
local GetMode, GetMinions, GetAllyMinions, GetEnemyMinions, GetMonsters, GetHeroes, GetAllyHeroes, GetEnemyHeroes, GetTurrets, GetAllyTurrets, GetEnemyTurrets, GetWards, GetAllyWards, GetEnemyWards, OnPreMovement, OnPreAttack, OnAttack, OnPostAttack, OnPostAttackTick, OnUnkillableMinion, SetMovement, SetAttack, GetTarget, ResetAutoAttack, IsAutoAttacking, Orbwalk, SetHoldRadius, SetMovementDelay, ForceTarget, ForceMovement, GetHealthPrediction, GetPriority
 
table.insert(LoadCallbacks, function()
	Orbwalker = _G.SDK.Orbwalker
	ObjectManager = _G.SDK.ObjectManager
	TargetSelector = _G.SDK.TargetSelector
	HealthPrediction = _G.SDK.HealthPrediction
	 
	GetMode = function() --1:Combo|2:Harass|3:LaneClear|4:JungleClear|5:LastHit|6:Flee
	    local modes = Orbwalker.Modes
	    for i = 0, #modes do
	        if modes[i] then return i + 1 end
	    end
	    return nil
	end
	 
	GetMinions = function(range)
	    return ObjectManager:GetMinions(range)
	end
	 
	GetAllyMinions = function(range)
	    return ObjectManager:GetAllyMinions(range)
	end
	 
	GetEnemyMinions = function(range)
	    return ObjectManager:GetEnemyMinions(range)
	end
	 
	GetMonsters = function(range)
	    return ObjectManager:GetMonsters(range)
	end
	 
	GetHeroes = function(range)
	    return ObjectManager:GetHeroes(range)
	end
	 
	GetAllyHeroes = function(range)
	    return ObjectManager:GetAllyHeroes(range)
	end
	 
	GetEnemyHeroes = function(range)
	    return ObjectManager:GetEnemyHeroes(range)
	end
	 
	GetTurrets = function(range)
	    return ObjectManager:GetTurrets(range)
	end
	 
	GetAllyTurrets = function(range)
	    return ObjectManager:GetAllyTurrets(range)
	end
	 
	GetEnemyTurrets = function(range)
	    return ObjectManager:GetEnemyTurrets(range)
	end
	 
	GetWards = function(range)
	    return ObjectManager:GetOtherMinions(range)
	end
	 
	GetAllyWards = function(range)
	    return ObjectManager:GetOtherAllyMinions(range)
	end
	 
	GetEnemyWards = function(range)
	    return ObjectManager:GetOtherEnemyMinions(range)
	end
	 
	OnPreMovement = function(fn)
	    Orbwalker:OnPreMovement(fn)
	end
	 
	OnPreAttack = function(fn)
	    Orbwalker:OnPreAttack(fn)
	end
	 
	OnAttack = function(fn)
	    Orbwalker:OnAttack(fn)
	end
	 
	OnPostAttack = function(fn)
	    Orbwalker:OnPostAttack(fn)
	end
	 
	OnPostAttackTick = function(fn)
	    if Orbwalker.OnPostAttackTick then
	        Orbwalker:OnPostAttackTick(fn)
	    else
	        Orbwalker:OnPostAttack(fn)
	    end
	end
	 
	OnUnkillableMinion = function(fn)
	    if Orbwalker.OnUnkillableMinion then
	        Orbwalker:OnUnkillableMinion(fn)
	    end
	end
	 
	SetMovement = function(bool)
	    Orbwalker:SetMovement(bool)
	end
	 
	SetAttack = function(bool)
	    Orbwalker:SetAttack(bool)
	end
	 
	GetTarget = function(range, mode) --0:Physical|1:Magical|2:True
	    return TargetSelector:GetTarget(range or huge, mode or 0)
	end
	 
	ResetAutoAttack = function()
	end
	 
	IsAutoAttacking = function()
	    return Orbwalker:IsAutoAttacking()
	end
	 
	Orbwalk = function()
	    Orbwalker:Orbwalk()
	end
	 
	SetHoldRadius = function(value)
	    Orbwalker.Menu.General.HoldRadius:Value(value)
	end
	 
	SetMovementDelay = function(value)
	    Orbwalker.Menu.General.MovementDelay:Value(value)
	end
	 
	ForceTarget = function(unit)
	    Orbwalker.ForceTarget = unit
	end
	 
	ForceMovement = function(pos)
	    Orbwalker.ForceMovement = pos
	end
	 
	GetHealthPrediction = function(unit, delay)
	    return HealthPrediction:GetPrediction(unit, delay)
	end
	 
	GetPriority = function(unit)
	    return TargetSelector:GetPriority(unit) or 1
	end
end)
 
local function TextOnScreen(str)
    local res = Game.Resolution()
    Callback.Add("Draw", function()
        DrawText(str, 64, res.x / 2 - (#str * 10), res.y / 2, Color.Red)
    end)
end
 
local function Ready(spell)
    return GameCanUseSpell(spell) == 0
end
 
local function RotateAroundPoint(v1, v2, angle)
    local cos, sin = cos(angle), sin(angle)
    local x = ((v1.x - v2.x) * cos) - ((v1.z - v2.z) * sin) + v2.x
    local z = ((v1.z - v2.z) * cos) + ((v1.x - v2.x) * sin) + v2.z
    return Vector(x, v1.y, z or 0)
end
 
local function GetDistanceSqr(p1, p2)
	local success, message = pcall(function() if p1 == nil then print(p1.x) end end)
	if not success then print(message) end
    p2 = p2 or myHero
    p1 = p1.pos or p1
    p2 = p2.pos or p2
    
    local dx, dz = p1.x - p2.x, p1.z - p2.z
    return dx * dx + dz * dz
end
 
local function GetDistance(p1, p2)
    return sqrt(GetDistanceSqr(p1, p2))
end
 
local ItemHotKey = {[ITEM_1] = HK_ITEM_1, [ITEM_2] = HK_ITEM_2, [ITEM_3] = HK_ITEM_3, [ITEM_4] = HK_ITEM_4, [ITEM_5] = HK_ITEM_5, [ITEM_6] = HK_ITEM_6, [ITEM_7] = HK_ITEM_7}
local function GetItemSlot(id) --returns Slot, HotKey
    for i = ITEM_1, ITEM_7 do
        if myHero:GetItemData(i).itemID == id then
            return i, ItemHotKey[i]
        end
    end
    return 0
end
 
local wardItemIDs = {3340, 2049, 2301, 2302, 2303, 3711}
local function GetWardSlot() --returns Slot, HotKey
    for i = 1, #wardItemIDs do
        local ward, key = GetItemSlot(wardItemIDs[i])
        if ward ~= 0 then
            return ward, key
        end
    end
end
 
local rotateAngle = 0
local function DrawMark(pos, thickness, size, color)
    rotateAngle = (rotateAngle + 2) % 720
    local hPos, thickness, color, size = pos or myHero.pos, thickness or 3, color or Color.Red, size * 2 or 150
    local offset, rotateAngle, mod = hPos + Vector(0, 0, size), rotateAngle / 360 * pi, 240 / 360 * pi
    local points = {
        hPos:To2D(),
        RotateAroundPoint(offset, hPos, rotateAngle):To2D(),
        RotateAroundPoint(offset, hPos, rotateAngle + mod):To2D(),
    RotateAroundPoint(offset, hPos, rotateAngle + 2 * mod):To2D(),
}
    --
    for i = 1, #points do
        for j = 1, #points do
            local lambda = i ~= j and DrawLine(points[i].x - 3, points[i].y - 5, points[j].x - 3, points[j].y - 5, thickness, color) -- -3 and -5 are offsets (because ext)
        end
    end
end
 
local function DrawRectOutline(vec1, vec2, width, color)
    local vec3, vec4 = vec2 - vec1, vec1 - vec2
    local A = (vec1 + (vec3:Perpendicular2():Normalized() * width)):To2D()
    local B = (vec1 + (vec3:Perpendicular():Normalized() * width)):To2D()
    local C = (vec2 + (vec4:Perpendicular2():Normalized() * width)):To2D()
    local D = (vec2 + (vec4:Perpendicular():Normalized() * width)):To2D()
    
    DrawLine(A, B, 3, color)
    DrawLine(B, C, 3, color)
    DrawLine(C, D, 3, color)
    DrawLine(D, A, 3, color)
end
 
local function VectorPointProjectionOnLineSegment(v1, v2, v)
    local cx, cy, ax, ay, bx, by = v.x, v.z, v1.x, v1.z, v2.x, v2.z
    local rL = ((cx - ax) * (bx - ax) + (cy - ay) * (by - ay)) / ((bx - ax) * (bx - ax) + (by - ay) * (by - ay))
    local pointLine = {x = ax + rL * (bx - ax), z = ay + rL * (by - ay)}
    local rS = rL < 0 and 0 or (rL > 1 and 1 or rL)
    local isOnSegment = rS == rL
    local pointSegment = isOnSegment and pointLine or {x = ax + rS * (bx - ax), z = ay + rS * (by - ay)}
    return pointSegment, pointLine, isOnSegment
end
 
local function mCollision(pos1, pos2, spell, list) --returns a table with minions (use #table to get count)
    local result, speed, width, delay, list = {}, spell.Speed, spell.Width + 65, spell.Delay, list
    --
    if not list then
        list = GetEnemyMinions(max(GetDistance(pos1), GetDistance(pos2)) + spell.Range + 100)
    end
    --
    for i = 1, #list do
        local m = list[i]
        local pos3 = delay and m:GetPrediction(speed, delay) or m.pos
        if m and m.team ~= TEAM_ALLY and m.dead == false and m.isTargetable and GetDistanceSqr(pos1, pos2) > GetDistanceSqr(pos1, pos3) then
            local pointSegment, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(pos1, pos2, pos3)
            if isOnSegment and GetDistanceSqr(pointSegment, pos3) < width * width then
                result[#result + 1] = m
            end
        end
    end
    return result
end
 
local function hCollision(pos1, pos2, spell, list) --returns a table with heroes (use #table to get count)
    local result, speed, width, delay, list = {}, spell.Speed, spell.Width + 65, spell.Delay, list
    if not list then
        list = GetEnemyHeroes(max(GetDistance(pos1), GetDistance(pos2)) + spell.Range + 100)
    end
    for i = 1, #list do
        local h = list[i]
        local pos3 = delay and h:GetPrediction(speed, delay) or h.pos
        if h and h.team ~= TEAM_ALLY and h.dead == false and h.isTargetable and GetDistanceSqr(pos1, pos2) > GetDistanceSqr(pos1, pos3) then
            local pointSegment, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(pos1, pos2, pos3)
            if isOnSegment and GetDistanceSqr(pointSegment, pos3) < width * width then
                insert(result, h)
            end
        end
    end
    return result
end
 
local function HealthPercent(unit)
    return unit.maxHealth > 5 and unit.health / unit.maxHealth * 100 or 100
end
 
local function ManaPercent(unit)
    return unit.maxMana > 0 and unit.mana / unit.maxMana * 100 or 100
end
 
local function HasBuffOfType(unit, bufftype, delay) --returns bool and endtime , why not starting at buffCOunt and check back to 1 ?
    local delay = delay or 0
    local bool = false
    local endT = Timer()
    for i = 1, unit.buffCount do
        local buff = unit:GetBuff(i)
        if buff.type == bufftype and buff.expireTime >= Timer() and buff.duration > 0 then
            if buff.expireTime > endT then
                bool = true
                endT = buff.expireTime
            end
        end
    end
    return bool, endT
end
 
local function HasBuff(unit, buffname) --returns bool
    return GotBuff(unit, buffname) == 1
end
 
local function GetBuffByName(unit, buffname) --returns buff
    return GetBuffData(unit, buffname)
end
 
local function GetBuffByType(unit, bufftype) --returns buff
    for i = 1, unit.buffCount do
        local buff = unit:GetBuff(i)
        if buff.type == bufftype and buff.expireTime >= Timer() and buff.duration > 0 then
            return buff
        end
    end
    return nil
end
 
local UndyingBuffs = {
    ["Aatrox"] = function(target, addHealthCheck)
        return HasBuff(target, "aatroxpassivedeath")
    end,
    ["Fiora"] = function(target, addHealthCheck)
        return HasBuff(target, "FioraW")
    end,
    ["Tryndamere"] = function(target, addHealthCheck)
        return HasBuff(target, "UndyingRage") and (not addHealthCheck or target.health <= 30)
    end,
    ["Vladimir"] = function(target, addHealthCheck)
        return HasBuff(target, "VladimirSanguinePool")
    end,
}
 
local function HasUndyingBuff(target, addHealthCheck)
    --Self Casts Only
    local buffCheck = UndyingBuffs[target.charName]
    if buffCheck and buffCheck(target, addHealthCheck) then return true end
    --Can Be Casted On Others
    if HasBuff(target, "JudicatorIntervention") or ((not addHealthCheck or HealthPercent(target) <= 10) and (HasBuff(target, "kindredrnodeathbuff") or HasBuff(target, "ChronoShift") or HasBuff(target, "chronorevive"))) then
        return true
    end
    return target.isImmortal
end
 
local function IsValidTarget(unit, range) -- the == false check is faster than using "not"
    return unit and unit.valid and unit.visible and not unit.dead and unit.isTargetableToTeam and (not range or GetDistance(unit) <= range) and (not unit.type == myHero.type or not HasUndyingBuff(unit, true))
end
 
local function GetTrueAttackRange(unit, target)
    local extra = target and target.boundingRadius or 0
    return unit.range + unit.boundingRadius + extra
end
 
local function HeroesAround(range, pos, team)
    pos = pos or myHero.pos
    local dist = GetDistance(pos) + range + 100
    local result = {}
    local heroes = (team == TEAM_ENEMY and GetEnemyHeroes(dist)) or (team == TEAM_ALLY and GetAllyHeroes(dist) or GetHeroes(dist))
    for i = 1, #heroes do
        local h = heroes[i]
        if GetDistance(pos, h.pos) <= range then
            result[#result + 1] = h
        end
    end
    return result
end
 
local function CountEnemiesAround(pos, range)
    return #HeroesAround(range, pos, TEAM_ENEMY)
end
 
local function GetClosestEnemy(unit)
    local unit = unit or myHero
    local closest, list = nil, GetHeroes()
    for i = 1, #list do
        local enemy = list[i]
        if IsValidTarget(enemy) and enemy.team ~= unit.team and (not closest or GetDistance(enemy, unit) < GetDistance(closest, unit)) then
            closest = enemy
        end
    end
    return closest
end
 
local function MinionsAround(range, pos, team)
    pos = pos or myHero.pos
    local dist = GetDistance(pos) + range + 100
    local result = {}
    local minions = (team == TEAM_ENEMY and GetEnemyMinions(dist)) or (team == TEAM_ALLY and GetAllyMinions(dist) or GetMinions(dist))
    for i = 1, #minions do
        local m = minions[i]
        if m and not m.dead and GetDistance(pos, m.pos) <= range + m.boundingRadius then
            result[#result + 1] = m
        end
    end
    return result
end
 
local function IsUnderTurret(pos, team)
    local turrets = GetTurrets(GetDistance(pos) + 1000)
    for i = 1, #turrets do
        local turret = turrets[i]
        if GetDistance(turret, pos) <= 915 and turret.team == team then
            return turret
        end
    end
end
 
local function GetDanger(pos)
    local result = 0
    --
    local turret = IsUnderTurret(pos, TEAM_ENEMY)
    if turret then
        result = result + floor((915 - GetDistance(turret, pos)) / 17.3)
    end
    --
    local nearby = HeroesAround(700, pos, TEAM_ENEMY)
    for i = 1, #nearby do
        local enemy = nearby[i]
        local dist, mod = GetDistance(enemy, pos), enemy.range < 350 and 2 or 1
        result = result + (dist <= GetTrueAttackRange(enemy) and 5 or 0) * mod
    end
    --
    result = result + #HeroesAround(400, pos, TEAM_ENEMY) * 1
    return result
end
 
local function IsImmobile(unit, delay)
    if unit.ms == 0 then return true, unit.pos, unit.pos end
    local delay = delay or 0
    local debuff, timeCheck = {}, Timer() + delay
    for i = 1, unit.buffCount do
        local buff = unit:GetBuff(i)
        if buff.expireTime >= timeCheck and buff.duration > 0 then
            debuff[buff.type] = true
        end
    end
    if debuff[_STUN] or debuff[_TAUNT] or debuff[_SNARE] or debuff[_SLEEP] or
        debuff[_CHARM] or debuff[_SUPRESS] or debuff[_AIRBORNE] then
        return true
    end
end
 
local function IsFacing(unit, p2)
    p2 = p2 or myHero
    p2 = p2.pos or p2
    local V = unit.pos - p2
    local D = unit.dir
    local Angle = 180 - deg(acos(V * D / (V:Len() * D:Len())))
    if abs(Angle) < 80 then
        return true
    end
end
 
local function CheckHandle(tbl, handle)
    for i = 1, #tbl do
        local v = tbl[i]
        if handle == v.handle then return v end
    end
end
 
local function GetTargetByHandle(handle)
    return CheckHandle(GetEnemyHeroes(1200), handle) or
    CheckHandle(GetMonsters(1200), handle) or
    CheckHandle(GetEnemyTurrets(1200), handle) or
    CheckHandle(GetEnemyMinions(1200), handle) or
    CheckHandle(GetEnemyWards(1200), handle)
end
 
local function ShouldWait()
    return myHero.dead or HasBuff(myHero, "recall") or Game.IsChatOpen() or (ExtLibEvade and ExtLibEvade.Evading == true)
end
 
local Emote = {
    Joke = HK_ITEM_1,
    Taunt = HK_ITEM_2,
    Dance = HK_ITEM_3,
    Mastery = HK_ITEM_5,
    Laugh = HK_ITEM_7,
    Casting = false
}
 
local function CastEmote(emote)
    if not emote or Emote.Casting or myHero.attackData.state == STATE_WINDUP then return end
    --
    Emote.Casting = true
    KeyDown(HK_LUS)
    KeyDown(emote)
    DelayAction(function()
        KeyUp(emote)
        KeyUp(HK_LUS)
        Emote.Casting = false
    end, 0.01)
end
 
-- Farm Stuff
 
local function ExcludeFurthest(average, lst, sTar)
    local removeID = 1
    for i = 2, #lst do
        if GetDistanceSqr(average, lst[i].pos) > GetDistanceSqr(average, lst[removeID].pos) then
            removeID = i
        end
    end
    
    local Newlst = {}
    for i = 1, #lst do
        if (sTar and lst[i].networkID == sTar.networkID) or i ~= removeID then
            Newlst[#Newlst + 1] = lst[i]
        end
    end
    return Newlst
end
 
local function GetBestCircularCastPos(spell, sTar, lst)
    local average = {x = 0, z = 0, count = 0}
    local heroList = lst and lst[1] and (lst[1].type == myHero.type)
    local range = spell.Range or 2000
    local radius = spell.Radius or 50
    if sTar and (not lst or #lst == 0) then
        return Prediction:GetBestCastPosition(sTar, spell), 1
    end
    --
    for i = 1, #lst do
        if IsValidTarget(lst[i], range) then
            local org = heroList and Prediction:GetBestCastPosition(lst[i], spell) or lst[i].pos
            average.x = average.x + org.x
            average.z = average.z + org.z
            average.count = average.count + 1
        end
    end
    --
    if sTar and sTar.type ~= lst[1].type then
        local org = heroList and Prediction:GetBestCastPosition(sTar, spell) or lst[i].pos
        average.x = average.x + org.x
        average.z = average.z + org.z
        average.count = average.count + 1
    end
    --
    average.x = average.x / average.count
    average.z = average.z / average.count
    --
    local inRange = 0
    for i = 1, #lst do
        local bR = lst[i].boundingRadius
        if GetDistanceSqr(average, lst[i].pos) - bR * bR < radius * radius then
            inRange = inRange + 1
        end
    end
    --
    local point = Vector(average.x, myHero.pos.y, average.z)
    --
    if inRange == #lst then
        return point, inRange
    else
        return GetBestCircularCastPos(spell, sTar, ExcludeFurthest(average, lst))
    end
end
 
local function GetBestLinearCastPos(spell, sTar, list)
    startPos = spell.From.pos or myHero.pos
    local isHero = list[1].type == myHero.type
    --
    local center = GetBestCircularCastPos(spell, sTar, list)
    local endPos = startPos + (center - startPos):Normalized() * spell.Range
    local MostHit = isHero and #hCollision(startPos, endPos, spell, list) or #mCollision(startPos, endPos, spell, list)
    return endPos, MostHit
end
 
local function GetBestLinearFarmPos(spell)
    local minions = GetEnemyMinions(spell.Range + spell.Radius)
    if #minions == 0 then return nil, 0 end
    return GetBestLinearCastPos(spell, nil, minions)
end
 
local function GetBestCircularFarmPos(spell)
    local minions = GetEnemyMinions(spell.Range + spell.Radius)
    if #minions == 0 then return nil, 0 end
    return GetBestCircularCastPos(spell, nil, minions)
end
 
local function CircleCircleIntersection(c1, c2, r1, r2)
    local D = GetDistance(c1, c2)
    if D > r1 + r2 or D <= abs(r1 - r2) then return nil end
    local A = (r1 * r2 - r2 * r1 + D * D) / (2 * D)
    local H = sqrt(r1 * r1 - A * A)
    local Direction = (c2 - c1):Normalized()
    local PA = c1 + A * Direction
    local S1 = PA + H * Direction:Perpendicular()
    local S2 = PA - H * Direction:Perpendicular()
    return S1, S2
end
 
function PassivePercentMod(source, target, dmgMod)
    local tarMinion = target.type == Obj_AI_Minion and target
    local newMod = dmgMod
    
    if source.type == Obj_AI_Turret then
        if tarMinion and (tarMinion.charName:find("MinionSiege") or tarMinion.charName:find("MinionSuper")) then
            newMod = newMod * 0.7
        end
    end
    
    if source.type == Obj_AI_Minion then
        if tarMinion and Game.mapID == 10 then
            newMod = newMod * (1 + minion.percentDamageToBarracksMinionMod)
        end
    end
    
    if tarMinion then
        if tarMinion.charName:find("MinionMelee") and HasBuff(tarMinion, "exaltedwithbaronnashorminion") then
            newMod = newMod * 0.25
        end
    end
    
    if source.type == Obj_AI_Hero then
        if tarMinion then
            if HasBuff(source, "barontarget") and tarMinion.charName:find("SRU_Baron") then
                newMod = newMod * 0.5
            end
        end
    end
    
    return newMod
end
 
local reductions = {
    ["Alistar"] = function(t) return HasBuff(t, "FerociousHowl") and (0.45 + 0.1 * t:GetSpellData(_R).level) end,
    ["Annie"] = function(t) return HasBuff(t, "AnnieE") and (0.10 + 0.06 * t:GetSpellData(_E).level) end,
    ["Galio"] = function(t) return HasBuff(t, "GalioW") and (0.15 + 0.05 * t:GetSpellData(_W).level + 0.08 * t.bonusMagicResist / 100) end,
    ["Garen"] = function(t) return HasBuff(t, "GarenW") and (0.30) end,
    ["Gragas"] = function(t) return HasBuff(t, "gragaswself") and (0.08 + 0.02 * t:GetSpellData(_W).level + 0.04 * t.ap / 100) end,
    ["Irelia"] = function(t) return HasBuff(t, "ireliawdefense") and (0.40 + 0.05 * t:GetSpellData(_W).level + 0.07 * t.ap / 100) end,
    ["Malzahar"] = function(t) return HasBuff(t, "malzaharpassiveshield") and (0.90) end,
    ["MasterYi"] = function(t) return HasBuff(t, "Meditate") and (0.45 + 0.05 * t:GetSpellData(_W).level) end,
    ["Warwick"] = function(t) return HasBuff(t, "WarwickE") and (0.30 + 0.05 * t:GetSpellData(_E).level) end,
}
function CalcMagicalDamage(source, target, amount, time)
    local passiveMod = 0
    
    local totalMR = target.magicResist + target.bonusMagicResist
    if totalMR < 0 then
        passiveMod = 2 - 100 / (100 - totalMR)
    elseif totalMR * source.magicPenPercent - source.magicPen < 0 then
        passiveMod = 1
    else
        passiveMod = 100 / (100 + totalMR * source.magicPenPercent - source.magicPen)
    end
    
    local dmg = max(floor(PassivePercentMod(source, target, passiveMod) * amount), 0)
    
    if target.charName == "Kassadin" then
        dmg = dmg * 0.85
    elseif reductions[target.charName] then
        local reduction = reductions[target.charName](target) or 0
        dmg = dmg * (1 - reduction)
    end
    
    if HasBuff(target, "cursedtouch") then
        dmg = dmg + amount * 0.1
    end
    
    if HasBuff(myHero, "abyssalscepteraura") then
        damage = damage * 1.15
    end
    
    return dmg
end
 
function CalcPhysicalDamage(source, target, amount, time)
    local penPercent = source.armorPenPercent
    local penPercentBonus = source.bonusArmorPenPercent
    local penFlat = source.armorPen * (0.6 + 0.4 * source.levelData.lvl / 18)
    
    if source.type == Obj_AI_Minion then
        penFlat = 0
        penPercent = 1
        penPercentBonus = 1
    elseif source.type == Obj_AI_Turret then
        penFlat = 0
        penPercentBonus = 1
        penPercent = 0.7
    end
    
    local armor = target.armor
    local bonusArmor = target.bonusArmor
    
    local value
    
    if armor < 0 then
        value = 2 - 100 / (100 - armor)
    elseif armor * penPercent - bonusArmor * (1 - penPercentBonus) - penFlat < 0 then
        value = 1
    else
        value = 100 / (100 + armor * penPercent - bonusArmor * (1 - penPercentBonus) - penFlat)
    end
    
    local dmg = max(floor(PassivePercentMod(source, target, value) * amount), 0)
    if reductions[target.charName] then
        local reduction = reductions[target.charName](target) or 0
        dmg = dmg * (1 - reduction)
    end
    return dmg
end
 
function CalcMixedDamage(source, target, physicalAmount, magicalAmount)
    return CalcPhysicalDamage(source, target, physicalAmount) + CalcMagicalDamage(source, target, magicalAmount)
end
 
class "Spell"
 
function Spell:__init(SpellData)
    self.Slot = SpellData.Slot
    self.Range = SpellData.Range or huge
    self.Delay = SpellData.Delay or 0.25
    self.Speed = SpellData.Speed or huge
    self.Radius = SpellData.Radius or SpellData.Width or 0
    self.Width = SpellData.Width or SpellData.Radius or 0
    self.From = SpellData.From or myHero
    self.Collision = SpellData.Collision or false
    self.Type = SpellData.Type or "Press"
    self.DmgType = SpellData.DmgType or "Physical"
    --
    return self
end
 
function Spell:IsReady()
    return GameCanUseSpell(self.Slot) == READY
end
 
function Spell:CanCast(unit, range, from)
    local from = from or self.From.pos
    local range = range or self.Range
    return unit and unit.valid and unit.visible and not unit.dead and (not range or GetDistance(from, unit) <= range)
end
 
function Spell:GetPrediction(target)
    return Prediction:GetBestCastPosition(target, self)
end
 
function Spell:GetBestLinearCastPos(sTar, lst)
    return GetBestLinearCastPos(self, sTar, lst)
end
 
function Spell:GetBestCircularCastPos(sTar, lst)
    return GetBestCircularCastPos(self, sTar, lst)
end
 
function Spell:GetBestLinearFarmPos()
    return GetBestLinearFarmPos(self)
end
 
function Spell:GetBestCircularFarmPos()
    return GetBestCircularFarmPos(self)
end
 
function Spell:CalcDamage(target)
    local rawDmg = self:GetDamage(target, stage)
    if rawDmg <= 0 then return 0 end
    --
    local damage = 0
    if self.DmgType == 'Magical' then
        damage = CalcMagicalDamage(self.From, target, rawDmg)
    elseif self.DmgType == 'Physical' then
        damage = CalcPhysicalDamage(self.From, target, rawDmg);
    elseif self.DmgType == 'Mixed' then
        damage = CalcMixedDamage(self.From, target, rawDmg * .5, rawDmg * .5)
    end
    
    if self.DmgType ~= 'True' then
        if HasBuff(myHero, "summonerexhaustdebuff") then
            damage = damage * .6
        elseif HasBuff(myHero, "itemsmitechallenge") then
            damage = damage * .6
        elseif HasBuff(myHero, "itemphantomdancerdebuff") then
            damage = damage * .88
        end
    else
        damage = rawDmg
    end
    
    return damage
end
 
function Spell:GetDamage(target, stage)
    local slot = self:SlotToString()
    return self:IsReady() and getdmg(slot, target, self.From, stage or 1) or 0
end
 
function Spell:SlotToHK()
    return ({[_Q] = HK_Q, [_W] = HK_W, [_E] = HK_E, [_R] = HK_R, [SUMMONER_1] = HK_SUMMONER_1, [SUMMONER_2] = HK_SUMMONER_2})[self.Slot]
end
 
function Spell:SlotToString()
    return ({[_Q] = "Q", [_W] = "W", [_E] = "E", [_R] = "R"})[self.Slot]
end
 
function Spell:Cast(castOn)
    if not self:IsReady() or ShouldWait() then return end
    --
    local slot = self:SlotToHK()
    if self.Type == "Press" then
        KeyDown(slot)
        return KeyUp(slot)
    end
    --
    local pos = castOn.x and castOn
    local targ = castOn.health and castOn
    --
    if self.Type == "AOE" and pos then
        local bestPos, hit = self:GetBestCircularCastPos(targ, GetEnemyHeroes(self.Range + self.Radius))
        pos = hit >= 2 and bestPos or pos
    end
    --
    if (targ and not targ.pos:To2D().onScreen) then
        return
    elseif (pos and not pos:To2D().onScreen) then
        if self.Type == "AOE" then
            local mapPos = pos:ToMM()
            Control.CastSpell(slot, mapPos.x, mapPos.y)
        else
            pos = myHero.pos:Extended(pos, 200)
            if not pos:To2D().onScreen then return end
        end
    end
    --
    return Control.CastSpell(slot, targ or pos)
end
 
function Spell:CastToPred(target, minHitchance)
    if not target then return end
    --
    local predPos, castPos, hC = self:GetPrediction(target)
    if predPos and hC >= minHitchance then
        return self:Cast(predPos)
    end
end
 
function Spell:OnImmobile(target)
    local TargetImmobile, ImmobilePos, ImmobileCastPosition = Prediction:IsImmobile(target, self)
    if self.Collision then
        local colStatus = #(mCollision(self.From.pos, Pos, self)) > 0
        if colStatus then return end
        return TargetImmobile, ImmobilePos, ImmobileCastPosition
    end
    return TargetImmobile, ImmobilePos, ImmobileCastPosition
end
 
local function DrawDmg(hero, damage)
    local screenPos = hero.pos:To2D()
    local barPos = {x = screenPos.x - 50, y = screenPos.y - 150, onScreen = screenPos.onScreen}
    if barPos.onScreen then
        local percentHealthAfterDamage = max(0, hero.health - damage) / hero.maxHealth
        local xPosEnd = barPos.x + barXOffset + barWidth * hero.health / hero.maxHealth
        local xPosStart = barPos.x + barXOffset + percentHealthAfterDamage * 100
        DrawLine(xPosStart, barPos.y + barYOffset, xPosEnd, barPos.y + barYOffset, 10, DmgColor)
    end
end
 
local function DrawSpells(instance, extrafn)
    local drawSettings = Menu.Draw
    if drawSettings.ON:Value() then
        local qLambda = drawSettings.Q:Value() and instance.Q and instance.Q:Draw(66, 244, 113)
        local wLambda = drawSettings.W:Value() and instance.W and instance.W:Draw(66, 229, 244)
        local eLambda = drawSettings.E:Value() and instance.E and instance.E:Draw(244, 238, 66)
        local rLambda = drawSettings.R:Value() and instance.R and instance.R:Draw(244, 66, 104)
        local tLambda = drawSettings.TS:Value() and instance.target and DrawMark(instance.target.pos, 3, instance.target.boundingRadius, Color.Red)
        if instance.enemies and drawSettings.Dmg:Value() then
            for i = 1, #instance.enemies do
                local enemy = instance.enemies[i]
                local qDmg, wDmg, eDmg, rDmg = instance.Q and instance.Q:CalcDamage(enemy) or 0, instance.W and instance.W:CalcDamage(enemy) or 0, instance.E and instance.E:CalcDamage(enemy) or 0, instance.R and instance.R:CalcDamage(enemy) or 0
                
                DrawDmg(enemy, qDmg + wDmg + eDmg + rDmg)
                if extrafn then
                    extrafn(enemy)
                end
            end
        end
    end
end
 
function Spell:Draw(r, g, b)
    if not self.DrawColor then
        self.DrawColor = DrawColor(255, r, g, b)
        self.DrawColor2 = DrawColor(80, r, g, b)
    end
    if self.Range and self.Range ~= huge then
        if self:IsReady() then
            DrawCircle(self.From.pos, self.Range, 5, self.DrawColor)
        else
            DrawCircle(self.From.pos, self.Range, 5, self.DrawColor2)
        end
        return true
    end
end
 
function Spell:DrawMap(r, g, b)
    if not self.DrawColor then
        self.DrawColor = DrawColor(255, r, g, b)
        self.DrawColor2 = DrawColor(80, r, g, b)
    end
    if self.Range and self.Range ~= huge then
        if self:IsReady() then
            DrawMap(self.From.pos, self.Range, 5, self.DrawColor)
        else
            DrawMap(self.From.pos, self.Range, 5, self.DrawColor2)
        end
        return true
    end
end
 
print("[WR] Common Loaded")
 
local charName = myHero.charName
icons, WR_Menu, Menu = {}
icons.WR = LogoSpirites[1]
icons.Q = HeroSpirites[1]
icons.W = HeroSpirites[2]
icons.E = HeroSpirites[3]
icons.R = HeroSpirites[4]
--
--WR_Menu = MenuElement({id = "WR_Menu", name = "Win Rate Settings", type = MENU, leftIcon = icons.WR})
--WR_Menu:MenuElement({id = "Prediction", name = "Prediction To Use", value = 1,drop = {"WinPred", "TPred", "WhateverTheFuckElseWeImplement", "No Pred"}})
--
Menu = MenuElement({id = charName, name = "Project WinRate | "..charName, type = MENU, leftIcon = icons.WR})
Menu:MenuElement({name = " ", drop = {"Spell Settings"}})
Menu:MenuElement({id = "Q", name = "Q Settings", type = MENU, leftIcon = icons.Q})
local lambda = charName == "Lucian" and Menu:MenuElement({id = "Q2", name = "Q2 Settings", type = MENU, leftIcon = icons.Q, tooltip = "Extended Q Settings"})
Menu:MenuElement({id = "W", name = "W Settings", type = MENU, leftIcon = icons.W})
Menu:MenuElement({id = "E", name = "E Settings", type = MENU, leftIcon = icons.E})
Menu:MenuElement({id = "R", name = "R Settings", type = MENU, leftIcon = icons.R})
--
Menu:MenuElement({name = " ", drop = {"Global Settings"}})
Menu:MenuElement({id = "Draw", name = "Draw Settings", type = MENU})
Menu.Draw:MenuElement({id = "ON", name = "Enable Drawings", value = true})
Menu.Draw:MenuElement({id = "TS", name = "Draw Selected Target", value = true, leftIcon = icons.WR})
Menu.Draw:MenuElement({id = "Dmg", name = "Draw Damage On HP", value = true, leftIcon = icons.WR})
Menu.Draw:MenuElement({id = "Q", name = "Q", value = false, leftIcon = icons.Q})
Menu.Draw:MenuElement({id = "W", name = "W", value = false, leftIcon = icons.W})
Menu.Draw:MenuElement({id = "E", name = "E", value = false, leftIcon = icons.E})
Menu.Draw:MenuElement({id = "R", name = "R", value = false, leftIcon = icons.R})
--
local ChangePred
local function CheckPred(newVal)
    if newVal == 1 then
        if _G.WR_COMMON_LOADED and ChangePred then
            return ChangePred(newVal)
        end
    elseif newVal == 2 then
        if not _G.GamsteronPredictionLoaded and FileExist(COMMON_PATH.."GamsteronCore.lua") and FileExist(COMMON_PATH.."GamsteronPrediction.lua") then
            require('GamsteronPrediction')
        end
        if _G.GamsteronPredictionLoaded and ChangePred then
            return ChangePred(newVal)
        end
    elseif newVal == 3 then
        if not _G.PremiumPrediction and FileExist(COMMON_PATH.."PremiumPrediction.lua") then
            require('PremiumPrediction')
        end
        if _G.PremiumPrediction and ChangePred then
            return ChangePred(newVal)
        end
    end
end
Menu:MenuElement({id = "Pred", name = "Choose Pred", value = 1, drop = {"WR Pred", "gsoPred"}, callback = CheckPred})
 
local _SPELL_TABLE_PROCESS = {}
local _ANIMATION_TABLE = {}
local _VISION_TABLE = {}
local _LEVEL_UP_TABLE = {}
local _ITEM_TABLE = {}
local _PATH_TABLE = {}
 
class 'BuffExplorer'
 
function BuffExplorer:__init()
    __BuffExplorer = true
    self.Heroes = {}
    self.Buffs = {}
    self.RemoveBuffCallback = {}
    self.UpdateBuffCallback = {}
    Callback.Add("Tick", function () self:Tick() end)
end
 
function BuffExplorer:Tick() -- We can easily get rid of the pairs loops
    for i = 1, HeroCount() do
        local hero = Hero(i)
        if not self.Heroes[hero] and not self.Buffs[hero.networkID] then
            insert(self.Heroes, hero)
            self.Buffs[hero.networkID] = {}
        end
    end
    if self.UpdateBuffCallback ~= {} then
        for i = 1, #self.Heroes do
            local hero = self.Heroes[i]
            for i = 1, hero.buffCount do
                local buff = hero:GetBuff(i)
                if self:Valid(buff) then
                    if not self.Buffs[hero.networkID][buff.name] or (self.Buffs[hero.networkID][buff.name] and self.Buffs[hero.networkID][buff.name].expireTime ~= buff.expireTime) then
                        self.Buffs[hero.networkID][buff.name] = {expireTime = buff.expireTime, sent = true, networkID = buff.sourcenID, buff = buff}
                        for i, cb in pairs(self.RemoveBuffCallback) do
                            cb(hero, buff)
                        end
                    end
                end
            end
        end
    end
    if self.RemoveBuffCallback ~= {} then
        for i = 1, #self.Heroes do
            local hero = self.Heroes[i]
            for buffname, buffinfo in pairs(self.Buffs[hero.networkID]) do
                if buffinfo.expireTime < Timer() then
                    for i, cb in pairs(self.UpdateBuffCallback) do
                        cb(hero, buffinfo.buff)
                    end
                    self.Buffs[hero.networkID][buffname] = nil
                end
            end
        end
    end
end
 
function BuffExplorer:Valid(buff)
    return buff and buff.name and #buff.name > 0 and buff.startTime <= Timer() and buff.expireTime > Timer()
end
 
class("Animation")
 
function Animation:__init()
    _G._ANIMATION_STARTED = true
    self.OnAnimationCallback = {}
    Callback.Add("Tick", function () self:Tick() end)
end
 
function Animation:Tick()
    if self.OnAnimationCallback ~= {} then
        for i = 1, HeroCount() do
            local hero = Hero(i)
            local netID = hero.networkID
            if hero.activeSpellSlot then
                if not _ANIMATION_TABLE[netID] and hero.charName ~= "" then
                    _ANIMATION_TABLE[netID] = {animation = ""}
                end
                local _animation = hero.attackData.animationTime
                if _ANIMATION_TABLE[netID] and _ANIMATION_TABLE[netID].animation ~= _animation then
                    for _, Emit in pairs(self.OnAnimationCallback) do
                        Emit(hero, hero.attackData.animationTime)
                    end
                    _ANIMATION_TABLE[netID].animation = _animation
                end
            end
        end
    end
end
 
class("Vision")
 
function Vision:__init()
    self.GainVisionCallback = {}
    self.LoseVisionCallback = {}
    _G._VISION_STARTED = true
    Callback.Add("Tick", function () self:Tick() end)
end
 
function Vision:Tick()
    local heroCount = HeroCount()
    --if heroCount <= 0 then return end
    for i = 1, heroCount do
        local hero = Hero(i)
        if hero then
            local netID = hero.networkID
            if not _VISION_TABLE[netID] then
                _VISION_TABLE[netID] = {visible = hero.visible}
            end
            if self.LoseVisionCallback ~= {} then
                if hero.visible == false and _VISION_TABLE[netID] and _VISION_TABLE[netID].visible == true then
                    _VISION_TABLE[netID] = {visible = hero.visible}
                    for _, Emit in pairs(self.LoseVisionCallback) do
                        Emit(hero)
                    end
                end
            end
            if self.GainVisionCallback ~= {} then
                if hero.visible == true and _VISION_TABLE[netID] and _VISION_TABLE[netID].visible == false then
                    _VISION_TABLE[netID] = {visible = hero.visible}
                    for _, Emit in pairs(self.GainVisionCallback) do
                        Emit(hero)
                    end
                end
            end
        end
    end
end
 
class "Path"
 
function Path:__init()
    self.OnNewPathCallback = {}
    self.OnDashCallback = {}
    _G._PATH_STARTED = true
    Callback.Add("Tick", function() self:Tick() end)
end
 
function Path:Tick()
    if self.OnNewPathCallback ~= {} or self.OnDashCallback ~= {} then
        for i = 1, HeroCount() do
            local hero = Hero(i)
            self:OnPath(hero)
        end
    end
end
 
function Path:OnPath(unit)
    if not _PATH_TABLE[unit.networkID] then
        _PATH_TABLE[unit.networkID] = {
            pos = unit.posTo,
            speed = unit.ms,
        time = Timer()}
    end
    
    if _PATH_TABLE[unit.networkID].pos ~= unit.posTo then
        local path = unit.pathing
        local isDash = path.isDashing
        local dashSpeed = path.dashSpeed
        local dashGravity = path.dashGravity
        local dashDistance = GetDistance(unit.pos, unit.posTo)
        --
        _PATH_TABLE[unit.networkID] = {
            startPos = unit.pos,
            pos = unit.posTo,
            speed = unit.ms,
        time = Timer()}
        --
        for k, cb in pairs(self.OnNewPathCallback) do
            cb(unit, unit.pos, unit.posTo, isDash, dashSpeed, dashGravity, dashDistance)
        end
        --
        if isDash then
            for k, cb in pairs(self.OnDashCallback) do
                cb(unit, unit.pos, unit.posTo, dashSpeed, dashGravity, dashDistance)
            end
        end
    end
end
 
class("Interrupter")
 
function Interrupter:__init()
    _G._INTERRUPTER_START = true
    self.InterruptCallback = {}
    self.spells = {--ty Deftsu
        ["CaitlynAceintheHole"] = {Name = "Caitlyn", displayname = "R | Ace in the Hole", spellname = "CaitlynAceintheHole"},
        ["Crowstorm"] = {Name = "FiddleSticks", displayname = "R | Crowstorm", spellname = "Crowstorm"},
        ["DrainChannel"] = {Name = "FiddleSticks", displayname = "W | Drain", spellname = "DrainChannel"},
        ["GalioIdolOfDurand"] = {Name = "Galio", displayname = "R | Idol of Durand", spellname = "GalioIdolOfDurand"},
        ["ReapTheWhirlwind"] = {Name = "Janna", displayname = "R | Monsoon", spellname = "ReapTheWhirlwind"},
        ["KarthusFallenOne"] = {Name = "Karthus", displayname = "R | Requiem", spellname = "KarthusFallenOne"},
        ["KatarinaR"] = {Name = "Katarina", displayname = "R | Death Lotus", spellname = "KatarinaR"},
        ["LucianR"] = {Name = "Lucian", displayname = "R | The Culling", spellname = "LucianR"},
        ["AlZaharNetherGrasp"] = {Name = "Malzahar", displayname = "R | Nether Grasp", spellname = "AlZaharNetherGrasp"},
        ["Meditate"] = {Name = "MasterYi", displayname = "W | Meditate", spellname = "Meditate"},
        ["MissFortuneBulletTime"] = {Name = "MissFortune", displayname = "R | Bullet Time", spellname = "MissFortuneBulletTime"},
        ["AbsoluteZero"] = {Name = "Nunu", displayname = "R | Absoulte Zero", spellname = "AbsoluteZero"},
        ["PantheonRJump"] = {Name = "Pantheon", displayname = "R | Jump", spellname = "PantheonRJump"},
        ["PantheonRFall"] = {Name = "Pantheon", displayname = "R | Fall", spellname = "PantheonRFall"},
        ["ShenStandUnited"] = {Name = "Shen", displayname = "R | Stand United", spellname = "ShenStandUnited"},
        ["Destiny"] = {Name = "TwistedFate", displayname = "R | Destiny", spellname = "Destiny"},
        ["UrgotSwap2"] = {Name = "Urgot", displayname = "R | Hyper-Kinetic Position Reverser", spellname = "UrgotSwap2"},
        ["VarusQ"] = {Name = "Varus", displayname = "Q | Piercing Arrow", spellname = "VarusQ"},
        ["VelkozR"] = {Name = "Velkoz", displayname = "R | Lifeform Disintegration Ray", spellname = "VelkozR"},
        ["InfiniteDuress"] = {Name = "Warwick", displayname = "R | Infinite Duress", spellname = "InfiniteDuress"},
        ["XerathLocusOfPower2"] = {Name = "Xerath", displayname = "R | Rite of the Arcane", spellname = "XerathLocusOfPower2"},
    }
    Callback.Add("Tick", function() self:OnTick() end)
end
 
function Interrupter:AddToMenu(unit, menu)
    self.menu = menu
    if unit then
        for k, spells in pairs(self.spells) do
            if spells.Name == unit.charName then
                self.menu:MenuElement({id = spells.spellname, name = spells.Name .. " | " .. spells.displayname, value = true})
            end
        end
    end
end
 
function Interrupter:OnTick()
    local enemies = GetEnemyHeroes(3000)
    for i = 1, #(enemies) do
        local enemy = enemies[i]
        if enemy and enemy.activeSpell and enemy.activeSpell.valid then
            local spell = enemy.activeSpell
            if self.spells[spell.name] and self.menu and self.menu[spell.name] and self.menu[spell.name]:Value() and spell.isChanneling and spell.castEndTime - Timer() > 0 then
                for i, Emit in pairs(self.InterruptCallback) do
                    Emit(enemy, spell)
                end
            end
        end
    end
end
 
--------------------------------------
local function OnInterruptable(fn)
    if not _INTERRUPTER_START then
        _G.Interrupter = Interrupter()
        print("[WR] Callbacks | Interrupter Loaded.")
    end
    insert(Interrupter.InterruptCallback, fn)
end
 
local function OnNewPath(fn)
    if not _PATH_STARTED then
        _G.Path = Path()
        print("[WR] Callbacks | Pathing Loaded.")
    end
    insert(Path.OnNewPathCallback, fn)
end
 
local function OnDash(fn)
    if not _PATH_STARTED then
        _G.Path = Path()
        print("[WR] Callbacks | Pathing Loaded.")
    end
    insert(Path.OnDashCallback, fn)
end
 
local function OnGainVision(fn)
    if not _VISION_STARTED then
        _G.Vision = Vision()
        print("[WR] Callbacks | Vision Loaded.")
    end
    insert(Vision.GainVisionCallback, fn)
end
 
local function OnLoseVision(fn)
    if not _VISION_STARTED then
        _G.Vision = Vision()
        print("[WR] Callbacks | Vision Loaded.")
    end
    insert(Vision.LoseVisionCallback, fn)
end
 
local function OnAnimation(fn)
    if not _ANIMATION_STARTED then
        _G.Animation = Animation()
        print("[WR] Callbacks | Animation Loaded.")
    end
    insert(Animation.OnAnimationCallback, fn)
end
 
local function OnUpdateBuff(cb)
    if not __BuffExplorer_Loaded then
        _G.BuffExplorer = BuffExplorer()
        print("[WR] Callbacks | Buff Explorer Loaded.")
    end
    insert(BuffExplorer.UpdateBuffCallback, cb)
end
 
local function OnRemoveBuff(cb)
    if not __BuffExplorer_Loaded then
        _G.BuffExplorer = BuffExplorer()
        print("[WR] Callbacks | Buff Explorer Loaded.")
    end
    insert(BuffExplorer.RemoveBuffCallback, cb)
end
 
class "Prediction"
 
function Prediction:VectorMovementCollision(startPoint1, endPoint1, v1, startPoint2, v2, delay)
    local sP1x, sP1y, eP1x, eP1y, sP2x, sP2y = startPoint1.x, startPoint1.z, endPoint1.x, endPoint1.z, startPoint2.x, startPoint2.z
    local d, e = eP1x - sP1x, eP1y - sP1y
    local dist, t1, t2 = sqrt(d * d + e * e), nil, nil
    local S, K = dist ~= 0 and v1 * d / dist or 0, dist ~= 0 and v1 * e / dist or 0
    local function GetCollisionPoint(t) return t and {x = sP1x + S * t, y = sP1y + K * t} or nil end
    if delay and delay ~= 0 then sP1x, sP1y = sP1x + S * delay, sP1y + K * delay end
    local r, j = sP2x - sP1x, sP2y - sP1y
    local c = r * r + j * j
    if dist > 0 then
        if v1 == huge then
            local t = dist / v1
            t1 = v2 * t >= 0 and t or nil
        elseif v2 == huge then
            t1 = 0
        else
            local a, b = S * S + K * K - v2 * v2, -r * S - j * K
            if a == 0 then
                if b == 0 then --c=0->t variable
                    t1 = c == 0 and 0 or nil
                else --2*b*t+c=0
                    local t = -c / (2 * b)
                    t1 = v2 * t >= 0 and t or nil
                end
            else --a*t*t+2*b*t+c=0
                local sqr = b * b - a * c
                if sqr >= 0 then
                    local nom = sqrt(sqr)
                    local t = (-nom - b) / a
                    t1 = v2 * t >= 0 and t or nil
                    t = (nom - b) / a
                    t2 = v2 * t >= 0 and t or nil
                end
            end
        end
    elseif dist == 0 then
        t1 = 0
    end
    return t1, GetCollisionPoint(t1), t2, GetCollisionPoint(t2), dist
end
 
function Prediction:IsDashing(unit, spell)
    local delay, radius, speed, from = spell.Delay, spell.Radius, spell.Speed, spell.From.pos
    local OnDash, CanHit, Pos = false, false, nil
    local pathData = unit.pathing
    --
    if pathData.isDashing then
        local startPos = Vector(pathData.startPos)
        local endPos = Vector(pathData.endPos)
        local dashSpeed = pathData.dashSpeed
        local timer = Timer()
        local startT = timer - Latency() / 2000
        local dashDist = GetDistance(startPos, endPos)
        local endT = startT + (dashDist / dashSpeed)
        --
        if endT >= timer and startPos and endPos then
            OnDash = true
            --
            local t1, p1, t2, p2, dist = self:VectorMovementCollision(startPos, endPos, dashSpeed, from, speed, (timer - startT) + delay)
            t1, t2 = (t1 and 0 <= t1 and t1 <= (endT - timer - delay)) and t1 or nil, (t2 and 0 <= t2 and t2 <= (endT - timer - delay)) and t2 or nil
            local t = t1 and t2 and min(t1, t2) or t1 or t2
            --
            if t then
                Pos = t == t1 and Vector(p1.x, 0, p1.y) or Vector(p2.x, 0, p2.y)
                CanHit = true
            else
                Pos = Vector(endPos.x, 0, endPos.z)
                CanHit = (unit.ms * (delay + GetDistance(from, Pos) / speed - (endT - timer))) < radius
            end
        end
    end
    
    return OnDash, CanHit, Pos
end
 
function Prediction:IsImmobile(unit, spell)
    if unit.ms == 0 then return true, unit.pos, unit.pos end
    local delay, radius, speed, from = spell.Delay, spell.Radius, spell.Speed, spell.From.pos
    local debuff = {}
    for i = 1, unit.buffCount do
        local buff = unit:GetBuff(i)
        if buff.duration > 0 then
            local ExtraDelay = speed == huge and 0 or (GetDistance(from, unit.pos) / speed)
            if buff.expireTime + (radius / unit.ms) > Timer() + delay + ExtraDelay then
                debuff[buff.type] = true
            end
        end
    end
    if debuff[_STUN] or debuff[_TAUNT] or debuff[_SNARE] or debuff[_SLEEP] or
        debuff[_CHARM] or debuff[_SUPRESS] or debuff[_AIRBORNE] then
        return true, unit.pos, unit.pos
    end
    return false, unit.pos, unit.pos
end
 
function Prediction:IsSlowed(unit, spell)
    local delay, speed, from = spell.Delay, spell.Speed, spell.From.pos
    for i = 1, unit.buffCount do
        local buff = unit:GetBuff(i)
        if buff.type == _SLOW and buff.expireTime >= Timer() and buff.duration > 0 then
            if buff.expireTime > Timer() + delay + GetDistance(unit.pos, from) / speed then
                return true
            end
        end
    end
    return false
end
 
function Prediction:CalculateTargetPosition(unit, spell, tempPos)
    local delay, radius, speed, from = spell.Delay, spell.Radius, spell.Speed, spell.From
    local calcPos = nil
    local pathData = unit.pathing
    local pathCount = pathData.pathCount
    local pathIndex = pathData.pathIndex
    local pathEndPos = Vector(pathData.endPos)
    local pathPos = tempPos and tempPos or unit.pos
    local pathPot = (unit.ms * ((GetDistance(pathPos) / speed) + delay))
    local unitBR = unit.boundingRadius
    --
    if pathCount < 2 then
        local extPos = unit.pos:Extended(pathEndPos, pathPot - unitBR)
        --
        if GetDistance(unit.pos, extPos) > 0 then
            if GetDistance(unit.pos, pathEndPos) >= GetDistance(unit.pos, extPos) then
                calcPos = extPos
            else
                calcPos = pathEndPos
            end
        else
            calcPos = pathEndPos
        end
    else
        for i = pathIndex, pathCount do
            if unit:GetPath(i) and unit:GetPath(i - 1) then
                local startPos = i == pathIndex and unit.pos or unit:GetPath(i - 1)
                local endPos = unit:GetPath(i)
                local pathDist = GetDistance(startPos, endPos)
                --
                if unit:GetPath(pathIndex - 1) then
                    if pathPot > pathDist then
                        pathPot = pathPot - pathDist
                    else
                        local extPos = startPos:Extended(endPos, pathPot - unitBR)
                        
                        calcPos = extPos
                        
                        if tempPos then
                            return calcPos, calcPos
                        else
                            return self:CalculateTargetPosition(unit, spell, calcPos)
                        end
                    end
                end
            end
        end
        --
        if GetDistance(unit.pos, pathEndPos) > unitBR then
            calcPos = pathEndPos
        else
            calcPos = unit.pos
        end
    end
    
    calcPos = calcPos and calcPos or unit.pos
    
    if tempPos then
        return calcPos, calcPos
    else
        return self:CalculateTargetPosition(unit, spell, calcPos)
    end
end
 
function Prediction:GetBestCastPosition(unit, spell)
    local range = spell.Range and spell.Range - 15 or huge
    local radius = spell.Radius == 0 and 1 or (spell.Radius + unit.boundingRadius) - 4
    local speed = spell.Speed or huge
    local from = spell.From or myHero
    local delay = spell.Delay + (0.07 + Latency() / 2000)
    local collision = spell.Collision or false
    --
    local Position, CastPosition, HitChance = Vector(unit), Vector(unit), 0
    local TargetDashing, CanHitDashing, DashPosition = self:IsDashing(unit, spell)
    local TargetImmobile, ImmobilePos, ImmobileCastPosition = self:IsImmobile(unit, spell)
    
    if TargetDashing then
        if CanHitDashing then
            HitChance = 5
        else
            HitChance = 0
        end
        Position, CastPosition = DashPosition, DashPosition
    elseif TargetImmobile then
        Position, CastPosition = ImmobilePos, ImmobileCastPosition
        HitChance = 4
    else
        Position, CastPosition = self:CalculateTargetPosition(unit, spell)
        
        if unit.activeSpell and unit.activeSpell.valid then
            HitChance = 2
        end
        
        if GetDistanceSqr(from.pos, CastPosition) < 250 then
            HitChance = 2
            local newSpell = {Range = range, Delay = delay * 0.5, Radius = radius, Width = radius, Speed = speed * 2, From = from}
            Position, CastPosition = self:CalculateTargetPosition(unit, newSpell)
        end
        
        local temp_angle = from.pos:AngleBetween(unit.pos, CastPosition)
        if temp_angle > 60 then
            HitChance = 1
        elseif temp_angle < 30 then
            HitChance = 2
        end
    end
    if GetDistanceSqr(from.pos, CastPosition) >= range * range then
        HitChance = 0
    end
    if collision and HitChance > 0 then
        local newSpell = {Range = range, Delay = delay, Radius = radius * 2, Width = radius * 2, Speed = speed * 2, From = from}
        if #(mCollision(from.pos, CastPosition, newSpell)) > 0 then
            HitChance = 0
        end
    end
    
    return Position, CastPosition, HitChance
end
 
ChangePred = function(newVal)
    if newVal == 1 then
        print("Changing to WR Pred")
        Prediction.GetBestCastPosition = function(self, unit, spell)
            local range = spell.Range and spell.Range - 15 or huge
            local radius = spell.Radius == 0 and 1 or (spell.Radius + unit.boundingRadius) - 4
            local speed = spell.Speed or huge
            local from = spell.From or myHero
            local delay = spell.Delay + (0.07 + Latency() / 2000)
            local collision = spell.Collision or false
            --
            local Position, CastPosition, HitChance = Vector(unit), Vector(unit), 0
            local TargetDashing, CanHitDashing, DashPosition = self:IsDashing(unit, spell)
            local TargetImmobile, ImmobilePos, ImmobileCastPosition = self:IsImmobile(unit, spell)
            
            if TargetDashing then
                if CanHitDashing then
                    HitChance = 5
                else
                    HitChance = 0
                end
                Position, CastPosition = DashPosition, DashPosition
            elseif TargetImmobile then
                Position, CastPosition = ImmobilePos, ImmobileCastPosition
                HitChance = 4
            else
                Position, CastPosition = self:CalculateTargetPosition(unit, spell)
                
                if unit.activeSpell and unit.activeSpell.valid then
                    HitChance = 2
                end
                
                if GetDistanceSqr(from.pos, CastPosition) < 250 then
                    HitChance = 2
                    local newSpell = {Range = range, Delay = delay * 0.5, Radius = radius, Width = radius, Speed = speed * 2, From = from}
                    Position, CastPosition = self:CalculateTargetPosition(unit, newSpell)
                end
                
                local temp_angle = from.pos:AngleBetween(unit.pos, CastPosition)
                if temp_angle > 60 then
                    HitChance = 1
                elseif temp_angle < 30 then
                    HitChance = 2
                end
            end
            if GetDistanceSqr(from.pos, CastPosition) >= range * range then
                HitChance = 0
            end
            if collision and HitChance > 0 then
                local newSpell = {Range = range, Delay = delay, Radius = radius * 2, Width = radius * 2, Speed = speed * 2, From = from}
                if #(mCollision(from.pos, CastPosition, newSpell)) > 0 then
                    HitChance = 0
                end
            end
            
            return Position, CastPosition, HitChance
        end
    elseif newVal == 2 then
        print("Changing to gso Pred")
        Prediction.GetBestCastPosition = function(self, unit, s)
            local args = {Delay = s.Delay, Radius = s.Radius, Range = s.Range, Speed = s.Speed, Collision = s.Collision, Type = s.Type == "SkillShot" and 0 or s.Type == "AOE" and 1}
            local pred = GamsteronPrediction:GetPrediction(unit, args, s.From)
            local castPos
            if pred.CastPosition then
                castPos = Vector(pred.CastPosition.x, 0, pred.CastPosition.y)
            end
            return castPos, castPos, pred.Hitchance - 1
        end
    end
end
 
print("[WR] Prediction Loaded")
 
if myHero.charName == "Ashe" then
    
    class 'Ashe'
    
    function Ashe:__init()
        --[[Data Initialization]]
        self.Allies, self.Enemies = {}, {}
        self.scriptVersion = "1.0"
        self:Spells()
        self:Menu()
        --[[Default Callbacks]]
        Callback.Add("Tick", function() self:OnTick() end)
        Callback.Add("Draw", function() self:OnDraw() end)
        --[[Orb Callbacks]]
        OnPreAttack(function(...) self:OnPreAttack(...) end)
        OnPostAttackTick(function(...) self:OnPostAttack(...) end)
        OnPreMovement(function(...) self:OnPreMovement(...) end)
        --[[Custom Callbacks]]
        OnLoseVision(function(unit) self:OnLoseVision(unit) end)
        OnInterruptable(function(unit, spell) self:OnInterruptable(unit, spell) end)
        OnDash(function(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance) self:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance) end)
    end
    
    function Ashe:Spells()
        self.Q = Spell({
            Slot = 0,
            Range = GetTrueAttackRange(myHero),
            Delay = 0.85,
            Speed = huge,
            Radius = 0,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
        self.W = Spell({
            Slot = 1,
            Range = 1200,
            Delay = 0.25,
            Speed = 1500,
            Radius = 100,
            Collision = true,
            From = myHero,
            Type = "AOE"
        })
        self.E = Spell({
            Slot = 2,
            Range = huge,
            Delay = 0.25,
            Speed = 1400,
            Width = 10,
            Collision = false,
            From = myHero,
            Type = "AOE"
        })
        self.R = Spell({
            Slot = 3,
            Range = huge,
            Delay = 0.25,
            Speed = 1600,
            Width = 150,
            Collision = false,
            From = myHero,
            Type = "Skillshot"
        })
        self.Q.LastReset = Timer()
    end
    
    function Ashe:Menu()
       _G.SDK.ObjectManager:OnAllyHeroLoad(function(args)
       		insert(self.Allies, args.unit)
       end)
       _G.SDK.ObjectManager:OnEnemyHeroLoad(function(args)
   			insert(self.Enemies, args.unit)
       end)
        --Q--
        Menu.Q:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.Q:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.Q:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100})
        Menu.Q:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.Q:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.Q:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Farm Settings"}})
        Menu.Q:MenuElement({id = "Jungle", name = "Use on JungleClear", value = false})
        Menu.Q:MenuElement({id = "Clear", name = "Use on LaneClear", value = false})
        Menu.Q:MenuElement({id = "Min", name = "Minions To Cast", value = 3, min = 0, max = 6, step = 1})
        Menu.Q:MenuElement({id = "ManaClear", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Misc"}})
        Menu.Q:MenuElement({id = "Auto", name = "Auto AA Reset Mode", value = 2, drop = {"Heroes Only", "Heroes + Jungle", "Always", "Never"}})
        --W--
        Menu.W:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.W:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.W:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.W:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.W:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.W:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.W:MenuElement({name = " ", drop = {"Misc"}})
        Menu.W:MenuElement({id = "KS", name = "Use on KS", value = true})
        Menu.W:MenuElement({id = "Flee", name = "Use on Flee", value = true})
        --E--
        Menu.E:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.E:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.E:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.E:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.E:MenuElement({id = "Harass", name = "Use on Harass", value = false})
        Menu.E:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        --R--
        Menu.R:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.R:MenuElement({id = "Duel", name = "Use On Duel", value = true})
        Menu.R:MenuElement({id = "Heroes", name = "Duel Targets", type = MENU})
        Menu.R:MenuElement({id = "Mana", name = "Min Mana %", value = 0, min = 0, max = 100, step = 1})
        Menu.R:MenuElement({name = " ", drop = {"Automatic Usage"}})
        Menu.R:MenuElement({id = "Gapcloser", name = "Auto Use On Gapcloser", value = true})
        Menu.R:MenuElement({id = "Hit", name = "Use When X Enemies Hit", type = MENU})
        Menu.R.Hit:MenuElement({id = "Enabled", name = "Enabled", value = false})
        Menu.R.Hit:MenuElement({id = "Min", name = "Number Of Enemies", value = 3, min = 1, max = 5, step = 1})
        Menu.R:MenuElement({id = "Interrupter", name = "Use To Interrupt", value = false})
        Menu.R:MenuElement({id = "Interrupt", name = "Interrupt Targets", type = MENU})
        Menu:MenuElement({name = "[WR] "..charName.." Script", drop = {"Release_"..self.scriptVersion}})
		_G.SDK.ObjectManager:OnEnemyHeroLoad(function(args)
			local hero = args.unit
			Interrupter:AddToMenu(hero, Menu.R.Interrupt)
			Menu.R.Heroes:MenuElement({id = args.charName, name = args.charName, value = false})
		end)
    end
    
    function Ashe:OnTick()
        if ShouldWait() then return end
        --
        self.enemies = GetEnemyHeroes(self.W.Range)
        self.target = GetTarget(GetTrueAttackRange(myHero), 0)
        self.lastTarget = self.target or self.lastTarget
        self.mode = GetMode()
        --
        self:ResetAA()
        if myHero.isChanneling then return end
        self:Auto()
        self:KillSteal()
        --
        if not self.mode then return end
        local executeMode =
        self.mode == 1 and self:Combo() or
        self.mode == 2 and self:Harass() or
        self.mode == 6 and self:Flee()
    end
    
    function Ashe:ResetAA()
        if Timer() > self.Q.LastReset + 5 and HasBuff(myHero, "AsheQAttack") then
            ResetAutoAttack()
            self.Q.LastReset = Timer()
        end
    end
    
    function Ashe:OnPreMovement(args)
        if ShouldWait() then
            args.Process = false
            return
        end
    end
    
    function Ashe:OnPreAttack(args)
        if ShouldWait() then
            args.Process = false
            return
        end
    end
    
    function Ashe:OnPostAttack()
        local target = GetTargetByHandle(myHero.attackData.target)
        if ShouldWait() or not IsValidTarget(target) then return end
        self.target = target
        --
        local tType = target.type
        local mode = Menu.Q.Auto:Value()
        --
        if self.Q:IsReady() then
            local qCombo, qHarass = self.mode == 1 and Menu.Q.Combo:Value() and ManaPercent(myHero) >= Menu.Q.Mana:Value(), not qCombo and self.mode == 2 and Menu.Q.Harass:Value() and ManaPercent(myHero) >= Menu.Q.ManaHarass:Value()
            local qClear = not (qCombo or qHarass) and ((self.mode == 3 and Menu.Q.Clear:Value()) or self.mode == 4 and Menu.Q.Jungle:Value()) and ManaPercent(myHero) >= Menu.Q.ManaClear:Value() and #GetEnemyMinions(500) >= Menu.Q.Min:Value()
            if qClear or mode == 3 or (tType == Obj_AI_Hero and (mode ~= 4 or qCombo or qHarass)) or (mode == 2 and tType == Obj_AI_Minion and target.team == 300) or (tType == Obj_AI_Turret and mode ~= 4) then
                self.Q:Cast()
            end
        end
        if self.W:IsReady() and not HasBuff(myHero, "AsheQAttack") and tType == Obj_AI_Hero then
            local wCombo, wHarass = self.mode == 1 and Menu.W.Combo:Value() and ManaPercent(myHero) >= Menu.W.Mana:Value(), not wCombo and self.mode == 2 and Menu.W.Harass:Value() and ManaPercent(myHero) >= Menu.W.ManaHarass:Value()
            if wCombo or wHarass then
                self.W:CastToPred(target, 2)
            end
        end
    end
    
    function Ashe:OnLoseVision(unit)
        if self.E:IsReady() and self.lastTarget and unit.valid and not unit.dead and unit.networkID == self.lastTarget.networkID then
            if (Menu.E.Combo:Value() and self.mode == 1 and ManaPercent(myHero) >= Menu.E.Mana:Value()) or (Menu.E.Harass:Value() and self.mode == 2 and ManaPercent(myHero) >= Menu.E.ManaHarass:Value()) then
                self.E:Cast(unit.pos)
            end
        end
    end
    
    function Ashe:OnInterruptable(unit, spell)
        if ShouldWait() or not (Menu.R.Interrupter:Value() and self.R:IsReady()) then return end
        if Menu.R.Interrupt[spell.name]:Value() and IsValidTarget(enemy, 1500) then
            self.R:CastToPred(unit, 2)
        end
    end
    
    function Ashe:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance)
        if ShouldWait() or not (Menu.R.Gapcloser:Value() and self.R:IsReady()) then return end
        --
        if IsValidTarget(unit, 600) and unit.team == TEAM_ENEMY and IsFacing(unit, myHero) then --Gapcloser
            self.R:CastToPred(unit, 3)
        end
    end
    
    function Ashe:Auto()
        if not self.enemies then return end
        --
        local minHit = Menu.R.Hit.Min:Value()
        if Menu.R.Hit.Enabled:Value() and #self.enemies >= minHit and self.R:IsReady() then
            local targ, count1 = nil, 0
            for i = 1, #(self.enemies) do
                local enemy = self.enemies[i]
                targ, count1 = enemy, 1
                local count2 = CountEnemiesAround(enemy.pos, 175)
                if count2 > count1 then
                    targ = enemy
                    count1 = count2
                end
            end
            if targ and count1 >= minHit then
                self.R:CastToPred(targ, 2)
            end
        end
    end
    
    function Ashe:Combo()
        local wTarget = GetTarget(self.W.Range, 0)
        local rTarget = self.lastTarget
        --
        if wTarget and GetDistance(wTarget) > GetTrueAttackRange(myHero) and Menu.W.Combo:Value() and self.W:IsReady() and ManaPercent(myHero) >= Menu.W.Mana:Value()then
            self.W:CastToPred(wTarget, 2)
        end
        if Menu.R.Duel:Value() and self.R:IsReady() and IsValidTarget(rTarget, 1500) and Menu.R.Heroes[rTarget.charName]:Value() and ManaPercent(myHero) >= Menu.R.Mana:Value() then
            if rTarget.health >= 200 and (self.R:GetDamage(rTarget) * 4 > GetHealthPrediction(rTarget, GetDistance(rTarget) / self.R.Speed) or HealthPercent(myHero) <= 40)then
                self.R:CastToPred(rTarget, 2)
            end
        end
    end
    
    function Ashe:Harass()
        local wTarget = GetTarget(self.W.Range, 0)
        --
        if wTarget and GetDistance(wTarget) > GetTrueAttackRange(myHero) and Menu.W.Harass:Value() and self.W:IsReady() and ManaPercent(myHero) >= Menu.W.ManaHarass:Value() then
            self.W:CastToPred(wTarget, 2)
        end
    end
    
    function Ashe:Flee()
        if self.enemies and Menu.W.Flee:Value() and self.W:IsReady() then
            for i = 1, #self.enemies do
                local wTarget = self.enemies[i]
                if IsValidTarget(wTarget, 700) then
                    if self.W:CastToPred(wTarget, 1) then
                        break
                    end
                end
            end
        end
    end
    
    function Ashe:KillSteal()
        if self.enemies and Menu.W.KS:Value() and self.W:IsReady() then
            for i = 1, #self.enemies do
                local wTarget = self.enemies[i]
                if IsValidTarget(wTarget) then
                    local dmg, health = self.W:GetDamage(wTarget), wTarget.health
                    if health >= 100 and dmg >= health then
                        if self.W:CastToPred(wTarget, 1) then
                            break
                        end
                    end
                end
            end
        end
    end
    
    function Ashe:OnDraw()
        DrawSpells(self)
    end
    
	table.insert(LoadCallbacks, function()
		Ashe()
	end)
    
elseif myHero.charName == "Blitzcrank" then
    
    class 'Blitzcrank'
    
    function Blitzcrank:__init()
        --[[Data Initialization]]
        self.scriptVersion = "1.0"
        self:Spells()
        self:Menu()
        --[[Default Callbacks]]
        Callback.Add("Tick", function() self:OnTick() end)
        Callback.Add("Draw", function() self:OnDraw() end)
        --[[Orb Callbacks]]
        OnPreAttack(function(...) self:OnPreAttack(...) end)
        OnPreMovement(function(...) self:OnPreMovement(...) end)
        --[[Custom Callbacks]]
        OnInterruptable(function(unit, spell) self:OnInterruptable(unit, spell) end)
        OnDash(function(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance) self:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance) end)
    end
    
    function Blitzcrank:Spells()
        self.Q = Spell({
            Slot = 0,
            Range = 950,
            Delay = 0.25,
            Speed = 1750,
            Radius = 60,
            Collision = true,
            From = myHero,
            Type = "SkillShot"
        })
        self.W = Spell({
            Slot = 1,
            From = myHero,
            Type = "Press"
        })
        self.E = Spell({
            Slot = 2,
            Range = GetTrueAttackRange(myHero),
            From = myHero,
            Type = "Press"
        })
        self.R = Spell({
            Slot = 3,
            Range = 600,
            Delay = 0.25,
            Speed = huge,
            Radius = 600,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
    end
    
    function Blitzcrank:Menu()
        --Q--
        Menu.Q:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.Q:MenuElement({id = "Blacklist", name = "Blacklist", type = MENU})
        Menu.Q:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.Q:MenuElement({id = "MinRange", name = "Min Range", value = 250, min = 0, max = 950, step = 10})
        Menu.Q:MenuElement({id = "MaxRange", name = "Max Range", value = 950, min = 0, max = 950, step = 10})
        Menu.Q:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.Q:MenuElement({id = "BlacklistHarass", name = "Blacklist", type = MENU})
        Menu.Q:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.Q:MenuElement({id = "MinRangeHarass", name = "Min Range", value = 250, min = 0, max = 950, step = 10})
        Menu.Q:MenuElement({id = "MaxRangeHarass", name = "Max Range", value = 950, min = 0, max = 950, step = 10})
        Menu.Q:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Misc"}})
        Menu.Q:MenuElement({id = "Interrupt", name = "Auto Use To Interrupt", value = true})
        Menu.Q:MenuElement({id = "InterruptList", name = "Whitelist", type = MENU})
        Menu.Q:MenuElement({id = "Gapcloser", name = "Auto Use On Dash", value = true})
        Menu.Q:MenuElement({id = "GapList", name = "Whitelist", type = MENU})
        Menu.Q:MenuElement({id = "Auto", name = "Auto Use On Immobile", value = true})
        --W--
        Menu.W:MenuElement({name = " ", drop = {"Misc"}})
        Menu.W:MenuElement({id = "Flee", name = "Use on Flee", value = true})
        --E--
        Menu.E:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.E:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.E:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.E:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.E:MenuElement({id = "Harass", name = "Use on Harass", value = false})
        Menu.E:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        --R--
        Menu.R:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.R:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.R:MenuElement({id = "Heroes", name = "Combo Targets", type = MENU})
        Menu.R:MenuElement({id = "Mana", name = "Min Mana %", value = 0, min = 0, max = 100, step = 1})
        Menu.R:MenuElement({name = " ", drop = {"Misc"}})
        Menu.R:MenuElement({id = "Count", name = "Auto Use When X Enemies", value = 3, min = 0, max = 5, step = 1})
        Menu.R:MenuElement({id = "KS", name = "Use To KS", value = true})
        Menu.R:MenuElement({id = "Interrupt", name = "Auto Use To Interrupt", value = true})
        Menu.R:MenuElement({id = "InterruptList", name = "Whitelist", type = MENU})
        
        Menu:MenuElement({name = "[WR] "..charName.." Script", drop = {"Release_"..self.scriptVersion}})

        _G.SDK.ObjectManager:OnEnemyHeroLoad(function(args)
        	local hero = args.unit
        	local charName = args.charName
			local priority = GetPriority(hero)
			Interrupter:AddToMenu(hero, Menu.Q.InterruptList)
			Interrupter:AddToMenu(hero, Menu.R.InterruptList)
			Menu.Q.GapList:MenuElement({id = charName, name = charName, value = false})
			Menu.Q.Blacklist:MenuElement({id = charName, name = charName, value = priority <= 2})
			Menu.Q.BlacklistHarass:MenuElement({id = charName, name = charName, value = priority <= 3})
			Menu.R.Heroes:MenuElement({id = charName, name = charName, value = priority >= 3})
    	end)
    end
    
    function Blitzcrank:OnTick()
        if ShouldWait() then return end
        --
        self.enemies = GetEnemyHeroes(self.Q.Range)
        self.target = GetTarget(self.Q.Range, 1)
        self.mode = GetMode()
        --
        self:Auto()
        self:KillSteal()
        --
        if not (self.mode and self.target) then return end
        local executeMode =
        self.mode == 1 and self:Combo(self.target) or
        self.mode == 2 and self:Harass(self.target) or
        self.mode == 6 and self:Flee()
    end
    
    function Blitzcrank:OnPreMovement(args) --args.Process|args.Target
        if ShouldWait() then
            args.Process = false
            return
        end
    end
    
    function Blitzcrank:OnPreAttack(args) --args.Process|args.Target
        if ShouldWait() then
            args.Process = false
            return
        end
    end
    
    function Blitzcrank:OnInterruptable(unit, spell)
        if unit.team ~= TEAM_ENEMY or ShouldWait() or not IsValidTarget(unit, self.Q.Range) then return end
        if Menu.R.InterruptList[spell.name]:Value() and GetDistace(unit) <= self.R.Range and self.R:IsReady() then
            self.R:Cast()
        elseif Menu.Q.InterruptList[spell.name]:Value() and self.Q:IsReady() then
            self.Q:CastToPred(unit, 1)
        end
    end
    
    function Blitzcrank:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance)
        if unit.team ~= TEAM_ENEMY or ShouldWait() or not IsValidTarget(unit, self.Q.Range) then return end
        if Menu.Q.GapList[unit.charName]:Value() and self.Q:IsReady() then
            self.Q:CastToPred(unit, 3)
        end
    end
    
    function Blitzcrank:Auto()
        local minCount = Menu.R.Count:Value()
        if self.R:IsReady() and minCount ~= 0 and #GetEnemyHeroes(self.R.Range) >= minCount then
            self.R:Cast()
            return
        end
        --
        local qCheck, rCheck = self.Q:IsReady() and Menu.Q.Auto:Value(), self.R:IsReady() and Menu.R.Combo:Value() and ManaPercent(myHero) >= Menu.R.Mana:Value()
        if qCheck or rCheck then
            for i = 1, #self.enemies do
                local enemy = self.enemies[i]
                if qCheck and IsImmobile(enemy, 0.5) then
                    self.Q:Cast(enemy)
                elseif self.mode == 1 and rCheck and GetDistance(enemy) <= 500 and myHero:GetSpellData(_E).currentCd > 0 and Menu.R.Heroes[enemy.charName]:Value() then
                    self.R:Cast()
                end
            end
        end
    end
    
    function Blitzcrank:Combo(target)
        local dist = GetDistance(target)
        if self.Q:IsReady() and dist >= Menu.Q.MinRange:Value() and dist <= Menu.Q.MaxRange:Value() and Menu.Q.Combo:Value() and ManaPercent(myHero) >= Menu.Q.Mana:Value() and not Menu.Q.Blacklist[target.charName]:Value() then
            if self.Q:CastToPred(target, 2) then
                return
            end
        end
        if self.E:IsReady() and Menu.E.Combo:Value() and ManaPercent(myHero) >= Menu.E.Mana:Value() then
            self.E.Range = (myHero.range + target.boundingRadius + myHero.boundingRadius)
            if self:IsBeingGrabbed(target) or dist <= self.E.Range then
                self.E:Cast()
                ResetAutoAttack()
                return
            end
        end
    end
    
    function Blitzcrank:Harass(target)
        local dist = GetDistance(target)
        if self.Q:IsReady() and dist >= Menu.Q.MinRangeHarass:Value() and dist <= Menu.Q.MaxRangeHarass:Value() and Menu.Q.Harass:Value() and ManaPercent(myHero) >= Menu.Q.ManaHarass:Value() and not Menu.Q.BlacklistHarass[target.charName]:Value() then
            if self.Q:CastToPred(target, 2) then
                return
            end
        end
        if self.E:IsReady() and Menu.E.Harass:Value() and ManaPercent(myHero) >= Menu.E.ManaHarass:Value() then
            self.E.Range = (myHero.range + target.boundingRadius + myHero.boundingRadius)
            if self:IsBeingGrabbed(target) or dist <= self.E.Range then
                self.E:Cast()
                ResetAutoAttack()
            end
        end
    end
    
    function Blitzcrank:Flee()
        if self.W:IsReady() then
            self.W:Cast()
        end
    end
    
    function Blitzcrank:KillSteal()
        if Menu.R.KS:Value() and self.R:IsReady() then
            for i = 1, #self.enemies do
                local targ = self.enemies[i]
                if GetDistance(targ) <= self.R.Range and self.R:GetDamage(targ) >= targ.health + targ.shieldAP then
                    self.R:Cast()
                end
            end
        end
    end
    
    function Blitzcrank:OnDraw()
        DrawSpells(self)
    end
    
    function Blitzcrank:IsBeingGrabbed(unit)
        return HasBuff(unit, "rocketgrab2")
    end
    
	table.insert(LoadCallbacks, function()
		Blitzcrank()
	end)
    
elseif myHero.charName == "Corki" then
    
    class 'Corki'
    
    function Corki:__init()
        --[[Data Initialization]]
        self.scriptVersion = "1.0"
        self:Spells()
        self:Menu()
        --[[Default Callbacks]]
        Callback.Add("Tick", function() self:OnTick() end)
        Callback.Add("Draw", function() self:OnDraw() end)
        --[[Orb Callbacks]]
        OnPreAttack(function(...) self:OnPreAttack(...) end)
        OnPostAttack(function(...) self:OnPostAttack(...) end)
        OnPreMovement(function(...) self:OnPreMovement(...) end)
        --[[Custom Callbacks]]
        OnDash(function(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance) self:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance) end)
    end
    
    function Corki:Spells()
        self.Q = Spell({
            Slot = 0,
            Range = 825,
            Delay = 0.25,
            Speed = 1125,
            Radius = 250,
            Collision = false,
            From = myHero,
            Type = "AOE"
        })
        self.W = Spell({
            Slot = 1,
            Range = 600,
            Delay = 0.3,
            Speed = 1000,
            Radius = 50,
            Collision = false,
            From = myHero,
            Type = "Skillshot"
        })
        self.E = Spell({
            Slot = 2,
            Range = 600,
            Delay = 0.3,
            Speed = huge,
            Radius = 80,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
        self.R = Spell({
            Slot = 3,
            Range = 1300,
            Delay = 0.25,
            Speed = 2000,
            Radius = 50,
            Collision = true,
            From = myHero,
            Type = "Skillshot"
        })
    end
    
    function Corki:Menu()
        --Q--
        Menu.Q:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.Q:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.Q:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.Q:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.Q:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Farm Settings"}})
        Menu.Q:MenuElement({id = "Jungle", name = "Use on JungleClear", value = false})
        Menu.Q:MenuElement({id = "Clear", name = "Use on LaneClear", value = false})
        Menu.Q:MenuElement({id = "Min", name = "Minions To Cast", value = 3, min = 0, max = 6, step = 1})
        Menu.Q:MenuElement({id = "ManaClear", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Misc"}})
        Menu.Q:MenuElement({id = "KS", name = "Use on KS", value = true})
        Menu.Q:MenuElement({id = "Auto", name = "Auto Use on Immobile", value = false})
        --W--
        Menu.W:MenuElement({name = " ", drop = {"Misc"}})
        Menu.W:MenuElement({id = "Gapcloser", name = "Anti Gapcloser W", value = true})
        --E--
        Menu.E:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.E:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.E:MenuElement({id = "Mana", name = "Min Mana %", value = 20, min = 0, max = 100, step = 1})
        Menu.E:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.E:MenuElement({id = "Harass", name = "Use on Harass", value = false})
        Menu.E:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 20, min = 0, max = 100, step = 1})
        Menu.E:MenuElement({name = " ", drop = {"Farm Settings"}})
        Menu.E:MenuElement({id = "Jungle", name = "Use on JungleClear", value = false})
        Menu.E:MenuElement({id = "Clear", name = "Use on LaneClear", value = false})
        Menu.E:MenuElement({id = "Min", name = "Minions To Cast", value = 3, min = 0, max = 6, step = 1})
        Menu.E:MenuElement({id = "ManaClear", name = "Min Mana %", value = 20, min = 0, max = 100, step = 1})
        --R--
        Menu.R:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.R:MenuElement({id = "Combo", name = "Use in Combo", value = true})
        Menu.R:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.R:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.R:MenuElement({id = "Harass", name = "Use in Harass", value = false})
        Menu.R:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.R:MenuElement({name = " ", drop = {"Farm Settings"}})
        Menu.R:MenuElement({id = "Jungle", name = "Use in JungleClear", value = false})
        Menu.R:MenuElement({id = "LastHit", name = "Use in LastHit", value = false})
        Menu.R:MenuElement({id = "ManaClear", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.R:MenuElement({name = " ", drop = {"Misc"}})
        Menu.R:MenuElement({id = "KS", name = "Use in KS", value = true})
        Menu.R:MenuElement({id = "Auto", name = "Auto Use on Immobile", value = true})
        Menu:MenuElement({name = "[WR] "..charName.." Script", drop = {"Release_"..self.scriptVersion}})
    end
    
    function Corki:OnTick()
        if ShouldWait() then return end
        --
        self.enemies = GetEnemyHeroes(self.R.Range)
        self.target = GetTarget(GetTrueAttackRange(myHero), 0)
        self.mode = GetMode()
        --
        if myHero.isChanneling then return end
        self:Auto()
        self:KillSteal()
        --
        if not self.mode then return end
        local executeMode =
        self.mode == 1 and self:Combo() or
        self.mode == 2 and self:Harass() or
        self.mode == 3 and self:Clear() or
        self.mode == 5 and self:LastHit()
    end
    
    function Corki:OnPreMovement(args) --args.Process|args.Target
        if ShouldWait() then
            args.Process = false
            return
        end
    end
    
    function Corki:OnPreAttack(args) --args.Process|args.Target
        if ShouldWait() then
            args.Process = false
            return
        end
    end
    
    function Corki:OnPostAttack()
        local target = GetTargetByHandle(myHero.attackData.target)
        if ShouldWait() or not IsValidTarget(target) then return end
        self.target = target
        --
        local tType = target.type
        if tType == Obj_AI_Hero then
            if self.Q:IsReady() and ((self.mode == 1 and Menu.Q.Combo:Value() and ManaPercent(myHero) >= Menu.Q.Mana:Value()) or (self.mode == 2 and Menu.Q.Harass:Value() and ManaPercent(myHero) >= Menu.Q.ManaHarass:Value())) then
                self.Q:CastToPred(target, 2)
            end
            if self.E:IsReady() and ((self.mode == 1 and Menu.E.Combo:Value() and ManaPercent(myHero) >= Menu.E.Mana:Value()) or (self.mode == 2 and Menu.E.Harass:Value() and ManaPercent(myHero) >= Menu.E.ManaHarass:Value())) then
                self.E:Cast()
            end
        elseif (tType == Obj_AI_Minion and target.team == 300 and (self.mode == 4 or self.mode == 3)) then
            self:JungleClear(target)
        end
    end
    
    function Corki:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance)
        if self:HasPackage() or ShouldWait() then return end
        if IsValidTarget(unit) and GetDistance(unitPosTo) < 500 and unit.team == TEAM_ENEMY and IsFacing(unit, myHero) then
            local posTo = myHero.pos:Extended(unitPosTo, -self.W.Range)
            if not self:IsDangerousPosition(posTo) then
                self.W:Cast(posTo)
            end
        end
    end
    
    function Corki:Auto()
        local checkQ, checkR = Menu.Q.Auto:Value(), Menu.R.Auto:Value()
        if not (checkQ or checkR) then return end
        --
        for i = 1, #(self.enemies) do
            local enemy = self.enemies[i]
            if IsImmobile(enemy) then
                local health = enemy.health
                if self.Q:IsReady() and checkQ then
                    self.Q:CastToPred(enemy, 4)
                elseif self.R:IsReady() and checkR then
                    self.R:CastToPred(enemy, 4)
                end
            end
        end
    end
    
    function Corki:Combo()
        local target = GetTarget(self.R.Range, 0)
        if not target then return end
        --
        if self.R:IsReady() and Menu.R.Combo:Value() and ManaPercent(myHero) >= Menu.R.Mana:Value() then
            self.R:CastToPred(target, 2)
        elseif self.Q:IsReady() and Menu.Q.Combo:Value() and ManaPercent(myHero) >= Menu.Q.Mana:Value() then
            self.Q:CastToPred(target, 2)
        end
    end
    
    function Corki:Harass()
        local target = GetTarget(self.R.Range, 0)
        if not target then return end
        --
        if self.R:IsReady() and Menu.R.Harass:Value() and ManaPercent(myHero) >= Menu.R.ManaHarass:Value() then
            self.R:CastToPred(target, 2)
        elseif self.Q:IsReady() and Menu.Q.Harass:Value() and ManaPercent(myHero) >= Menu.Q.ManaHarass:Value() then
            self.Q:CastToPred(target, 2)
        end
    end
    
    function Corki:JungleClear(target)
        if self.R:IsReady() and Menu.R.Jungle:Value() and ManaPercent(myHero) >= Menu.R.ManaClear:Value() then
            self.R:Cast(target.pos)
        elseif self.Q:IsReady() and Menu.Q.Jungle:Value() and ManaPercent(myHero) >= Menu.Q.ManaClear:Value() then
            self.Q:Cast(target.pos)
        elseif self.E:IsReady() and Menu.E.Jungle:Value() and ManaPercent(myHero) >= Menu.E.ManaClear:Value() then
            self.E:Cast()
        end
    end
    
    function Corki:Clear()
        if self.Q:IsReady() and Menu.Q.Clear:Value() and ManaPercent(myHero) >= Menu.Q.ManaClear:Value() then
            local bestPos, count = self.Q:GetBestCircularFarmPos()
            if bestPos and count >= Menu.Q.Min:Value() then
                self.Q:Cast(bestPos)
            end
        end
        --
        if self.E:IsReady() and Menu.E.Clear:Value() and ManaPercent(myHero) >= Menu.E.ManaClear:Value() then
            if #(GetEnemyMinions(self.E.Range)) >= Menu.E.Min:Value() then
                self.E:Cast()
            end
        end
    end
    
    function Corki:LastHit()
        if self.R:IsReady() and Menu.R.LastHit:Value() and ManaPercent(myHero) >= Menu.R.ManaClear:Value() then
            local minions = GetEnemyMinions(self.R.Range)
            if #minions == 0 then return end
            --
            local check1, range = myHero.attackData.state == STATE_WINDDOWN, GetTrueAttackRange(myHero)
            for i = 1, #minions do
                local minion = minions[i]
                if self:GetMissileDamage(minion) >= minion.health and (check1 or minion.distance > range) and #mCollision(myHero.pos, minion.pos, self.R, minions) == 0 and GetHealthPrediction(minion, GetDistance(minion) / self.R.Speed) > 50 then
                    self.R:Cast(minion.pos)
                    return
                end
            end
        end
    end
    
    function Corki:KillSteal()
        for i = 1, #(self.enemies) do
            local enemy = self.enemies[i]
            local health = enemy.health
            if self.R:IsReady() and Menu.R.KS:Value() and health >= 100 and self:GetMissileDamage(enemy) >= health then
                self.R:CastToPred(enemy, 2)
            elseif self.Q:IsReady() and Menu.Q.KS:Value() and IsValidTarget(enemy, self.Q.Range) and self.Q:GetDamage(enemy) >= health then
                self.Q:CastToPred(enemy, 2)
            end
        end
    end
    
    function Corki:OnDraw()
        DrawSpells(self)
    end
    
    function Corki:IsDangerousPosition(pos)
        if IsUnderTurret(pos, TEAM_ENEMY) then return true end
        for i = 1, HeroCount() do
            local hero = Hero(i)
            if IsValidTarget(hero) and GetTrueAttackRange(unit) < 400 and hero.pos:DistanceTo(pos) < 350 then
                return true
            end
        end
    end
    
    function Corki:HasPackage()
        return HasBuff(myHero, "corkiloaded")
    end
    
    function Corki:HasBigOne()
        return HasBuff(myHero, "mbcheck2")
    end
    
    function Corki:GetMissileDamage(unit)
        return self:HasBigOne() and self.R:GetDamage(unit, 2) or self.R:GetDamage(unit)
    end
    
	table.insert(LoadCallbacks, function()
		Corki()
	end)
    
elseif myHero.charName == "Darius" then
    
    class 'Darius'
    
    function Darius:__init()
        --[[Data Initialization]]
        self.Allies, self.Enemies = {}, {}
        self.scriptVersion = "1.0"
        self:Spells()
        self:Menu()
        --[[Default Callbacks]]
        --Callback.Add("Load",          function() self:OnLoad()    end) --Just Use OnLoad()
        Callback.Add("Tick", function() self:OnTick() end)
        Callback.Add("Draw", function() self:OnDraw() end)
        --[[Orb Callbacks]]
        OnPreAttack(function(...) self:OnPreAttack(...) end)
        OnPostAttack(function(...) self:OnPostAttack(...) end)
        OnPreMovement(function(...) self:OnPreMovement(...) end)
        --[[Custom Callbacks]]
        OnInterruptable(function(unit, spell) self:OnInterruptable(unit, spell) end)
        OnDash(function(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance) self:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance) end)
    end
    
    function Darius:Spells()
        self.Q = Spell({
            Slot = 0,
            Range = 415,
            Delay = 0.75,
            Speed = huge,
            Radius = 250,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
        self.W = Spell({
            Slot = 1,
            Range = 300,
            Delay = 0.25,
            Speed = 1450,
            Radius = huge,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
        self.E = Spell({
            Slot = 2,
            Range = 490,
            Delay = 0.3,
            Speed = huge,
            Radius = huge,
            Collision = false,
            From = myHero,
            Type = "AOE"
        })
        self.R = Spell({
            Slot = 3,
            Range = 460,
            Delay = 0.25,
            Speed = huge,
            Radius = huge,
            Collision = false,
            From = myHero,
            Type = "Targetted",
            DmgType = "True"
        })
        self.W.LastReset = 0
        self.W.LastCast = 0
        --
        self.R.GetDamage = function(spellInstance, enemy, stage)
            if not spellInstance:IsReady() then return 0 end
            --
            local rLvl = myHero:GetSpellData(_R).level
            --
            return (100 * rLvl + 0.75 * myHero.bonusDamage)
        end
    end
    
    function Darius:Menu()
       _G.SDK.ObjectManager:OnAllyHeroLoad(function(args)
       		insert(self.Allies, args.unit)
       end)
       _G.SDK.ObjectManager:OnEnemyHeroLoad(function(args)
   			insert(self.Enemies, args.unit)
       end)
        --Q--
        Menu.Q:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.Q:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.Q:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.Q:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.Q:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Misc"}})
        Menu.Q:MenuElement({id = "Auto", name = "Positioning Helper", value = true})
        --W--
        Menu.W:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.W:MenuElement({id = "Combo", name = "Combo Mode", value = true})
        Menu.W:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.W:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.W:MenuElement({id = "Harass", name = "Harass Mode", value = true})
        Menu.W:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        --E--
        Menu.E:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.E:MenuElement({id = "Combo", name = "Combo Mode", value = true})
        Menu.E:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.E:MenuElement({name = " ", drop = {"Misc"}})
        Menu.E:MenuElement({id = "Auto", name = "Auto Use on Escaping Enemies", value = true})
        Menu.E:MenuElement({id = "Interrupt", name = "Interrupt Targets", type = MENU})
        --R--
        Menu.R:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.R:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.R:MenuElement({id = "Mana", name = "Min Mana %", value = 0, min = 0, max = 100, step = 1})
        Menu.R:MenuElement({name = " ", drop = {"Misc"}})
        Menu.R:MenuElement({id = "Auto", name = "Auto Use on Killable", value = true})
        Menu.R:MenuElement({id = "Tweak", name = "Damage Mod +[%]", value = 0, min = -50, max = 50, step = 5})
        --Items--
        Menu:MenuElement({id = "Items", name = "Items Settings", type = MENU})
        Menu.Items:MenuElement({id = "Tiamat", name = "Use Tiamat", value = true})
        Menu.Items:MenuElement({id = "TitanicHydra", name = "Use Titanic Hydra", value = true})
        Menu.Items:MenuElement({id = "Hydra", name = "Use Ravenous Hydra", value = true})
        Menu.Items:MenuElement({id = "Youmuu", name = "Use Youmuu's", value = true})
        --Misc--
        Menu.Draw:MenuElement({id = "Helper", name = "Draw Q Helper Pos", value = true, leftIcon = icons.WR})
        Menu:MenuElement({name = "[WR] "..charName.." Script", drop = {"Release_"..self.scriptVersion}})
        --
        _G.SDK.ObjectManager:OnEnemyHeroLoad(function(args)
        	Interrupter:AddToMenu(args.unit, Menu.E.Interrupt)
    	end)
    end
    
    function Darius:OnTick()
        if ShouldWait() then return end
        --
        self.enemies = GetEnemyHeroes(500)
        self.target = GetTarget(self.Q.Range, 0)
        self.mode = GetMode()
        --
        self:UpdateItems()
        self:ResetAA()
        if myHero.isChanneling then return end
        self:Auto()
        --
        if not self.mode then return end
        local executeMode =
        self.mode == 1 and self:Combo() or
        self.mode == 2 and self:Harass()
    end
    
    function Darius:ResetAA()
        if Timer() > self.W.LastReset + 1 and HasBuff(myHero, "DariusNoxianTacticsONH") then
            ResetAutoAttack()
            self.W.LastReset = Timer()
        end
    end
    
    function Darius:OnPreMovement(args) --args.Process|args.Target
        if ShouldWait() then
            args.Process = false
            return
        end
        --Q Helper logic
        if self.moveTo then
            if GetDistance(self.moveTo) < 20 then
                args.Process = false
            elseif not MapPosition:inWall(self.moveTo) then
                args.Target = self.moveTo
            end
        end
    end
    
    function Darius:OnPreAttack(args) --args.Process|args.Target
        if ShouldWait() then
            args.Process = false
            return
        end
    end
    
    function Darius:OnPostAttack()
        local target = GetTargetByHandle(myHero.attackData.target)
        if ShouldWait() or not IsValidTarget(target) then return end
        if target.type == Obj_AI_Hero then
            if self.W:IsReady() and ((self.mode == 1 and Menu.W.Combo:Value()) or (self.mode == 2 and Menu.W.Harass:Value())) and ManaPercent(myHero) >= Menu.W.Mana:Value() then
                self.W:Cast()
                self.W.LastCast = Timer()
            elseif self.mode == 1 then
                self:UseItems(target)
            end
        end
    end
    
    function Darius:OnInterruptable(unit, spell)
        if ShouldWait() then return end
        if Menu.E.Interrupt[spell.name]:Value() and IsValidTarget(enemy, self.E.Range) and self.E:IsReady() then
            self.E:Cast(unit)
        end
    end
    
    function Darius:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance)
        if ShouldWait() then return end
        if Menu.E.Auto:Value() and IsValidTarget(unit, self.E.Range) and GetDistance(unitPosTo) > 300 and unit.team == TEAM_ENEMY and not IsFacing(unit, myHero) then
            self.E:CastToPred(unit, 2)
        end
    end
    
    function Darius:Auto()
        if self.enemies and (Menu.R.Auto:Value() or (Menu.R.Combo:Value() and self.mode == 1)) and self.R:IsReady() then
            for i = 1, #(self.enemies) do
                local enemy = self.enemies[i]
                if self.R:CalcDamage(enemy) * self:GetUltMultiplier(enemy) >= enemy.health + enemy.shieldAD then
                    self.R:Cast(enemy)
                    break
                end
            end
        end
    end
    
    function Darius:Combo()
        for i = 1, #(self.enemies) do
            local enemy = self.enemies[i]
            self:Youmuu(enemy)
            local distance = GetDistance(enemy)
            if self.E:IsReady() and Menu.E.Combo:Value() and ManaPercent(myHero) >= Menu.E.Mana:Value() and distance >= 350 and distance <= self.E.Range and not IsFacing(enemy, myHero) then
                self.E:Cast(enemy)
            end
        end
        if self.Q:IsReady() and not IsAutoAttacking() and Menu.Q.Combo:Value() and self.target and ((not self.W:IsReady() and Timer() - self.W.LastCast > 1) or GetDistance(self.target) > 300) and ManaPercent(myHero) >= Menu.Q.Mana:Value() then
            self.Q:Cast()
        end
    end
    
    function Darius:Harass()
        if self.target and self.Q:IsReady() and not IsAutoAttacking() and Menu.Q.Harass:Value() and ManaPercent(myHero) >= Menu.Q.Mana:Value() then
            self.Q:Cast()
        end
    end
    
    function Darius:OnDraw()
        if Menu.Q.Auto:Value() and HasBuff(myHero, "dariusqcast") and self.target then
            self.moveTo = self.target:GetPrediction(huge, 0.2):Extended(myHero.pos, ((self.Q.Radius + self.Q.Range) / 2))
        else
            self.moveTo = nil
        end
        DrawSpells(self)
    end
    
    function Darius:GetStacks(target)
        local buff = GetBuffByName(target, "DariusHemo")
        return buff and buff.count or 0
    end
    
    function Darius:GetUltMultiplier(target)
        return (1 + 0.2 * self:GetStacks(target) + Menu.R.Tweak:Value() / 100)
    end
    
    local ItemHotKey = {[ITEM_1] = HK_ITEM_1, [ITEM_2] = HK_ITEM_2, [ITEM_3] = HK_ITEM_3, [ITEM_4] = HK_ITEM_4, [ITEM_5] = HK_ITEM_5, [ITEM_6] = HK_ITEM_6}
    function Darius:UpdateItems()
        --[[
            Youmuu = 3142
            Tiamat = 3077
            Hidra = 3074
            Titanic = 3748
        ]]
        for i = ITEM_1, ITEM_7 do
            local id = myHero:GetItemData(i).itemID
            --[[In Case They Sell Items]]
            if self.Youmuus and i == self.Youmuus.Index and id ~= 3142 then
                self.Youmuus = nil
            elseif self.Tiamat and i == self.Tiamat.Index and id ~= 3077 then
                self.Tiamat = nil
            elseif self.Hidra and i == self.Hidra.Index and id ~= 3074 then
                self.Hidra = nil
            elseif self.Titanic and i == self.Titanic.Index and id ~= 3748 then
                self.Titanic = nil
            end
            ---
            if id == 3142 then
                self.Youmuus = {Index = i, Key = ItemHotKey[i]}
            elseif id == 3077 then
                self.Tiamat = {Index = i, Key = ItemHotKey[i]}
            elseif id == 3074 then
                self.Hidra = {Index = i, Key = ItemHotKey[i]}
            elseif id == 3748 then
                self.Titanic = {Index = i, Key = ItemHotKey[i]}
            end
        end
    end
    
    function Darius:UseItems(target)
        if self.Tiamat or self.Hidra then
            self:Hydra(target)
        elseif self.Titanic then
            self:TitanicHydra(target)
        end
    end
    
    function Darius:UseItem(key, reset)
        KeyDown(key)
        KeyUp(key)
        return reset and ResetAutoAttack()
    end
    
    function Darius:Youmuu(target)
        if self.Youmuus and Menu.Items.Youmuu:Value() and myHero:GetSpellData(self.Youmuus.Index).currentCd == 0 and IsValidTarget(target, 600) then
            self:UseItem(self.Youmuus.Key, false)
        end
    end
    
    function Darius:TitanicHydra(target)
        if self.Titanic and Menu.Items.TitanicHydra:Value() and myHero:GetSpellData(self.Titanic.Index).currentCd == 0 and IsValidTarget(target, 380) then
            self:UseItem(self.Titanic.Key, true)
        end
    end
    
    function Darius:Hydra(target)
        if self.Hidra and Menu.Items.Hydra:Value() and myHero:GetSpellData(self.Hidra.Index).currentCd == 0 and IsValidTarget(target, 380) then
            self:UseItem(self.Hidra.Key, true)
        elseif self.Tiamat and Menu.Items.Tiamat:Value() and myHero:GetSpellData(self.Tiamat.Index).currentCd == 0 and IsValidTarget(target, 380) then
            self:UseItem(self.Tiamat.Key, true)
        end
    end
    
	table.insert(LoadCallbacks, function()
		Darius()
	end)
    
elseif myHero.charName == "Draven" then
    
    class 'Draven'
    
    function Draven:__init()
        --[[Data Initialization]]
        self.Allies, self.Enemies, self.AxeList = {}, {}, {}
        self.scriptVersion = "1.0"
        self:Spells()
        self:Menu()
        self.moveTo = nil
        --[[Default Callbacks]]
        Callback.Add("Tick", function() self:OnTick() end)
        Callback.Add("Draw", function() self:OnDraw() end)
        --[[Orb Callbacks]]
        OnPreAttack(function(...) self:OnPreAttack(...) end)
        OnPostAttack(function(...) self:OnPostAttack(...) end)
        OnPreMovement(function(...) self:OnPreMovement(...) end)
        --[[Custom Callbacks]]
        OnInterruptable(function(unit, spell) self:OnInterruptable(unit, spell) end)
        OnDash(function(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance) self:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance) end)
    end
    
    function Draven:Spells()
        self.Q = Spell({
            Slot = 0,
            Range = nil,
            Delay = 0.25,
            Speed = nil,
            Radius = nil,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
        self.W = Spell({
            Slot = 1,
            Range = nil,
            Delay = 0.25,
            Speed = nil,
            Radius = nil,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
        self.E = Spell({
            Slot = 2,
            Range = 950,
            Delay = 0.25,
            Speed = 1400,
            Radius = 100,
            Collision = false,
            From = myHero,
            Type = "Skillshot"
        })
        self.R = Spell({
            Slot = 3,
            Range = 1500, --huge
            Delay = 0.4,
            Speed = 2000,
            Radius = 160,
            Collision = false,
            From = myHero,
            Type = "Skillshot"
        })
    end
    
    function Draven:Menu()
       _G.SDK.ObjectManager:OnAllyHeroLoad(function(args)
       		insert(self.Allies, args.unit)
       end)
       _G.SDK.ObjectManager:OnEnemyHeroLoad(function(args)
   			insert(self.Enemies, args.unit)
       end)
        --Q--
        Menu.Q:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.Q:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.Q:MenuElement({id = "Mana", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.Q:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.Q:MenuElement({id = "ManaHarass", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Farm Settings"}})
        Menu.Q:MenuElement({id = "LastHit", name = "Use on LastHit", value = false})
        Menu.Q:MenuElement({id = "Jungle", name = "Use on JungleClear", value = false})
        Menu.Q:MenuElement({id = "Clear", name = "Use on LaneClear", value = false})
        Menu.Q:MenuElement({id = "ManaClear", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Misc"}})
        Menu.Q:MenuElement({id = "Catch", name = "Auto Catch Axes", value = true})
        Menu.Q:MenuElement({id = "Max", name = "Max Axes To Have", value = 2, min = 1, max = 3})
        --W--
        Menu.W:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.W:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.W:MenuElement({id = "Mana", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        Menu.W:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.W:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.W:MenuElement({id = "ManaHarass", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        Menu.W:MenuElement({name = " ", drop = {"Misc"}})
        Menu.W:MenuElement({id = "Catch", name = "Use to Catch Axes", value = true})
        Menu.W:MenuElement({id = "Flee", name = "Use on Flee", value = true})
        --E--
        Menu.E:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.E:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.E:MenuElement({id = "Mana", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        Menu.E:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.E:MenuElement({id = "Harass", name = "Use on Harass", value = false})
        Menu.E:MenuElement({id = "ManaHarass", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        Menu.E:MenuElement({name = " ", drop = {"Misc"}})
        Menu.E:MenuElement({id = "Flee", name = "Use on Flee", value = true})
        Menu.E:MenuElement({id = "Gapcloser", name = "Auto Use on Gapcloser", value = true})
        Menu.E:MenuElement({id = "Interrupt", name = "Interrupt Targets", type = MENU})
        --R--
        Menu.R:MenuElement({id = "Heroes", name = "Duel Settings", type = MENU})
        Menu.R.Heroes:MenuElement({id = "Combo", name = "Enabled", value = true})
        Menu.R:MenuElement({id = "Count", name = "Auto Use When X Enemies", value = 2, min = 0, max = 5, step = 1})
        Menu.R:MenuElement({id = "KS", name = "Use on KS", value = true})
        Menu.R:MenuElement({id = "Mana", name = "Min Mana % ", value = 0, min = 0, max = 100, step = 1})
        Menu:MenuElement({name = "[WR] "..charName.." Script", drop = {"Release_"..self.scriptVersion}})
        --
       _G.SDK.ObjectManager:OnEnemyHeroLoad(function(args)
			local hero = args.unit
			local charName = args.charName
			Interrupter:AddToMenu(hero, Menu.E.Interrupt)
			Menu.R.Heroes:MenuElement({id = charName, name = charName, value = false})
       end)
    end
    
    function Draven:OnTick()
        if ShouldWait() then return end
        --
        self.enemies = GetEnemyHeroes(1500)
        self.target = GetTarget(GetTrueAttackRange(myHero), 0)
        self.mode = GetMode()
        --
        if myHero.isChanneling then return end
        self:ShouldCatch()
        self:Auto()
        self:KillSteal()
        --
        if not self.mode then return end
        local executeMode =
        self.mode == 1 and self:Combo() or
        self.mode == 2 and self:Harass() or
        self.mode == 6 and self:Flee()
    end
    
    function Draven:OnPreMovement(args) --args.Process|args.Target
        if ShouldWait() then
            args.Process = false
            return
        end
        if self.moveTo then
            if GetDistance(self.moveTo) < 20 then
                args.Process = false
            else
                args.Target = self.moveTo
            end
        end
    end
    
    function Draven:OnPreAttack(args) --args.Process|args.Target
        SetHoldRadius(50) --Leave this or it wont catch close axes
        SetMovementDelay(100)
        local targ = args.Target
        if ShouldWait() or (self.moveTo and ((GetDistance(self.moveTo) / myHero.ms) + myHero.attackData.animationTime * 1.5 >= self.AxeList[1].endTime - Timer() and myHero.posTo:DistanceTo(self.moveTo) > 30)) then
            if Menu.W.Catch:Value() and self.W:IsReady() and not HasBuff(myHero, "DravenFury") then
                self.W:Cast()
            end
            args.Process = false
            return
        end
        if self:GetAxeCount() < Menu.Q.Max:Value() and IsValidTarget(targ, GetTrueAttackRange(myHero)) and self.Q:IsReady() then
            if (Menu.Q.Combo:Value() and self.mode == 1 and ManaPercent(myHero) >= Menu.Q.Mana:Value()) or (Menu.Q.Harass:Value() and self.mode == 2 and ManaPercent(myHero) >= Menu.Q.ManaHarass:Value()) or
                (Menu.Q.Clear:Value() and self.mode == 3 and ManaPercent(myHero) >= Menu.Q.ManaClear:Value() and targ.team ~= TEAM_JUNGLE) or (Menu.Q.Jungle:Value() and (self.mode == 4 or self.mode == 3) and ManaPercent(myHero) >= Menu.Q.ManaClear:Value() and targ.team == TEAM_JUNGLE) or
                (Menu.Q.LastHit:Value() and self.mode == 5 and ManaPercent(myHero) >= Menu.Q.ManaClear:Value()) then
                self.Q:Cast()
            end
        end
    end
    
    function Draven:OnPostAttack()
        local target = GetTargetByHandle(myHero.attackData.target)
        --if not IsValidTarget(target) then return end
        local delay = (target and GetDistance(target) / myHero.attackData.projectileSpeed)
        if delay then
            DelayAction(function() self:UpdateAxes() end, delay + Game.Latency() / 1000)
        else --myHero.attackData.target is broken and fere probably wont fix it zzzzz
            self:UpdateAxes()
            for i = 0, 1, (1 / 3) do
                DelayAction(function() self:UpdateAxes() end, i)
            end
        end
    end
    
    function Draven:OnInterruptable(unit, spell)
        if not ShouldWait() and Menu.E.Interrupt[spell.name]:Value() and IsValidTarget(enemy, self.E.Range) and self.E:IsReady() then
            self.E:Cast(unit.pos)
        end
    end
    
    function Draven:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance)
        if ShouldWait() or not (Menu.E.Gapcloser:Value() and self.E:IsReady()) then return end
        if IsValidTarget(unit) and GetDistance(unitPosTo) < 500 and unit.team == TEAM_ENEMY and IsFacing(unit, myHero) then --Gapcloser
            self.E:CastToPred(unit, 2)
        end
    end
    
    function Draven:Auto()
        if self.enemies and #self.enemies ~= 0 and Menu.R.Count:Value() ~= 0 and self.R:IsReady() then
            local bestPos, hit = GetBestLinearCastPos(self.R, nil, self.enemies)
            if bestPos and hit >= Menu.R.Count:Value() then
                self.R:Cast(bestPos)
            end
        end
    end
    
    function Draven:Combo()
        local eTarget = GetTarget(self.E.Range, 0)
        local runningAway = (IsFacing(myHero, eTarget) and not IsFacing(eTarget, myHero) and GetDistance(eTarget) > GetTrueAttackRange(myHero))
        if self.W:IsReady() and Menu.W.Combo:Value() and ManaPercent(myHero) >= Menu.W.Mana:Value() and not HasBuff(myHero, "DravenFury") then
            if eTarget and (eTarget.ms > myHero.ms or runningAway) then
                self.W:Cast()
            end
        end
        if self.E:IsReady() and Menu.E.Combo:Value() and ManaPercent(myHero) >= Menu.E.Mana:Value() then
            local eTarget = GetTarget(self.E.Range, 0)
            if IsValidTarget(eTarget) and (HealthPercent(myHero) <= 40 or runningAway) then
                self.E:CastToPred(eTarget, 2)
            end
        end
        if self.R:IsReady() and Menu.R.Heroes.Combo:Value() and ManaPercent(myHero) >= Menu.R.Mana:Value() then
            local rTarget = GetTarget(1500, 0)
            if IsValidTarget(rTarget) and Menu.R.Heroes[rTarget.charName]:Value() and rTarget.health >= 200 and (self.R:GetDamage(rTarget) * 4 > GetHealthPrediction(rTarget, GetDistance(rTarget) / self.R.Speed) or HealthPercent(myHero) <= 40) then
                if self.R:CastToPred(enemy, 2) then
                    self:CallUltBack(enemy)
                end
            end
        end
    end
    
    function Draven:Harass()
        if self.E:IsReady() and Menu.E.Harass:Value() and ManaPercent(myHero) >= Menu.E.ManaHarass:Value() then
            local eTarget = GetTarget(self.E.Range, 0)
            if IsValidTarget(eTarget) and (HealthPercent(myHero) <= 40 or (IsFacing(myHero, eTarget) and not IsFacing(eTarget, myHero) and GetDistance(eTarget) > GetTrueAttackRange(myHero))) then
                self.E:CastToPred(eTarget, 2)
            end
        end
    end
    
    function Draven:Flee()
        local nearby = GetEnemyHeroes(600)
        if Menu.E.Flee:Value() and self.E:IsReady() then
            for i = 1, #nearby do
                local enemy = nearby[i]
                local range = GetTrueAttackRange(enemy)
                if range <= 500 and GetDistance(enemy) <= range then
                    self.E:CastToPred(enemy, 1); break
                end
            end
        end
        if Menu.W.Flee:Value() and self.W:IsReady() and #nearby >= 1 then
            self.W:Cast()
        end
    end
    
    function Draven:KillSteal()
        if self.enemies and Menu.R.KS:Value() and self.R:IsReady() then
            for i = 1, #(self.enemies) do
                local enemy = self.enemies[i]
                local hp = enemy.health + enemy.shieldAD
                if self.R:GetDamage(enemy) * 2 >= hp and (hp >= 100 or HeroesAround(600, enemy.pos, TEAM_ALLY) == 0) then
                    if self.R:CastToPred(enemy, 2) then
                        self:CallUltBack(enemy)
                        break
                    end
                end
            end
        end
    end
    
    function Draven:OnDraw()
        self:Auto()
        if Menu.Q.Catch:Value() then
            self:UpdateAxeCatching()
            self.moveTo = #self.AxeList >= 1 and self.AxeList[1].pos --axeNumber >= 2 and self.AxeList[1].pos + (self.AxeList[2].pos-self.AxeList[1].pos):Normalized() * 30 or axeNumber == 1 and
        else
            self.moveTo = nil
        end
        
        DrawSpells(self)
    end
    
    function Draven:UpdateAxeCatching()
        sort(self.AxeList, function(a, b) return GetDistance(a) < GetDistance(b) end)
        for i = 1, #self.AxeList do
            local object = self.AxeList[i]
            if object and (object.endTime - Timer() >= 0 and GetDistance(object.obj.pos, object.pos) > 10) then
                DrawText(i, 48, object.pos:ToScreen(), DrawColor(255, 0, 255, 0))
            else
                remove(self.AxeList, i)
            end
        end
    end
    
    function Draven:CheckAxe(obj)
        for i = 1, #self.AxeList do
            if self.AxeList[i].ID == obj.handle then
                return true
            end
        end
    end
    
    function Draven:UpdateAxes()
        local count = MissileCount()
        for i = count, 1, -1 do
            local missile = Missile(i)
            local data = missile.missileData
            if data and data.owner == myHero.handle and data.name == "DravenSpinningReturn" and not self:CheckAxe(missile) then
                insert(self.AxeList, {endTime = Timer() + 1.1, ID = missile.handle, pos = Vector(missile.missileData.endPos), obj = missile}) --its always 1.1 seconds (missile speed changes based on distance)
                return true
            end
        end
    end
    
    function Draven:CallUltBack(enemy)
        DelayAction(function()
            KeyDown(HK_R)
            KeyUp(HK_R)
        end, abs(GetDistance(enemy) - 500) / 2000)
    end
    
    function Draven:ShouldCatch()
        if Menu.Q.Catch:Value() and self.moveTo and not myHero.pathing.hasMovePath and self.mode then
            Orbwalk()
        end
    end
    
    function Draven:GetAxeCount()
        local axesOnHand = (HasBuff(myHero, "dravenspinningleft") and 2) or (HasBuff(myHero, "dravenspinning") and 1) or 0
        return #self.AxeList + axesOnHand
    end
    
	table.insert(LoadCallbacks, function()
		Draven()
	end)
    
elseif myHero.charName == "Ezreal" then
    
    class 'Ezreal'
    
    function Ezreal:__init()
        --[[Data Initialization]]
        self.lastAttacked = myHero
        self.scriptVersion = "1.0"
        self:Spells()
        self:Menu()
        --[[Default Callbacks]]
        Callback.Add("Tick", function() self:OnTick() end)
        Callback.Add("Draw", function() self:OnDraw() end)
        --[[Orb Callbacks]]
        OnPreAttack(function(...) self:OnPreAttack(...) end)
        OnPostAttack(function(...) self:OnPostAttack(...) end)
        OnPreMovement(function(...) self:OnPreMovement(...) end)
        --[[Custom Callbacks]]
        OnDash(function(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance) self:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance) end)
    end
    
    function Ezreal:Spells()
        self.Q = Spell({
            Slot = 0,
            Range = 1150,
            Delay = 0.25,
            Speed = 2000,
            Width = 60,
            Collision = true,
            From = myHero,
            Type = "SkillShot"
        })
        self.W = Spell({
            Slot = 1,
            Range = 1000,
            Delay = 0.25,
            Speed = 1600,
            Radius = 80,
            Collision = false,
            From = myHero,
            Type = "SkillShot"
        })
        self.E = Spell({
            Slot = 2,
            Range = 475,
            Delay = 0.25,
            Speed = 2500,
            Radius = 100,
            Collision = false,
            From = myHero,
            Type = "SkillShot"
        })
        self.R = Spell({
            Slot = 3,
            Range = 2000, --reduced on purpose
            Delay = 1,
            Speed = 2000,
            Width = 205,
            Collision = false,
            From = myHero,
            Type = "SkillShot"
        })
        self.Escape = Spell({
            Slot = nil,
            Range = 2000, --reduced on purpose
            Delay = 1,
            Speed = 2000,
            Radius = 2000,
            Collision = false,
            From = myHero,
            Type = "AOE"
        })
    end
    
    function Ezreal:Menu()
        --Q--
        Menu.Q:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.Q:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.Q:MenuElement({id = "Pred", name = "Prediction Mode", value = 1, drop = {"Faster", "More Precise"}})
        Menu.Q:MenuElement({id = "Mana", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.Q:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.Q:MenuElement({id = "PredHarass", name = "Prediction Mode", value = 2, drop = {"Faster", "More Precise"}})
        Menu.Q:MenuElement({id = "ManaHarass", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Farm Settings"}})
        Menu.Q:MenuElement({id = "LastHit", name = "Use to LastHit", value = false})
        Menu.Q:MenuElement({id = "Jungle", name = "Use on JungleClear", value = false})
        Menu.Q:MenuElement({id = "Clear", name = "Use on LaneClear", value = false})
        Menu.Q:MenuElement({id = "ManaClear", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Misc"}})
        Menu.Q:MenuElement({id = "KS", name = "Use to KS", value = true})
        --W--
        Menu.W:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.W:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.W:MenuElement({id = "Mana", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        Menu.W:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.W:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.W:MenuElement({id = "ManaHarass", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        Menu.W:MenuElement({name = " ", drop = {"Misc"}})
        Menu.W:MenuElement({id = "KS", name = "Use to KS", value = true})
        --E--
        Menu.E:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.E:MenuElement({id = "Mode", name = "Combo Mode", value = 2, drop = {"Never", "Aggressive", "Peel"}})
        Menu.E:MenuElement({id = "Mana", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        Menu.E:MenuElement({name = " ", drop = {"Misc"}})
        Menu.E:MenuElement({id = "Gapcloser", name = "Use on Gapcloser", value = true})
        --R--
        Menu.R:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.R:MenuElement({id = "Combo", name = "Use When X Enemies", value = 2, min = 0, max = 5, step = 1})
        Menu.R:MenuElement({id = "Mana", name = "Min Mana % ", value = 0, min = 0, max = 100, step = 1})
        Menu.R:MenuElement({name = " ", drop = {"Misc"}})
        Menu.R:MenuElement({id = "KS", name = "Use to KS", value = true})
        
        Menu:MenuElement({name = "[WR] "..charName.." Script", drop = {"Release_"..self.scriptVersion}})
        --
    end
    
    function Ezreal:OnTick()
        if ShouldWait() then return end
        --
        self.enemies = GetEnemyHeroes(2000)
        self.target = GetTarget(GetTrueAttackRange(myHero), 0)
        self.mode = GetMode()
        --
        if myHero.isChanneling then return end
        self:KillSteal()
        --
        if not self.mode then return end
        self:Auto()
        local executeMode =
        self.mode == 1 and self:Combo() or
        self.mode == 2 and self:Harass() or
        self.mode == 3 and self:Clear() or
        self.mode == 4 and self:Clear() or
        self.mode == 5 and self:LastHit()
    end
    
    function Ezreal:OnPreMovement(args) --args.Process|args.Target
        if ShouldWait() then
            args.Process = false
            return
        end
    end
    
    function Ezreal:OnPreAttack(args) --args.Process|args.Target
        if ShouldWait() then
            args.Process = false
            return
        end
        self.lastAttacked = args.Target
    end
    
    function Ezreal:OnPostAttack()
        local target = GetTargetByHandle(myHero.attackData.target)
        if ShouldWait() or not IsValidTarget(target) or not (self.Q:IsReady() or self.W:IsReady()) then return end
        --
        local isMob, isHero = target.type == Obj_AI_Minion, target.type == myHero.type
        local modeCheck, manaCheck, spell
        --
        if isMob then
            local laneClear, jungleClear = self.mode == 3, self.mode == 4
            modeCheck = laneClear or jungleClear
            castCheck = target.team == TEAM_JUNGLE and Menu.Q.Jungle:Value() or target.team == TEAM_ENEMY and Menu.Q.Clear:Value()
            manaCheck = ManaPercent(myHero) >= Menu.Q.ManaClear:Value()
            if modeCheck and castCheck and manaCheck then
                self.Q:Cast(target.pos)
            end
        elseif isHero then
            local spell = (self.Q:IsReady() and "Q") or "W"
            local combo, harass = self.mode == 1, self.mode == 2
            modeCheck = (combo or harass)
            castCheck = combo and Menu[spell].Combo:Value() or harass and Menu[spell].Harass:Value()
            manaCheck = combo and ManaPercent(myHero) >= Menu[spell].Mana:Value() or harass and ManaPercent(myHero) >= Menu[spell].ManaHarass:Value()
            if modeCheck and castCheck and manaCheck then
                self[spell]:CastToPred(target, 2)
            end
        end
    end
    
    function Ezreal:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance)
        if ShouldWait() or not Menu.E.Gapcloser:Value() then return end
        if IsValidTarget(unit) and GetDistance(unitPosTo) < 200 and unit.team == TEAM_ENEMY and IsFacing(unit, myHero) then --Gapcloser
            local bestPos = self:GetBestPos()
            if bestPos then
                self.E:Cast(bestPos)
            end
        end
    end
    
    function Ezreal:Auto()
        local eMode = Menu.E.Mode:Value()
        if self.mode ~= 1 or eMode == 1 then return end
        --
        if eMode == 2 then
            local eTarget = GetTarget(self.E.Range + self.Q.Range, 0)
            if eTarget and #GetEnemyHeroes(600) == 0 then
                self.E:Cast(eTarget)
            end
        elseif eMode == 3 then
            local eTarget = GetTarget(self.E.Range, 0)
            if eTarget and GetDanger(myHero.pos) > 0 then
                local temp = self:GetBestPos()
                if temp then
                    self.E:Cast(temp)
                end
            end
        end
    end
    
    function Ezreal:Combo()
        if self.enemies and #self.enemies ~= 0 and Menu.R.Combo:Value() ~= 0 and self.R:IsReady() and ManaPercent(myHero) >= Menu.R.Mana:Value() then
            local bestPos, hit = GetBestLinearCastPos(self.R, nil, self.enemies)
            if bestPos and hit >= Menu.R.Combo:Value() then
                
                self.R:Cast(bestPos)
            end
        end
        --
        local qTarget, qPred = GetTarget(self.Q.Range, 0), Menu.Q.Pred:Value()
        if IsValidTarget(qTarget) and GetDistance(qTarget) >= GetTrueAttackRange(myHero) then
            if Menu.Q.Combo:Value() and self.Q:IsReady() and ManaPercent(myHero) >= Menu.Q.Mana:Value() then
                self.Q:CastToPred(qTarget, qPred)
            elseif Menu.W.Combo:Value() and self.W:IsReady() and ManaPercent(myHero) >= Menu.W.Mana:Value() and GetDistance(qTarget) <= self.W.Range then
                self.W:CastToPred(qTarget, 2)
            end
        end
    end
    
    function Ezreal:Harass()
        local qTarget, qPred = GetTarget(self.Q.Range, 0), Menu.Q.PredHarass:Value()
        if IsValidTarget(qTarget) and GetDistance(qTarget) >= GetTrueAttackRange(myHero) then
            if Menu.Q.Harass:Value() and self.Q:IsReady() and ManaPercent(myHero) >= Menu.Q.ManaHarass:Value() then
                self.Q:CastToPred(qTarget, qPred)
            elseif Menu.W.Harass:Value() and self.W:IsReady() and ManaPercent(myHero) >= Menu.W.ManaHarass:Value() and GetDistance(qTarget) <= self.W.Range then
                self.W:CastToPred(qTarget, 2)
            end
        end
    end
    
    function Ezreal:Clear()
    end
    
    function Ezreal:LastHit()
        if Menu.Q.LastHit:Value() and self.Q:IsReady() then
            local busy = myHero.attackData.state == STATE_WINDDOWN
            local minions = GetEnemyMinions(self.Q.Range)
            for i = 1, #minions do
                local minion = minions[i]
                local hp = GetHealthPrediction(minion, self.Q.Delay + GetDistance(minion) / self.Q.Speed)
                if (minion.networkID ~= self.lastAttacked.networkID) and (busy or GetDistance(minion) >= GetTrueAttackRange(myHero)) and hp >= 20 and self.Q:GetDamage(minion) >= hp and #mCollision(myHero.pos, minion.pos, self.Q, minions) == 0 then
                    self.Q:Cast(minion); return
                end
            end
        end
    end
    
    function Ezreal:KillSteal()
        local ksQ, ksW, ksR = Menu.Q.KS:Value() and self.Q:IsReady(), Menu.W.KS:Value() and self.W:IsReady(), Menu.R.KS:Value() and self.R:IsReady()
        if ksQ or ksW or ksR then
            for i = 1, #self.enemies do
                local targ = self.enemies[i]
                local hp, dist = targ.health, GetDistance(targ)
                if (ksW and self.W:GetDamage(targ) >= hp) then
                    if self.W:CastToPred(targ, 2) then return end
                elseif (ksQ and self.Q:GetDamage(targ) >= hp) then
                    if self.Q:CastToPred(targ, 2) then return end
                elseif (ksR and self.R:GetDamage(targ) >= hp and (hp >= 200 or HeroesAround(600, targ.pos, TEAM_ALLY) == 0)) then
                    if self.R:CastToPred(targ, 3) then return end
                end
            end
        end
    end
    
    function Ezreal:OnDraw()
        DrawSpells(self)
    end
    
    --function Ezreal:GetBestPos()
    --    local nearby = GetEnemyHeroes(2000)
    --    for k, v in pairs(GetEnemyTurrets(2000)) do nearby[#nearby+1] = v end
    --    local mostDangerous = GetBestCircularCastPos(self.Escape, nil, nearby)
    --    local pos = (myHero.pos):Extended(mostDangerous, -self.E.Range) --farthest possible from most dangerous
    --    if GetDanger(myHero.pos) > GetDanger(pos) + 5 then
    --        DrawCircle(pos, 10)
    --        return pos
    --    end
    --end
    
    function Ezreal:GetBestPos()
        local hPos, result = myHero.pos, {}
        local offset, rotateAngle = hPos + Vector(0, 0, self.E.Range), rotateAngle / 360 * pi
        --
        for i = 0, 360, 40 do
            local pos = RotateAroundPoint(offset, hPos, i * pi / 180)
            result[#result + 1] = {pos, GetDanger(pos)}
        end
        sort(result, function(a, b)
            if MapPosition:inWall(a[1]) then
                return false
            end
            if a[2] ~= b[2] then
                return a[2] < b[2]
            else
                return GetDistance(a[1], mousePos) < GetDistance(b[1], mousePos)
            end
        end)
        return result[1][2] == 0 and result[1][1]
    end
    
	table.insert(LoadCallbacks, function()
		Ezreal()
	end)
 
elseif myHero.charName == "Jax" then
    
    class 'Jax'
    
    function Jax:__init()
        --[[Data Initialization]]
        self.Allies, self.Enemies = {}, {}
        self.scriptVersion = "1.0"
        self:Spells()
        self:Menu()
        --[[Default Callbacks]]
        Callback.Add("Tick", function() self:OnTick() end)
        Callback.Add("Draw", function() self:OnDraw() end)
        Callback.Add("WndMsg", function(...) self:OnWndMsg(...) end)
        --[[Orb Callbacks]]
        OnPreAttack(function(...) self:OnPreAttack(...) end)
        OnPostAttack(function(...) self:OnPostAttack(...) end)
        OnPreMovement(function(...) self:OnPreMovement(...) end)
    end
    
    function Jax:Spells()
        self.Q = Spell({
            Slot = 0,
            Range = 700,
            Delay = 0.85,
            Speed = huge,
            Radius = 150,
            Collision = false,
            From = myHero,
            Type = "Targetted"
        })
        self.W = Spell({
            Slot = 1,
            Range = 925,
            Delay = 0.25,
            Speed = 1450,
            Radius = 100,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
        self.E = Spell({
            Slot = 2,
            Range = 300,
            Delay = 0.25,
            Speed = 2500,
            Radius = 100,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
        self.R = Spell({
            Slot = 3,
            Range = 800,
            Delay = 0.85,
            Speed = huge,
            Radius = 150,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
        self.W.LastReset = Timer()
    end
    
    function Jax:Menu()
       _G.SDK.ObjectManager:OnAllyHeroLoad(function(args)
       		insert(self.Allies, args.unit)
       end)
       _G.SDK.ObjectManager:OnEnemyHeroLoad(function(args)
   			insert(self.Enemies, args.unit)
       end)
        --Q--
        Menu.Q:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.Q:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.Q:MenuElement({id = "Mana", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.Q:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.Q:MenuElement({id = "ManaHarass", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Farm Settings"}})
        Menu.Q:MenuElement({id = "LastHit", name = "Use to LastHit", value = false})
        Menu.Q:MenuElement({id = "Clear", name = "Use on LaneClear", value = false})
        Menu.Q:MenuElement({id = "ManaClear", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Misc"}})
        Menu.Q:MenuElement({id = "KS", name = "Use on KS", value = true})
        Menu.Q:MenuElement({id = "Flee", name = "Use on Flee", value = true})
        Menu.Q:MenuElement({id = "Jump", name = "WardJump Settings", type = MENU})
        Menu.Q.Jump:MenuElement({id = "Flee", name = "Ward On Flee", value = true})
        Menu.Q.Jump:MenuElement({id = "Key", name = "WardJump Key", key = string.byte("Z")})
        --W--
        Menu.W:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.W:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.W:MenuElement({id = "Mana", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        Menu.W:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.W:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.W:MenuElement({id = "ManaHarass", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        Menu.W:MenuElement({name = " ", drop = {"Farm Settings"}})
        Menu.W:MenuElement({id = "LastHit", name = "Use to LastHit", value = false})
        Menu.W:MenuElement({id = "Jungle", name = "Use on JungleClear", value = false})
        Menu.W:MenuElement({id = "Clear", name = "Use on LaneClear", value = false})
        Menu.W:MenuElement({id = "ManaClear", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        --E--
        Menu.E:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.E:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.E:MenuElement({id = "Mana", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        Menu.E:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.E:MenuElement({id = "Harass", name = "Use on Harass", value = false})
        Menu.E:MenuElement({id = "ManaHarass", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        Menu.E:MenuElement({name = " ", drop = {"Misc"}})
        Menu.E:MenuElement({id = "Flee", name = "Use on Flee", value = true})
        --R--
        Menu.R:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.R:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.R:MenuElement({id = "Count", name = " When X Enemies", value = 2, min = 1, max = 5, step = 1})
        Menu.R:MenuElement({id = "Heroes", name = " Duel Targets", type = MENU})
        Menu.R:MenuElement({id = "Mana", name = "Min Mana % ", value = 0, min = 0, max = 100, step = 1})
        --Jump--
        
        Menu:MenuElement({name = "[WR] "..charName.." Script", drop = {"Release_"..self.scriptVersion}})
        
       _G.SDK.ObjectManager:OnEnemyHeroLoad(function(args)
   			Menu.R.Heroes:MenuElement({id = args.charName, name = args.charName, value = false})
       end)
    end
    
    function Jax:OnTick()
        if ShouldWait() then return end
        --
        self.enemies = GetEnemyHeroes(1500)
        self.target = GetTarget(self.Q.Range, 0)
        self.mode = GetMode()
        --
        self:ResetAA()
        if myHero.isChanneling then return end
        self:Auto()
        self:KillSteal()
        --
        if not self.mode then return end
        local executeMode =
        self.mode == 1 and self:Combo() or
        self.mode == 2 and self:Harass() or
        self.mode == 3 and self:Clear() or
        self.mode == 4 and self:Clear() or
        self.mode == 5 and self:LastHit() or
        self.mode == 6 and self:Flee()
    end
    
    function Jax:ResetAA()
        if Timer() > self.W.LastReset + 1 and HasBuff(myHero, "JaxEmpowerTwo") then
            ResetAutoAttack()
            self.W.LastReset = Timer()
        end
    end
    
    function Jax:OnPreMovement(args) --args.Process|args.Target
        if ShouldWait() then
            args.Process = false
            return
        end
    end
    
    function Jax:OnPreAttack(args) --args.Process|args.Target
        if ShouldWait() then
            args.Process = false
            return
        end
    end
    
    function Jax:OnPostAttack()
        local target = GetTargetByHandle(myHero.attackData.target)
        if ShouldWait() or not IsValidTarget(target) or not self.W:IsReady() then return end
        local wMenu, isMob, isHero = Menu.W, target.type == Obj_AI_Minion, target.type == myHero.type
        local modeCheck, manaCheck
        --
        if isMob then
            local laneClear, jungleClear = self.mode == 3, self.mode == 4
            modeCheck = laneClear or jungleClear
            castCheck = target.team == TEAM_JUNGLE and wMenu.Jungle:Value() or target.team == TEAM_ENEMY and wMenu.Clear:Value()
            manaCheck = ManaPercent(myHero) >= Menu.W.ManaClear:Value()
        elseif isHero then
            local combo, harass = self.mode == 1, self.mode == 2
            modeCheck = (combo or harass)
            castCheck = combo and wMenu.Combo:Value() or harass and wMenu.Harass:Value()
            manaCheck = combo and ManaPercent(myHero) >= Menu.W.Mana:Value() or harass and ManaPercent(myHero) >= Menu.W.ManaHarass:Value()
        end
        --
        if modeCheck and castCheck and manaCheck then
            self.W:Cast()
        end
    end
    
    function Jax:OnWndMsg(key, param)
        if param == Menu.Q.Jump.Key.__key then
            self:Jump(true)
        end
    end
    
    function Jax:Auto()
        if not self:IsDeflecting() then
            return
        end
        --
        local eRange = self.E.Range
        local enemies = GetEnemyHeroes(eRange + 300)
        local willHit, entering, leaving = 0, 0, 0
        --
        for i = 1, #enemies do
            local target = enemies[i]
            local tP, tP2, pP2 = target.pos, target:GetPrediction(huge, 0.2), myHero:GetPrediction(huge, 0.2)
            --
            if GetDistance(tP) <= eRange then --if inside(might go out)
                willHit = willHit + 1
                if GetDistance(tP2, pP2) > eRange then
                    leaving = leaving + 1
                end
            elseif GetDistance(tP2, pP2) < eRange then --if outside(might come in)
                entering = entering + 1
            end
        end
        if entering <= leaving and (willHit > 0 or entering == 0) then
            if leaving > 0 and self.E:IsReady() then
                self.E:Cast()
            end
        end
    end
    
    function Jax:Combo()
        local targ = self.target
        if not IsValidTarget(targ) then return end
        local dist = GetDistance(targ)
        --
        if Menu.E.Combo:Value() and dist < GetTrueAttackRange(targ) and self.E:IsReady() and not self:IsDeflecting() and ManaPercent(myHero) >= Menu.E.Mana:Value() then
            self.E:Cast()
        elseif Menu.Q.Combo:Value() and dist <= self.Q.Range and self.Q:IsReady() and (dist >= GetTrueAttackRange(myHero) or self.Q:GetDamage(targ) > targ.health) and ManaPercent(myHero) >= Menu.Q.Mana:Value() then
            self.Q:Cast(targ)
        elseif Menu.R.Combo:Value() and self.R:IsReady() and ManaPercent(myHero) >= Menu.Q.Mana:Value() then
            if #self.enemies >= Menu.R.Count:Value() or (Menu.R.Heroes[targ.charName] and Menu.R.Heroes[targ.charName]:Value()) then
                self.R:Cast()
            end
        end
    end
    
    function Jax:Harass()
        local targ = self.target
        if not IsValidTarget(targ) then return end
        local dist = GetDistance(targ)
        --
        if self.E:IsReady() and Menu.E.Harass:Value() and dist < GetTrueAttackRange(targ) and not self:IsDeflecting() and ManaPercent(myHero) >= Menu.E.ManaHarass:Value() then
            self.E:Cast()
        elseif self.Q:IsReady() and Menu.Q.Harass:Value() and dist <= self.Q.Range and (dist >= GetTrueAttackRange(myHero) or self.Q:GetDamage(targ) > targ.health) and ManaPercent(myHero) >= Menu.Q.ManaHarass:Value() then
            self.Q:Cast(targ)
        end
    end
    
    function Jax:Clear()
        if Menu.Q.Clear:Value() and self.Q:IsReady() and ManaPercent(myHero) > Menu.Q.ManaClear:Value() then
            local minions = GetEnemyMinions(self.Q.Range)
            local aaRange, aaCooldown = GetTrueAttackRange(myHero), myHero.attackData.state == STATE_WINDDOWN
            --
            for i = 1, #minions do
                local minion = minions[i]
                if minion.health >= 20 and self.Q:GetDamage(minion) > minion.health and ((GetDistance(minion) > aaRange or aaCooldown)) then
                    return self.Q:Cast(minion)
                end
            end
        end
    end
    
    function Jax:LastHit()
        if myHero.attackData.state == STATE_WINDDOWN and Menu.W.LastHit:Value() and self.W:IsReady() and ManaPercent(myHero) > Menu.W.ManaClear:Value() then
            local aaRange = GetTrueAttackRange(myHero)
            local minions = GetEnemyMinions(aaRange)
            --
            for i = 1, #minions do
                local minion = minions[i]
                if minion.health >= 20 and self.W:GetDamage(minion) > minion.health then
                    self.W:Cast()
                    return
                end
            end
        elseif Menu.Q.LastHit:Value() and self.Q:IsReady() and ManaPercent(myHero) > Menu.Q.ManaClear:Value() then
            local minions = GetEnemyMinions(self.Q.Range)
            local aaRange, aaCooldown = GetTrueAttackRange(myHero), myHero.attackData.state == STATE_WINDDOWN
            --
            for i = 1, #minions do
                local minion = minions[i]
                if minion.health >= 20 and (GetDistance(minion) > aaRange or aaCooldown) and self.Q:GetDamage(minion) > minion.health then
                    self.Q:Cast(minion)
                    return
                end
            end
        end
    end
    
    function Jax:Flee()
        if Menu.Q.Flee:Value() then
            self:Jump(Menu.Q.Jump.Flee:Value())
        end
        if Menu.E.Flee:Value() and self.E:IsReady() then
            if #GetEnemyHeroes(400) >= 1 then
                self.E:Cast()
            end
        end
    end
    
    function Jax:KillSteal()
        if Menu.Q.KS:Value() and self.Q:IsReady() then
            for i = 1, #self.enemies do
                local targ = self.enemies[i]
                local qDmg, wDmg = self.Q:GetDamage(targ), (wReady and self.W:GetDamage(targ) or 0)
                if qDmg + wDmg >= targ.health then
                    if qDmg < targ.health then
                        self.W:Cast()
                    end
                    self.Q:Cast(targ)
                end
            end
        end
    end
    
    function Jax:OnDraw()
        DrawSpells(self)
    end
    
    function Jax:IsDeflecting()
        return HasBuff(myHero, "JaxCounterStrike")
    end
    
    function Jax:Jump(canWard)
        if not self.Q:IsReady() then return end
        local jumpPos = myHero.pos:Extended(mousePos, self.Q.Range) --always jump at max range
        local jumpObject = self:GetJumpObject(jumpPos)
        --
        if jumpObject then
            self.Q:Cast(jumpObject)
            return
        elseif canWard then
            local pos, wardKey = mousePos, self:GetWard()
            jumpPos = mousePos
            if GetDistance(mousePos) > 600 then
                jumpPos = myHero.pos:Extended(mousePos, 600)
            end
            if wardKey then
                Control.CastSpell(wardKey, jumpPos)
                DelayAction(function() self.Q:Cast(jumpPos) end, 0.2)
            end
        end
    end
    
    function Jax:GetJumpObject(pos)
        local range, distance, result = GetDistance(pos) + 200, 10000, nil
        --
        local bases = GetMinions(range)
        --
        local heroes = GetHeroes(range)
        for i = 1, #heroes do bases[#bases + 1] = heroes[i] end
        local wards = GetWards(range)
        for i = 1, #wards do bases[#bases + 1] = wards[i] end

        local monsters = GetMonsters(range)
        for i = 1, #monsters do bases[#bases + 1] = monsters[i] end

        for i = 1, #bases do
            local obj = bases[i]
            local dist = GetDistance(obj, pos)
            if dist <= 200 and dist <= distance and IsValidTarget(obj) then
                distance = dist
                result = obj
            end
        end
        return result
    end
    
    local ItemHotKey = {[ITEM_1] = HK_ITEM_1, [ITEM_2] = HK_ITEM_2, [ITEM_3] = HK_ITEM_3, [ITEM_4] = HK_ITEM_4, [ITEM_5] = HK_ITEM_5, [ITEM_6] = HK_ITEM_6, [ITEM_7] = HK_ITEM_7}
    local wardItemIDs = {['3340'] = true, ["2049"] = true, ["2301"] = true, ["2302"] = true, ["2303"] = true, ["3711"] = true}
    function Jax:GetWard()
        for i = ITEM_1, ITEM_7 do
            local id = myHero:GetItemData(i).itemID
            local spell = myHero:GetSpellData(i)
            if id and wardItemIDs[tostring(id)] and spell.currentCd == 0 and spell.ammo >= 1 then
                return ItemHotKey[i]
            end
        end
    end
    
	table.insert(LoadCallbacks, function()
		Jax()
	end)
 
elseif myHero.charName == "Jhin" then
    class 'Jhin'
    
    function Jhin:__init()
        --// Data Initialization //--
        
        self.scriptVersion = "1.0"
        
        self:Spells()
        self:Menu()
        
        --// Callbacks //--
        
        Callback.Add("Tick", function() self:OnTick() end)
        Callback.Add("Draw", function() self:OnDraw() end)
        OnPreAttack(function(...) self:OnPreAttack(...) end)
        OnPostAttack(function(...) self:OnPostAttack(...) end)
        OnPreMovement(function(...) self:OnPreMovement(...) end)
    end
    
    function Jhin:Spells()
        self.Q = Spell({
            Slot = 0,
            Range = 600,
            Type = "Targetted"
        })
        
        self.W = Spell({
            Slot = 1,
            Range = 2500,
            Delay = 0.75,
            Speed = 10000,
            Radius = 20,
            Collision = false,
            From = myHero,
            Type = "Skillshot"
        })
        
        self.E = Spell({
            Slot = 2,
            Range = 750,
            Delay = 1,
            Speed = 1600,
            Radius = 60,
            Collision = false,
            From = myHero,
            Type = "Skillshot"
        })
        
        self.E.LastCastT = 0
        
        self.R = Spell({
            Slot = 3,
            Range = 3500,
            Delay = 0.25,
            Speed = 5000,
            Radius = 40,
            Collision = false,
            From = myHero,
            Type = "Skillshot"
        })
        
        self.R.Angle = 65
        self.R.IsCasting = false
        self.R.IsChanneling = false
        self.R.CastPos = nil
    end
    
    function Jhin:Menu()
        -- Q SETTINGS
        Menu.Q:MenuElement({name = " ", drop = {"Modes"}})
        Menu.Q:MenuElement({id = "Combo", name = "Combo", value = true})
        Menu.Q:MenuElement({id = "Harass", name = "Harass", value = true})
        Menu.Q:MenuElement({id = "KS", name = "KillSteal", value = true})
        Menu.Q:MenuElement({name = " ", drop = {"Mana Manager"}})
        Menu.Q:MenuElement({id = "ComboMana", name = "Combo - Min. Mana( % )", value = 0, min = 0, max = 100})
        Menu.Q:MenuElement({id = "HarassMana", name = "Harass - Min. Mana( % )", value = 50, min = 0, max = 100})
        Menu.Q:MenuElement({name = " ", drop = {"Customization"}})
        Menu.Q:MenuElement({type = MENU, name = "Cast Settings", id = "CS"})
        Menu.Q.CS:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.Q.CS:MenuElement({name = "Cast Mode", id = "ComboMode", value = 2, drop = {"Normal", "After Attack"}})
        Menu.Q.CS:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.Q.CS:MenuElement({name = "Cast Mode", id = "HarassMode", value = 1, drop = {"Normal", "After Attack"}})
        Menu.Q:MenuElement({type = MENU, name = "Harass White List", id = "HarassWhiteList"})
        Menu.Q:MenuElement({type = MENU, name = "KillSteal White List", id = "KSWhiteList"})
        
        -- W SETTINGS
        Menu.W:MenuElement({name = " ", drop = {"Modes"}})
        Menu.W:MenuElement({id = "Combo", name = "Combo", value = true})
        Menu.W:MenuElement({name = " ", drop = {"Mana Manager"}})
        Menu.W:MenuElement({id = "ComboMana", name = "Combo - Min. Mana( % )", value = 0, min = 0, max = 100})
        Menu.W:MenuElement({name = " ", drop = {"Customization"}})
        Menu.W:MenuElement({id = "OnImmobile", name = "On Immobile", value = true, tooltip = "Will use W on immobile enemy"})
        Menu.W:MenuElement({type = MENU, name = "On Immobile White List", id = "OnImmobileWhiteList"})
        Menu.W:MenuElement({type = MENU, name = "HitChance Settings", id = "HitChance"})
        Menu.W.HitChance:MenuElement({id = "info", name = "HitChance Info [?]", drop = {" "},
            tooltip = " 0 - Out of range / Collision / No valid waypoints\\n" ..
            " 1 - Normal hitchance\\n" ..
            " 2 - High hitchance\\n" ..
            " 3 - Very High hitchance (Slowed, Casted spell or AA)\\n" ..
            " 4 - Target immobile\\n" ..
        " 5 - Target dashing"})
        Menu.W.HitChance:MenuElement({id = "Combo", name = "Combo - HitChance", value = 1, min = 1, max = 5})
        Menu.W.HitChance:MenuElement({id = "Harass", name = "Harass - HitChance", value = 1, min = 1, max = 5})
        
        -- E SETTINGS
        Menu.E:MenuElement({name = " ", drop = {"Modes"}})
        Menu.E:MenuElement({id = "Combo", name = "Combo", value = true})
        Menu.E:MenuElement({name = " ", drop = {"Mana Manager"}})
        Menu.E:MenuElement({id = "ComboMana", name = "Combo - Min. Mana( % )", value = 0, min = 0, max = 100})
        Menu.E:MenuElement({name = " ", drop = {"Customization"}})
        Menu.E:MenuElement({id = "OnImmobile", name = "On Immobile", value = true, tooltip = "Will use E on immobile enemy"})
        Menu.E:MenuElement({type = MENU, name = "On Immobile White List", id = "OnImmobileWhiteList"})
        
        -- R SETTINGS
        Menu.R:MenuElement({name = " ", drop = {"Modes"}})
        Menu.R:MenuElement({id = "Combo", name = "Combo", value = true})
        
        -- OTHER
        Menu:MenuElement({name = myHero.charName .. " Script version: ", drop = {self.scriptVersion}})
        
		_G.SDK.ObjectManager:OnEnemyHeroLoad(function(args)
			local charName = args.charName
			Menu.Q.HarassWhiteList:MenuElement({name = charName, id = charName, value = true})
			Menu.Q.KSWhiteList:MenuElement({name = charName, id = charName, value = true})
			Menu.W.OnImmobileWhiteList:MenuElement({name = charName, id = charName, value = true})
			Menu.E.OnImmobileWhiteList:MenuElement({name = charName, id = charName, value = true})
		end)
    end
    
    function Jhin:EnoughMana(value)
        return ManaPercent(myHero) >= value
    end
    
    function Jhin:WhiteListValue(menu, target)
        return menu and menu[target.charName] and menu[target.charName]:Value()
    end
    
    function Jhin:CrossProduct(p1, p2)
        return (p2.z * p1.x - p2.x * p1.z)
    end
    
    function Jhin:Rotated(v, angle)
        local c = cos(angle)
        local s = sin(angle)
        return Vector(v.x * c - v.z * s, 0, v.z * c + v.x * s)
    end
    
    function Jhin:InCone(targetPos)
        if not self.R.CastPos then return false end
        
        local endPos = self.R.CastPos
        local range = self.R.Range
        local angle = self.R.Angle * pi / 180
        local v1 = self:Rotated(endPos - myHero.pos, -angle / 2)
        local v2 = self:Rotated(v1, angle)
        local v3 = targetPos - myHero.pos
        
        if GetDistanceSqr(v3, Vector()) < range * range and self:CrossProduct(v1, v3) > 0 and self:CrossProduct(v3, v2) > 0 then
            return true
        end
        
        return false
    end
    
    function Jhin:Update()
        local spell = myHero.activeSpell
        
        if spell and spell.valid and spell.name == "JhinR" then
            self.R.IsCasting = true
            self.R.CastPos = Vector(spell.placementPos)
            
            if spell.isChanneling then
                self.R.IsChanneling = true
            end
            
            SetAttack(false)
            SetMovement(false)
        else
            self.R.IsCasting = false
            self.R.CastPos = nil
            self.R.IsChanneling = false
            
            SetAttack(true)
            SetMovement(true)
        end
    end
    
    function Jhin:CastQ(target)
        if self.Q:IsReady() and self.Q:CanCast(target) then
            self.Q:Cast(target)
        end
    end
    
    function Jhin:CastW(target, hitChance)
        if self.W:IsReady() and self.W:CanCast(target) then
            self.W:CastToPred(target, hitChance)
        end
    end
    
    function Jhin:CastE(target, hitChance)
        if self.E:IsReady() and self.E:CanCast(target) then
            self.E:CastToPred(target, hitChance)
            self.E.LastCastT = Game.Timer()
        end
    end
    
    function Jhin:CastR(target, hitChance)
        if self.R:IsReady() and self.R:CanCast(target) and self.R.IsChanneling then
            self.R:CastToPred(target, hitChance)
        end
    end
    
    function Jhin:Combo()
        local target = self.target
        if not target then return end
        
        if self.R.IsCasting then
            local useR = Menu.R.Combo:Value()
            if useR then
                self:CastR(target, 1)
            end
            
            return
        end
        
        local reload = GotBuff(myHero, "JhinPassiveReload") > 0
        local useQ = Menu.Q.Combo:Value()
        local modeQ = Menu.Q.CS.ComboMode:Value()
        local manaQ = Menu.Q.ComboMana:Value()
        if useQ and (modeQ == 1 or reload) and self:EnoughMana(manaQ) then
            self:CastQ(target)
        end
        
        local useW = Menu.W.Combo:Value()
        local manaW = Menu.W.ComboMana:Value()
        local hitChanceW = Menu.W.HitChance.Combo:Value()
        local marked = GotBuff(target, "jhinespotteddebuff") > 0
        if useW and self:EnoughMana(manaW) and marked then
            self:CastW(target, hitChanceW)
        end
        
        local timer = Game.Timer()
        local useE = Menu.E.Combo:Value()
        local manaE = Menu.E.ComboMana:Value()
        if useE and self:EnoughMana(manaE) and reload and self.E.LastCastT + 2 < timer then
            self:CastE(target, 1)
        end
    end
    
    function Jhin:ComboR()
        local target = self.target
        if not target then return end
        
        if self.mode == 1 then
            if self.R.IsCasting then
                local useR = Menu.R.Combo:Value()
                if useR then
                    self:CastR(target, 1)
                end
                
                return
            end
        end
    end
    
    function Jhin:Harass()
        local target = self.target
        if not target then return end
        if self.R.IsCasting then return end
        
        local reload = GotBuff(myHero, "JhinPassiveReload") > 0
        local useQ = Menu.Q.Harass:Value()
        local modeQ = Menu.Q.CS.HarassMode:Value()
        local manaQ = Menu.Q.HarassMana:Value()
        if useQ and (modeQ == 1 or reload) and self:EnoughMana(manaQ) and self:WhiteListValue(Menu.Q.HarassWhiteList, target) then
            self:CastQ(target)
        end
    end
    
    function Jhin:Immobile()
        for i = 1, #(self.enemies) do
            local unit = self.enemies[i]
            
            local timer = Game.Timer()
            local marked = GotBuff(unit, "jhinespotteddebuff") > 0
            local useW = Menu.W.OnImmobile:Value()
            if useW and self:WhiteListValue(Menu.W.OnImmobileWhiteList, unit) then
                local target, unitPosition, castPosition = self.W:OnImmobile(unit)
                
                if target and unitPosition and marked then
                    self:CastW(unit, 1)
                end
            end
            
            local useE = Menu.E.OnImmobile:Value()
            if useE and self:WhiteListValue(Menu.E.OnImmobileWhiteList, unit) then
                local target, unitPosition, castPosition = self.E:OnImmobile(unit)
                
                if target and unitPosition and self.E.LastCastT + 1 < timer then
                    self:CastE(unit, 1)
                end
            end
        end
    end
    
    function Jhin:KillSteal()
        for i = 1, #(self.enemies) do
            local unit = self.enemies[i]
            local health = unit.health
            local shield = unit.shieldAD
            
            local useQ = Menu.Q.KS:Value()
            if self.Q:IsReady() and self.Q:CanCast(unit) and useQ and self:WhiteListValue(Menu.Q.KSWhiteList, unit) then
                local damage = self.Q:GetDamage(unit)
                
                if health + shield < damage then
                    self.Q:Cast(unit)
                end
            end
        end
    end
    
    function Jhin:OnTick()
        self:Update()
        
        if ShouldWait() then return end
        
        self.mode = GetMode()
        self.target = GetTarget(self.R.Range, 0)
        self.enemies = GetEnemyHeroes(self.R.Range)
        
        self:ComboR()
        
        if myHero.isChanneling then return end
        
        self:Immobile()
        self:KillSteal()
        
        if not self.mode then return end
        
        local executeMode =
        self.mode == 1 and self:Combo() or
        self.mode == 2 and self:Harass()
    end
    
    function Jhin:OnDraw()
        DrawSpells(self)
    end
    
    function Jhin:OnPreMovement(args)
        if ShouldWait() then
            args.Process = false
            return
        end
    end
    
    function Jhin:OnPreAttack(args)
        if ShouldWait() then
            args.Process = false
            return
        end
    end
    
    function Jhin:OnPostAttack()
        local handle = myHero.attackData.target
        local target = handle ~= 0 and GetTargetByHandle(handle) or self.target
        if target == nil then return end
        local target_type = target.type
        
        if target_type == Obj_AI_Hero then
            if self.mode == 1 then
                local useQ = Menu.Q.Combo:Value()
                local modeQ = Menu.Q.CS.ComboMode:Value()
                local manaQ = Menu.Q.ComboMana:Value()
                if useQ and modeQ == 2 and self:EnoughMana(manaQ) then
                    self:CastQ(target)
                end
            elseif self.mode == 2 then
                local useQ = Menu.Q.Harass:Value()
                local modeQ = Menu.Q.CS.HarassMode:Value()
                local manaQ = Menu.Q.HarassMana:Value()
                if useQ and modeQ == 2 and self:EnoughMana(manaQ) and self:WhiteListValue(Menu.Q.HarassWhiteList, target) then
                    self:CastQ(target)
                end
            end
        end
    end
    
	table.insert(LoadCallbacks, function()
		Jhin()
	end)
    
elseif myHero.charName == "Kalista" then
    
    class 'Kalista'
    
    function Kalista:__init()
        --[[Data Initialization]]
        self.recentTargets = {}
        self.rendDmg = {}
        self.Color1 = DrawColor(255, 35, 219, 81)
        self.Color2 = DrawColor(255, 216, 121, 26)
        self.SentinelSpots = {
            Baron = {obj = false, pos = Vector(4956, 0, 10444)},
            Dragon = {obj = false, pos = Vector(9866, 0, 4414)},
            Mid = {obj = false, pos = Vector(8428, 0, 6465)},
            Blue = {obj = false, pos = Vector(3871, 0, 7901)},
            Red = {obj = false, pos = Vector(7862, 0, 4111)},
            Mid2 = {obj = false, pos = Vector(6545, 0, 8361)},
            Blue2 = {obj = false, pos = Vector(10931, 0, 6990)},
            Red2 = {obj = false, pos = Vector(7016, 0, 10775)},
        }
        self.supportedAllies = {
            ["Blitzcrank"] = "tahmkenchwdevoured",
            ["Skarner"] = "SkarnerImpale",
            ["TahmKench"] = "tahmkenchwdevoured"
        }
        self.scriptVersion = "1.0"
        self:Spells()
        self:Menu()
        --[[Default Callbacks]]
        Callback.Add("Tick", function() self:OnTick() end)
        Callback.Add("Draw", function() self:OnDraw() end)
        Callback.Add("WndMsg", function(msg, param) self:OnWndMsg(msg, param) end)
        --[[Orb Callbacks]]
        OnPreAttack(function(...) self:OnPreAttack(...) end)
        OnAttack(function(...) self:OnAttack(...) end)
        OnUnkillableMinion(function(...) self:OnUnkillable(...) end)
        --[[Custom Callbacks]]
        OnLoseVision(function(unit) self:OnLoseVision(unit) end)
    end
    
    function Kalista:Spells()
        self.Q = Spell({
            Slot = 0,
            Range = 1150,
            Delay = 0.35,
            Speed = 2100,
            Radius = 70,
            Collision = true,
            From = myHero,
            Type = "SkillShot"
        })
        self.W = Spell({
            Slot = 1,
            Range = 5000,
            Delay = 0.25,
            Speed = 450,
            Radius = 100,
            Collision = false,
            From = myHero,
            Type = "AOE"
        })
        self.E = Spell({
            Slot = 2,
            Range = 1000,
            Delay = 0.25,
            Speed = huge,
            Radius = 100,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
        self.R = Spell({
            Slot = 3,
            Range = 1200,
            Delay = 0.85,
            Speed = huge,
            Radius = 150,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
        self.W.LastCast = Timer()
        self.W.LastSpot = nil
        --
        self.W.GetDamage = function(spellInstance, enemy, stage)
            local wLvl = myHero:GetSpellData(_W).level
            local baseDmg = 5 * wLvl
            --
            if HasBuff(enemy, "kalistacoopstrikeally") then
                if enemy.type == Obj_AI_Minion and enemy.health <= 125 then
                    return enemy.health
                end
                return baseDmg + (0.025 + 0.025 * wLvl) * enemy.maxHealth
            end
            return baseDmg
        end
        self.E.GetDamage = function(spellInstance, enemy, stage)
            if not spellInstance:IsReady() then return 0 end
            --
            local buff = self.recentTargets[enemy.networkID] and self.recentTargets[enemy.networkID].buff
            if buff and buff.count > 0 then
                local eLvl = myHero:GetSpellData(_E).level
                local baseDmg = 10 + 10 * eLvl + 0.6 * myHero.totalDamage
                local dmgPerSpear = (eLvl * (eLvl * 0.5 + 2.5) + 7) + (3.75 * eLvl + 16.25) * myHero.totalDamage / 100
                --
                return baseDmg + dmgPerSpear * (buff.count - 1)
            end
            return 0
        end
    end
    
    function Kalista:Menu()
        --Q--
        Menu.Q:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.Q:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.Q:MenuElement({id = "Mana", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.Q:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.Q:MenuElement({id = "ManaHarass", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Farm Settings"}})
        Menu.Q:MenuElement({id = "Unkillable", name = "Use on Unkillable", value = false})
        Menu.Q:MenuElement({id = "ManaClear", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Misc"}})
        --Menu.Q:MenuElement({id = "Wall"  , name = "Use to WallJump [Flee Key]", value = true})
        --W--
        Menu.W:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.W:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.W:MenuElement({id = "Mana", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        Menu.W:MenuElement({name = " ", drop = {"Misc"}})
        Menu.W:MenuElement({id = "Draw", name = "Draw Spots", value = true})
        Menu.W:MenuElement({id = "Key", name = "Send Sentinel [Closest To Mouse]", key = string.byte("G")})
        Menu.W:MenuElement({id = "Dra", name = "Dragon", value = true})
        Menu.W:MenuElement({id = "Bar", name = "Baron[Exploit]", value = true})
        Menu.W:MenuElement({id = "Mid", name = "Mid", value = true})
        Menu.W:MenuElement({id = "Blu", name = "Blue", value = true})
        Menu.W:MenuElement({id = "Red", name = "Red", value = true})
        --E--
        Menu.E:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.E:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.E:MenuElement({id = "Mana", name = "Min Mana % ", value = 0, min = 0, max = 100, step = 1})
        Menu.E:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.E:MenuElement({id = "Harass", name = "Use on Harass", value = false})
        Menu.E:MenuElement({id = "ManaHarass", name = "Min Mana % ", value = 0, min = 0, max = 100, step = 1})
        Menu.E:MenuElement({name = " ", drop = {"Farm Settings"}})
        Menu.E:MenuElement({id = "LastHit", name = "Use on LastHit", value = true})
        Menu.E:MenuElement({id = "Jungle", name = "Use on JungleClear", value = false})
        Menu.E:MenuElement({id = "Clear", name = "Use on LaneClear", value = false})
        Menu.E:MenuElement({id = "Min", name = "Minions To Cast", value = 2, min = 0, max = 6, step = 1})
        Menu.E:MenuElement({id = "ManaClear", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        Menu.E:MenuElement({name = " ", drop = {"Misc"}})
        Menu.E:MenuElement({id = "Epic", name = "Steal Baron / Dragon", value = true})
        Menu.E:MenuElement({id = "KS", name = "Use on KS", value = true})
        Menu.E:MenuElement({id = "Dying", name = "Use When Dying", value = true})
        Menu.E:MenuElement({id = "MinHP", name = " HP <= X % ", value = 15, min = 5, max = 100, step = 5})
        Menu.E:MenuElement({id = "DmgMod", name = "Dmg Calculations Multiplier", value = 1, min = 0.1, max = 5, step = 0.1})
        
        --R--
        Menu.R:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.R:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.R:MenuElement({id = "Count", name = "Min Enemies Around", value = 2, min = 1, max = 5, step = 1})
        Menu.R:MenuElement({id = "Mana", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        Menu.R:MenuElement({name = " ", drop = {"Oath Settings"}})
        Menu.R:MenuElement({id = "Save", name = "Save Ally", value = true})
        Menu.R:MenuElement({id = "MinHP", name = "When HP % < X", value = 20, min = 1, max = 100, step = 1})
        Menu.R:MenuElement({name = " ", drop = {"Balista Settings"}})
        Menu.R:MenuElement({id = "Balista", name = "Pull Enemy", value = true})
        Menu.R:MenuElement({id = "BalistaHP", name = "Only If HP % > X", value = 20, min = 1, max = 100, step = 1})
        Menu.R:MenuElement({id = "Turret", name = "Only Under Turret", value = false})
        
        Menu:MenuElement({name = "[WR] "..charName.." Script", drop = {"Release_"..self.scriptVersion}})
    end
    
    function Kalista:OnTick()
        if ShouldWait() then return end
        --
        self.enemies = GetEnemyHeroes(self.R.Range + 1000)
        self.target = GetTarget(GetTrueAttackRange(myHero), 0)
        self.lastTarget = self.target or self.lastTarget
        self.mode = GetMode()
        --
        if myHero.isChanneling then return end
        self.rendDmg = {}
        self:SentinelManager()
        self:OathManager()
        self:Auto()
        --
        if not self.mode then return end
        local executeMode =
        self.mode == 1 and self:Combo() or
        self.mode == 2 and self:Harass() or
        self.mode == 6 and self:Flee()
    end
    
    function Kalista:OnWndMsg(msg, param)
        if param == HK_W then
            DelayAction(function()
                self:FindSentinels()
            end, 0.25)
        end
    end
    
    function Kalista:OnPreAttack(args)
        local target = args.Target
        local tType = target and target.type
        if not (IsValidTarget(target) and (tType == Obj_AI_Hero or tType == Obj_AI_Minion)) then return end
        --
        local netID = target.networkID
        local rendTarget = self.recentTargets[netID]
        if not rendTarget then
            self.recentTargets[netID] = {obj = target, buff = GetBuffByName(target, "kalistaexpungemarker")}
        end
    end
    
    function Kalista:OnAttack()
        local target = GetTargetByHandle(myHero.attackData.target)
        local tType = target and target.type
        if not (IsValidTarget(target) and (tType == Obj_AI_Hero or tType == Obj_AI_Minion)) then return end
        --
        local netID = target.networkID
        local rendTarget = self.recentTargets[netID]
        if not rendTarget then
            self.recentTargets[netID] = {obj = target, buff = GetBuffByName(target, "kalistaexpungemarker")}
        end
    end
    
    function Kalista:OnUnkillable(minion)
        if self.Q:IsReady() and Menu.Q.Unkillable:Value() and ManaPercent(myHero) >= Menu.Q.ManaClear:Value() then
            local col = mCollision(myHero, minion, self.Q, GetEnemyMinions(self.Q.Range))
            for i = 1, #col do
                local min = col[i]
                if min ~= minion then
                    return
                end
            end
            self.Q:Cast(minion)
        end
    end
    
    function Kalista:OnLoseVision(unit)
        if self.mode == 1 and self.W:IsReady() and self.lastTarget and unit.valid and not unit.dead and unit.networkID == self.lastTarget.networkID then
            if Menu.W.Combo:Value() and ManaPercent(myHero) >= Menu.W.Mana:Value() then
                self.W:Cast(unit.pos)
            end
        end
    end
    
    function Kalista:Auto()
        if not self.E:IsReady() then return end
        if Menu.E.Dying:Value() and HealthPercent(myHero) < Menu.E.MinHP:Value() then
            self.E:Cast(); return
        end
        --
        local KS, Epic = Menu.E.KS:Value(), Menu.E.Epic:Value()
        local eCombo = not KS and self.mode == 1 and Menu.E.Combo:Value() and ManaPercent(myHero) >= Menu.E.Mana:Value()
        local eHarass = not (KS or eCombo) and self.mode == 2 and Menu.E.Harass:Value() and ManaPercent(myHero) >= Menu.E.ManaHarass:Value()
        local eClear = not (eCombo or eHarass) and ((self.mode == 3 and Menu.E.Clear:Value()) or (self.mode == 4 and Menu.E.Jungle:Value()) or (self.mode == 5 and Menu.E.LastHit:Value())) and ManaPercent(myHero) >= Menu.E.ManaClear:Value()
        --
        if not (KS or Epic or eCombo or eHarass or eClear) then return end
        local killableMinions, minMinions = 0, Menu.E.Min:Value()
        local manaCheck = myHero.mana >= 60
        --
        for netID, rendData in pairs(self.recentTargets) do
            local target = rendData.obj
            local tType = target.type
            --
            if IsValidTarget(target, self.E.Range) then
                if tType == Obj_AI_Minion and (eClear or Epic) then
                    local DmgPercent = self:DmgPercent(target)
                    if DmgPercent > 100 then
                        killableMinions = killableMinions + 1
                        if target.team == 300 and Epic and (target.charName:lower():find("dragon") or target.charName == "SRU_Baron" or target.charName == "SRU_RiftHerald") then
                            self.E:Cast(); return
                        end
                    end
                elseif tType == Obj_AI_Hero and (KS or eCombo or eHarass) then
                    local DmgPercent = self:DmgPercent(target)
                    if DmgPercent > 100 or (manaCheck and killableMinions >= 1) then
                        self.E:Cast(); return
                    end
                end
            end
        end
        --
        if eClear and killableMinions >= minMinions then
            self.E:Cast()
        end
    end
    
    function Kalista:Combo()
        if #self.enemies >= 1 and not self.target then
            --attack minions to gapclose
        end
        --
        local qTarget = GetTarget(self.Q.Range, 0)
        if qTarget and self.Q:IsReady() and Menu.Q.Combo:Value() and ManaPercent(myHero) >= Menu.Q.Mana:Value() then
            self.Q:CastToPred(qTarget, 2)
        end
    end
    
    function Kalista:Harass()
        if #self.enemies >= 1 and not self.target then
            --attack minions to gapclose
        end
        --
        local qTarget = GetTarget(self.Q.Range, 0)
        if qTarget and self.Q:IsReady() and Menu.Q.Combo:Value() and ManaPercent(myHero) >= Menu.Q.Mana:Value() then
            self.Q:CastToPred(qTarget, 2)
        end
    end
    
    function Kalista:Flee()
        if self.Q:IsReady() and Menu.Q.Wall:Value() then
            --TODO walljump logic
        end
    end
    
    function Kalista:OnDraw()
        self:UpdateTargets()
        self:DrawSpots()
        DrawSpells(self, function(enemy)
            local screenPos = enemy.pos:To2D()
            if screenPos.onScreen then
                DrawText(tostring(self:DmgPercent(enemy)) .. '%', 40, screenPos.x, screenPos.y, Color.Green)
            end
        end)
    end
    
    function Kalista:SentinelManager()
        self:UpdateSentinels()
        if Menu.W.Key:Value() and self.W:IsReady() and Timer() - self.W.LastCast > 1 then
            local closestToMouse, bestDistance = nil, 3000
            for k, spot in pairs(self.SentinelSpots) do
                if GetDistance(spot) <= self.W.Range and spot.obj == nil then
                    local id = k:sub(1, 3)
                    local dist = GetDistance(mousePos, spot)
                    if Menu.W[id]:Value() and dist <= bestDistance then
                        closestToMouse = spot
                        bestDistance = dist
                        self.W.LastSpot = k
                    end
                end
            end
            if closestToMouse then
                self.W:Cast(closestToMouse.pos)
                self.W.LastCast = Timer()
            end
        end
    end
    
    function Kalista:DrawSpots()
        if Menu.W.Draw:Value() then
            for k, spot in pairs(self.SentinelSpots) do
                if GetDistance(spot) <= self.W.Range then
                    DrawMap(spot.pos, 200, 5, spot.obj and self.Color1 or self.Color2)
                end
            end
        end
    end
    
    function Kalista:FindSentinels()
        for i = ObjectCount(), 1, -1 do
            local obj = Object(i);
            if obj and obj.isAlly and obj.charName == 'KalistaSpawn' then
                self.SentinelSpots[self.W.LastSpot].obj = obj
            end
        end
    end
    
    function Kalista:UpdateSentinels()
        for k, spot in pairs(self.SentinelSpots) do
            local obj = spot.obj
            if not obj or not obj.valid or obj.dead then
                self.SentinelSpots[k].obj = nil
            end
        end
    end
    
    function Kalista:UpdateTargets()
        local time = Timer()
        --
        for netID, rendData in pairs(self.recentTargets) do
            local buff = rendData.buff
            local enemy = rendData.obj
            if not (enemy and enemy.valid) or enemy.dead then
                self.recentTargets[netID] = nil
            else
                self.recentTargets[netID].buff = GetBuffByName(enemy, "kalistaexpungemarker")
                if enemy.team == 300 then
                    local screenPos = enemy.pos:To2D()
                    if screenPos.onScreen then
                        DrawText(tostring(self:DmgPercent(enemy)) .. '%', 40, screenPos.x, screenPos.y, Color.Green)
                    end
                end
            end
        end
    end
    
    function Kalista:DmgPercent(target)
        if self.rendDmg[target.networkID] then
            return self.rendDmg[target.networkID]
        end
        --
        local dmg = floor((self.E:CalcDamage(target) * 100 * Menu.E.DmgMod:Value() / (target.health + target.shieldAD)) * 100) / 100
        self.rendDmg[target.networkID] = dmg
        return dmg
    end
    
    function Kalista:GetSwornAlly()
        for i = 1, HeroCount() do
            local hero = Hero(i)
            if hero and not hero.isMe and hero.isAlly and HasBuff(hero, "kalistacoopstrikeally") then
                return hero
            end
        end
    end
    
    function Kalista:OathManager()
        if not self.swornAlly then
            self.swornAlly = self:GetSwornAlly()
        end
        --
        local ally = self.swornAlly
        if self.R:IsReady() and ally and GetDistance(ally) < self.R.Range then
            local Menu = Menu.R
            --[[Combo Stuff]]
            if self.mode == 1 and Menu.Combo:Value() and ManaPercent(myHero) >= Menu.Mana:Value() then
                if CountEnemiesAround(myHero.pos, self.R.Range) > Menu.Count:Value() then
                    self.R:Cast(); return
                end
            end
            --[[Balista Stuff]]
            local balistaBuff = self.supportedAllies[ally.charName]
            local balistaCheck = balistaBuff and (not Menu.Turret:Value() or IsUnderTurret(myHero.pos, TEAM_ALLY))
            if Menu.Balista:Value() and balistaCheck and HealthPercent(myHero) >= Menu.BalistaHP:Value() then
                for i = 1, #self.enemies do
                    local enemy = self.enemies[i]
                    if enemy and HasBuff(enemy, balistaBuff) then
                        self.R:Cast(); return
                    end
                end
            end
            --[[Save Ally]]
            if Menu.Save:Value() and HealthPercent(ally) <= Menu.MinHP:Value() then
                self.R:Cast(); return
            end
        end
    end
    
	table.insert(LoadCallbacks, function()
		Kalista()
	end)
    
elseif myHero.charName == "Lucian" then
    class 'Lucian'
    
    function Lucian:__init()
        --// Data Initialization //--
        
        self.scriptVersion = "1.0"
        
        self:Spells()
        self:Menu()
        
        --// Callbacks //--
        
        Callback.Add("Tick", function() self:OnTick() end)
        Callback.Add("Draw", function() self:OnDraw() end)
        OnPreAttack(function(...) self:OnPreAttack(...) end)
        OnPostAttackTick(function(...) self:OnPostAttack(...) end)
        OnPreMovement(function(...) self:OnPreMovement(...) end)
    end
    
    function Lucian:Spells()
        self.Q = Spell({
            Slot = 0,
            Range = 650,
            Delay = 0.35,
            Speed = huge,
            Radius = 30,
            Collision = false,
            From = myHero,
            Type = "Targetted"
        })
        
        self.Q2 = Spell({
            Slot = 0,
            Range = 900,
            Delay = 0.35,
            Speed = huge,
            Radius = 30,
            Collision = false,
            From = myHero,
            Type = "Targetted"
        })
        
        self.W = Spell({
            Slot = 1,
            Range = 1000,
            Delay = 0.30,
            Speed = 1600,
            Radius = 40,
            Collision = true,
            From = myHero,
            Type = "Skillshot",
            DmgType = "Magical"
        })
        
        self.E = Spell({
            Slot = 2,
            Range = 425,
            Type = "Skillshot"
        })
        
        self.R = Spell({
            Slot = 3,
            Range = 1200,
            Delay = 0.25,
            Speed = huge,
            Radius = 50,
            Collision = true,
            From = myHero,
            Type = "Skillshot"
        })
        self.Q.GetDamage = function(spellInstance, enemy, stage)
            if not spellInstance:IsReady() then return 0 end
            --
            local qLvl = myHero:GetSpellData(_Q).level
            return 50 + 35 * qLvl + (0.45 + 0.15 * qLvl) * myHero.bonusDamage
        end
        self.W.GetDamage = function(spellInstance, enemy, stage)
            if not spellInstance:IsReady() then return 0 end
            --
            local wLvl = myHero:GetSpellData(_W).level
            return (45 + 40 * wLvl + 0.9 * myHero.ap)
        end
    end
    
    function Lucian:Menu()
        -- Q SETTINGS
        Menu.Q:MenuElement({name = " ", drop = {"Modes"}})
        Menu.Q:MenuElement({id = "Combo", name = "Combo", value = true})
        Menu.Q:MenuElement({id = "Harass", name = "Harass", value = true})
        Menu.Q:MenuElement({id = "KS", name = "KillSteal", value = true})
        Menu.Q:MenuElement({name = " ", drop = {"Mana Manager"}})
        Menu.Q:MenuElement({id = "ComboMana", name = "Combo - Min. Mana( % )", value = 0, min = 0, max = 100})
        Menu.Q:MenuElement({id = "HarassMana", name = "Harass - Min. Mana( % )", value = 50, min = 0, max = 100})
        Menu.Q:MenuElement({name = " ", drop = {"Customization"}})
        Menu.Q:MenuElement({type = MENU, name = "Harass White List", id = "HarassWhiteList"})
        Menu.Q:MenuElement({type = MENU, name = "KillSteal White List", id = "KSWhiteList"})
        
        -- Q2 SETTINGS
        Menu.Q2:MenuElement({name = " ", drop = {"Modes"}})
        Menu.Q2:MenuElement({id = "Combo", name = "Combo", value = true})
        Menu.Q2:MenuElement({id = "Harass", name = "Harass", value = true})
        Menu.Q2:MenuElement({id = "AutoHarass", name = "Auto Harass", value = true})
        Menu.Q2:MenuElement({name = " ", drop = {"Mana Manager"}})
        Menu.Q2:MenuElement({id = "ComboMana", name = "Combo - Min. Mana( % )", value = 0, min = 0, max = 100})
        Menu.Q2:MenuElement({id = "HarassMana", name = "Harass - Min. Mana( % )", value = 50, min = 0, max = 100})
        Menu.Q2:MenuElement({id = "AutoHarassMana", name = "Auto Harass - Min. Mana( % )", value = 50, min = 0, max = 100})
        Menu.Q2:MenuElement({name = " ", drop = {"Customization"}})
        Menu.Q2:MenuElement({type = MENU, name = "Harass White List", id = "HarassWhiteList"})
        Menu.Q2:MenuElement({type = MENU, name = "Auto Harass White List", id = "AutoHarassWhiteList"})
        
        -- W SETTINGS
        Menu.W:MenuElement({name = " ", drop = {"Modes"}})
        Menu.W:MenuElement({id = "Combo", name = "Combo", value = true})
        Menu.W:MenuElement({id = "Harass", name = "Harass", value = true})
        Menu.W:MenuElement({id = "KS", name = "KillSteal", value = true})
        Menu.W:MenuElement({name = " ", drop = {"Mana Manager"}})
        Menu.W:MenuElement({id = "ComboMana", name = "Combo - Min. Mana( % )", value = 0, min = 0, max = 100})
        Menu.W:MenuElement({id = "HarassMana", name = "Harass - Min. Mana( % )", value = 50, min = 0, max = 100})
        Menu.W:MenuElement({name = " ", drop = {"Customization"}})
        Menu.W:MenuElement({id = "IgnorePred", name = "Ignore Prediction", value = true})
        Menu.W:MenuElement({id = "IgnoreColl", name = "Ignore Collision", value = true})
        Menu.W:MenuElement({type = MENU, name = "Harass White List", id = "HarassWhiteList"})
        Menu.W:MenuElement({type = MENU, name = "KillSteal White List", id = "KSWhiteList"})
        
        -- E SETTINGS
        Menu.E:MenuElement({name = " ", drop = {"Modes"}})
        Menu.E:MenuElement({id = "Combo", name = "Combo", value = true})
        Menu.E:MenuElement({name = " ", drop = {"Mana Manager"}})
        Menu.E:MenuElement({id = "ComboMana", name = "Combo - Min. Mana( % )", value = 0, min = 0, max = 100})
        Menu.E:MenuElement({name = " ", drop = {"Customization"}})
        Menu.E:MenuElement({name = "E Cast Mode", id = "Mode", value = 1, drop = {"To Side", "To Mouse", "To Target"}})
        
        -- R SETTINGS
        Menu.R:MenuElement({name = " ", drop = {"Modes"}})
        Menu.R:MenuElement({id = "Combo", name = "Combo", value = true})
        Menu.R:MenuElement({name = " ", drop = {"Mana Manager"}})
        Menu.R:MenuElement({id = "ComboMana", name = "Combo - Min. Mana( % )", value = 0, min = 0, max = 100})
        Menu.R:MenuElement({name = " ", drop = {"Customization"}})
        Menu.R:MenuElement({id = "Magnet", name = "Target Magnet", value = true})
        Menu.R:MenuElement({type = MENU, name = "Combo White List", id = "ComboWhiteList"})
   
        
        -- OTHER
        Menu:MenuElement({name = " ", drop = {"Extra Settings"}})
        Menu:MenuElement({name = "Combo Rotation Priority", id = "ComboRotation", value = 3, drop = {"Q", "W", "E"}})
        Menu:MenuElement({name = " ", drop = {"Script Info"}})
        Menu:MenuElement({name = myHero.charName.." Script version: ", drop = {self.scriptVersion}})

       _G.SDK.ObjectManager:OnEnemyHeroLoad(function(args)
			local unit = args.unit
			local charName = args.charName
			Menu.Q.HarassWhiteList:MenuElement({name = unit.charName, id = unit.charName, value = true})
			Menu.Q.KSWhiteList:MenuElement({name = unit.charName, id = unit.charName, value = true})

			Menu.Q2.HarassWhiteList:MenuElement({name = unit.charName, id = unit.charName, value = true})
			Menu.Q2.AutoHarassWhiteList:MenuElement({name = unit.charName, id = unit.charName, value = true})

			Menu.W.HarassWhiteList:MenuElement({name = unit.charName, id = unit.charName, value = true})
			Menu.W.KSWhiteList:MenuElement({name = unit.charName, id = unit.charName, value = true})

			Menu.R.ComboWhiteList:MenuElement({name = unit.charName, id = unit.charName, value = true})
       end)
    end
    
    function Lucian:EnoughMana(value)
        return ManaPercent(myHero) >= value
    end
    
    function Lucian:WhiteListValue(menu, target)
        return menu and menu[target.charName] and menu[target.charName]:Value()
    end
    
    function Lucian:ClosestToMouse(p1, p2)
        return (GetDistance(mousePos, p1) > GetDistance(mousePos, p2)) and p2 or p1
    end
    
    function Lucian:DashRange(target)
        local pred = target:GetPrediction(huge, 0.25)
        return GetDistance(pred) < (myHero.range + target.boundingRadius + myHero.boundingRadius) and 125 or 425
    end
    
    function Lucian:CastQExtended(target)
        if self.Q2:IsReady() and self.Q2:CanCast(target) then
            local position, castPosition, hitChance = self.Q2:GetPrediction(target)
            
            if castPosition and hitChance >= 1 then
                local targetPos = myHero.pos:Extended(castPosition, self.Q2.Range)
                
                for i = 1, #self.minions do
                    local minion = self.minions[i]
                    if minion and self.Q:CanCast(minion) then
                        local minionPos = myHero.pos:Extended(minion.pos, self.Q2.Range)
 
                        if GetDistance(targetPos, minionPos) <= self.Q2.Radius + target.boundingRadius then
                            self.Q:Cast(minion)
                        end
                    end
                end
            end
        end
    end
    
    function Lucian:CastW(target, checkPrediction, checkCollision)
        if self.W:IsReady() and self.W:CanCast(target) then
            self.W.Collision = not checkCollision
            
            local position, castPosition, hitChance = self.W:GetPrediction(target)
            castPosition = checkPrediction and target.pos or castPosition
            
            if castPosition and hitChance >= 1 then
                self.W:Cast(castPosition)
            end
        end
    end
    
    function Lucian:CastE(target, castMode, castRange)
        if castMode == 1 then
            local c1, c2, r1, r2 = myHero.pos, target.pos, myHero.range, 525
            local O1, O2 = CircleCircleIntersection(c1, c2, r1, r2)
            
            if O1 and O2 then
                local closestPoint = Vector(self:ClosestToMouse(O1, O2))
                local castPos = c1:Extended(closestPoint, castRange)
                
                self.E:Cast(castPos)
            end
        elseif castMode == 2 then
            local castPos = myHero.pos:Extended(mousePos, castRange)
            
            self.E:Cast(castPos)
        elseif castMode == 3 then
            local castPos = myHero.pos:Extended(target.pos, castRange)
            
            self.E:Cast(castPos)
        end
    end
    
    function Lucian:Combo()
        local target = self.target
        if not target or not (self.Q:IsReady() or self.W:IsReady() or self.E:IsReady()) then
            if self.R:IsReady() then
                local useR = Menu.R.Combo:Value()
                local mana = Menu.R.ComboMana:Value()
                local rTarg = GetTarget(self.R.Range, 0)
                if useR and self:EnoughMana(mana) and rTarg and self:WhiteListValue(Menu.R.ComboWhiteList, rTarg) then
                    self.R:CastToPred(rTarg, 2)
                end
            end
            return
        end
        
        local useQ2 = Menu.Q2.Combo:Value()
        local mana = Menu.Q2.ComboMana:Value()
        if useQ2 and self:EnoughMana(mana) then
            self:CastQExtended(target)
        end
    end
    
    function Lucian:Harass()
        local target = self.target
        if not target then return end
        
        local useQ1 = Menu.Q.Harass:Value()
        local manaQ1 = Menu.Q.HarassMana:Value()
        if useQ1 and self.Q:IsReady() and self.Q:CanCast(target) and self:EnoughMana(manaQ1) and self:WhiteListValue(Menu.Q.HarassWhiteList, target) then
            self.Q:Cast(target)
        end
        
        local useQ2 = Menu.Q2.Harass:Value()
        local manaQ2 = Menu.Q2.HarassMana:Value()
        if useQ2 and self:EnoughMana(manaQ2) and self:WhiteListValue(Menu.Q2.HarassWhiteList, target) then
            self:CastQExtended(target)
        end
        
        local useW = Menu.W.Harass:Value()
        local manaW = Menu.W.HarassMana:Value()
        if useW and self:EnoughMana(manaW) and self:WhiteListValue(Menu.W.HarassWhiteList, target) then
            self:CastW(target, false, false)
        end
    end
    
    function Lucian:AutoHarass()
        local target = self.target
        if not target then return end
        
        local useQ2 = Menu.Q2.AutoHarass:Value()
        local manaQ2 = Menu.Q2.AutoHarassMana:Value()
        if useQ2 and self:EnoughMana(manaQ2) and self:WhiteListValue(Menu.Q2.AutoHarassWhiteList, target) then
            self:CastQExtended(target)
        end
    end
    
    function Lucian:KillSteal()
        for i = 1, #(self.enemies) do
            local unit = self.enemies[i]
            local health = unit.health
            local shield = unit.shieldAD
            
            local useQ = Menu.Q.KS:Value()
            if self.Q:IsReady() and self.Q:CanCast(unit) and useQ and self:WhiteListValue(Menu.Q.KSWhiteList, unit) then
                local damage = self.Q:CalcDamage(unit)
                
                if health + shield < damage then
                    self.Q:Cast(unit)
                end
            end
            
            local useW = Menu.W.KS:Value()
            if self.W:IsReady() and self.W:CanCast(unit) and useW and self:WhiteListValue(Menu.W.KSWhiteList, unit) then
                local damage = self.W:CalcDamage(unit)
                
                if health + shield < damage then
                    self:CastW(unit, false, false)
                end
            end
        end
    end
    
    function Lucian:OnTick()
        if ShouldWait() then return end
        
        self.mode = GetMode()
        self.target = GetTarget(self.Q2.Range, 0)
        self.enemies = GetEnemyHeroes(self.W.Range)
        self.minions = GetEnemyMinions(self.Q2.Range)
        
        if myHero.isChanneling then return end
        
        self:AutoHarass()
        self:KillSteal()
        
        if not self.mode then return end
        
        local executeMode =
        self.mode == 1 and self:Combo() or
        self.mode == 2 and self:Harass()
    end
    
    function Lucian:OnDraw()
        local rTarg = self.target or GetTarget(self.R.Range, 0)
        if self.mode == 1 and Menu.R.Magnet:Value() and HasBuff(myHero, "LucianR") and rTarg then
            local enemyMovement = rTarg:GetPrediction(huge, 0.3) - rTarg.pos
            self.moveTo = myHero.pos + enemyMovement
        else
            self.moveTo = nil
        end
        DrawSpells(self, function(enemy)
            if Menu and Menu.Draw.Q:Value() and self.Q2 then
                self.Q2:Draw(66, 244, 113)
            end
        end)
    end
    
    function Lucian:OnPreMovement(args)
        if ShouldWait() then
            args.Process = false
            return
        end
        --R Magnet logic
        if self.moveTo then
            if GetDistance(self.moveTo) < 20 then
                if myHero.pathing.hasMovePath then
                    args.Target = myHero.pos
                else
                    args.Process = false
                end
            elseif not MapPosition:inWall(self.moveTo) then
                if GetDistance(self.moveTo) >= self.E.Range and self.E:IsReady() then
                    self.E:Cast(self.moveTo)
                end
                args.Target = self.moveTo
            end
        end
    end
    
    function Lucian:OnPreAttack(args)
        if ShouldWait() then
            args.Process = false
            return
        end
    end
    
    function Lucian:OnPostAttack()
        local target = GetTarget(GetTrueAttackRange(myHero), 0)
        if not IsValidTarget(target) then return end
        local target_type = target.type
        
        if target_type == Obj_AI_Hero then
            if self.mode == 1 then
                local comboRotation = Menu.ComboRotation:Value() - 1
                if Menu.Q.Combo:Value() and (comboRotation == _Q or GameCanUseSpell(comboRotation) ~= READY) and self.Q:IsReady() and GetDistance(target) <= self.Q.Range then
                    self.Q:Cast(target)
                elseif Menu.E.Combo:Value() and (comboRotation == _E or GameCanUseSpell(comboRotation) ~= READY) and self.E:IsReady() and GetDistance(target) <= (self.E.Range + myHero.range) then
                    local castMode = Menu.E.Mode:Value()
                    local castRange = self:DashRange(target)
                    
                    self:CastE(target, castMode, castRange)
                elseif Menu.W.Combo:Value() and (comboRotation == _W or GameCanUseSpell(comboRotation) ~= READY) and self.W:IsReady() and GetDistance(target) <= self.W.Range then
                    local checkPrediction = Menu.W.IgnorePred:Value()
                    local checkCollision = Menu.W.IgnoreColl:Value()
                    
                    self:CastW(target, checkPrediction, checkCollision)
                end
            end
        end
    end
    
	table.insert(LoadCallbacks, function()
		Lucian()
	end)
    
elseif myHero.charName == "Olaf" then
    
    --Written by JSN and provided on:
    --http://gamingonsteroids.com/topic/24468-817-project-winrate-v18-smoother-aa-resetsgsoorb-supported/?p=180176
    
    class 'Olaf'
    
    function Olaf:__init()
        --[[Data Initialization]]
        self.Allies, self.Enemies = {}, {}
        self.scriptVersion = "1.0"
        self:Spells()
        self:Menu()
        --[[Default Callbacks]]
        --Callback.Add("Load",          function() self:OnLoad()    end) --Just Use OnLoad()
        Callback.Add("Tick", function() self:OnTick() end)
        Callback.Add("Draw", function() self:OnDraw() end)
        --[[Orb Callbacks]]
        OnPreAttack(function(...) self:OnPreAttack(...) end)
        OnPostAttack(function(...) self:OnPostAttack(...) end)
        OnPreMovement(function(...) self:OnPreMovement(...) end)
        --[[Custom Callbacks]]
        OnDash(function(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance) self:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance) end)
    end
    
    function Olaf:Spells()
        self.Q = Spell({
            Slot = 0,
            Range = 1000,
            Delay = 0.25,
            Speed = 1600,
            Radius = 70,
            Collision = false,
            From = myHero,
            Type = "SkillShot"
        })
        self.W = Spell({
            Slot = 1,
            Range = 250, -- trigger range
            Delay = 0.25,
            Speed = huge,
            Radius = huge,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
        self.E = Spell({
            Slot = 2,
            Range = 325,
            Delay = 0.25,
            Speed = 20,
            Radius = huge,
            Collision = false,
            From = myHero,
            Type = "Targetted",
            DmgType = "True"
        })
        self.R = Spell({
            Slot = 3,
            Range = 400,
            Delay = 0.25,
            Speed = 500,
            Radius = huge,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
        self.Q.GetDamage = function(spellInstance, enemy, stage)
            if not spellInstance:IsReady() then return 0 end
            --
            local qLvl = myHero:GetSpellData(_Q).level
            return 35 + 45 * qLvl + myHero.bonusDamage
        end
        self.E.GetDamage = function(spellInstance, enemy, stage)
            if not spellInstance:IsReady() then return 0 end
            --
            local eLvl = myHero:GetSpellData(_E).level
            return 25 + 45 * eLvl + 0.5 * myHero.totalDamage
        end
    end
    
    function Olaf:Menu()
        --Q--
        Menu.Q:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.Q:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.Q:MenuElement({id = "Mana", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.Q:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.Q:MenuElement({id = "ManaHarass", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Farm Settings"}})
        Menu.Q:MenuElement({id = "Jungle", name = "Use on JungleClear", value = true})
        Menu.Q:MenuElement({id = "Clear", name = "Use on LaneClear", value = true})
        Menu.Q:MenuElement({id = "Min", name = "Minions To Cast", value = 3, min = 0, max = 8, step = 1})
        Menu.Q:MenuElement({id = "ManaClear", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Misc"}})
        Menu.Q:MenuElement({id = "KS", name = "Use on KS", value = true})
        Menu.Q:MenuElement({id = "Flee", name = "Use on Flee", value = true})
        Menu.Q:MenuElement({id = "Auto", name = "Auto Use on Dashing Enemies", value = true})
        --W--
        Menu.W:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.W:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.W:MenuElement({id = "Mana", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        Menu.W:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.W:MenuElement({id = "Harass", name = "Use on Harass", value = false})
        Menu.W:MenuElement({id = "ManaHarass", name = "Min Mana % ", value = 15, min = 0, max = 100, step = 1})
        --E--
        Menu.E:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.E:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.E:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.E:MenuElement({id = "Harass", name = "Use on Harass", value = false})
        Menu.E:MenuElement({name = " ", drop = {"Misc"}})
        Menu.E:MenuElement({id = "KS", name = "Use on KS", value = true})
        Menu.E:MenuElement({id = "MinHP", name = "Min Health % ", value = 5, min = 0, max = 50, step = 1})
        --R--
        Menu.R:MenuElement({name = " ", drop = {"Misc"}})
        Menu.R:MenuElement({id = "Auto", name = "Use if Hard CC'ed", value = true})
        Menu.R:MenuElement({id = "Min", name = "Min Duration", value = 0.5, min = 0, max = 3, step = 0.1})
        --Items--
        Menu:MenuElement({id = "Items", name = "Items Settings", type = MENU})
        Menu.Items:MenuElement({id = "Tiamat", name = "Use Tiamat", value = true})
        Menu.Items:MenuElement({id = "TitanicHydra", name = "Use Titanic Hydra", value = true})
        Menu.Items:MenuElement({id = "Hydra", name = "Use Ravenous Hydra", value = true})
        Menu.Items:MenuElement({id = "Youmuu", name = "Use Youmuu's", value = true})
        
        Menu:MenuElement({name = " ", drop = {" "}})
        Menu:MenuElement({name = "[WR] "..charName.." Script", drop = {"Release_"..self.scriptVersion}})
        Menu:MenuElement({name = "Olaf Module Created By", drop = {"JSN"}})
    end
    
    function Olaf:OnTick()
        if ShouldWait()then return end
        --
        self.enemies = GetEnemyHeroes(self.Q.Range)
        self.target = GetTarget(self.Q.Range, 0)
        self.mode = GetMode()
        --
        self:UpdateItems()
        self:KillSteal()
        self:Auto()
        --
        if not self.mode then return end
        local executeMode =
        self.mode == 1 and self:Combo() or
        self.mode == 2 and self:Harass() or
        self.mode == 3 and self:Clear() or
        self.mode == 4 and self:Clear() or
        self.mode == 6 and self:Flee()
    end
    
    function Olaf:OnPreMovement(args)
        if ShouldWait() then
            args.Process = false
            return
        end
    end
    
    function Olaf:OnPreAttack(args)
        if ShouldWait() then
            args.Process = false
            return
        end
        --
        if self.W:IsReady() then
            local isHero = args.Target and args.Target.type and args.Target.type == Obj_AI_Hero
            local comboCheck = self.mode == 1 and Menu.W.Combo:Value() and ManaPercent(myHero) >= Menu.W.Mana:Value()
            local harassCheck = self.mode == 2 and Menu.W.Harass:Value() and ManaPercent(myHero) >= Menu.W.ManaHarass:Value()
            if isHero and (comboCheck or harassCheck) then
                self.W:Cast()
            end
        end
    end
    
    function Olaf:OnPostAttack()
        local target = GetTargetByHandle(myHero.attackData.target)
        if ShouldWait() or not IsValidTarget(target) then return end
        --
        if self.mode == 1 or self.mode == 2 then
            self:UseItems(target)
        end
    end
    
    function Olaf:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance)
        if ShouldWait() then return end
        --
        if unit.team == TEAM_ENEMY and Menu.Q.Auto:Value() and self.Q:IsReady() and IsValidTarget(unit, 500) then
            if IsFacing(unit, myHero) or GetDistance(unitPosTo) > 300 then
                self.Q:CastToPred(unit, 3)
            end
        end
    end
    
    function Olaf:Auto()
        if Menu.R.Auto:Value() and IsImmobile(myHero, Menu.R.Min:Value()) then
            self.R:Cast()
        end
    end
    
    function Olaf:KillSteal()
        if self.enemies then
            for i = 1, #self.enemies do
                local enemy = self.enemies[i]
                if GetDistance(enemy) <= self.E.Range and Menu.E.KS:Value() and self.E:IsReady() and self.E:CalcDamage(enemy) >= enemy.health then
                    self.E:Cast(enemy)
                elseif Menu.Q.KS:Value() and self.Q:IsReady() and self.Q:CalcDamage(enemy) >= enemy.health + enemy.shieldAD then
                    self.Q:CastToPred(enemy, 2)
                end
            end
        end
    end
    
    function Olaf:Combo()
        local qTarget = GetTarget(self.Q.Range, 0)
        if qTarget and Menu.Q.Combo:Value() and self.Q:IsReady() and ManaPercent(myHero) >= Menu.Q.Mana:Value()then
            self.Q:CastToPred(qTarget, 2)
        end
        --
        local eTarget = GetTarget(self.E.Range, 2)
        if eTarget and Menu.E.Combo:Value() and self.E:IsReady() and HealthPercent(myHero) >= Menu.E.MinHP:Value()then
            self.E:Cast(eTarget)
        end
        --
        if self.target then
            self:Youmuu(self.target)
        end
    end
    
    function Olaf:Harass()
        local qTarget = GetTarget(self.Q.Range, 0)
        if qTarget and Menu.Q.Harass:Value() and self.Q:IsReady() and ManaPercent(myHero) >= Menu.Q.ManaHarass:Value()then
            self.Q:CastToPred(qTarget, 2)
        end
        --
        local eTarget = GetTarget(self.E.Range, 2)
        if eTarget and Menu.E.Harass:Value() and self.E:IsReady() and HealthPercent(myHero) >= Menu.E.MinHP:Value()then
            self.E:Cast(eTarget)
        end
    end
    
    function Olaf:Clear()
        local qRange, jCheckQ, lCheckQ = self.Q.Range, Menu.Q.Jungle:Value(), Menu.Q.Clear:Value()
        if self.Q:IsReady() and (jCheckQ or lCheckQ) and ManaPercent(myHero) >= Menu.Q.ManaClear:Value() then
            local minions = (jCheckQ and GetMonsters(qRange)) or {}
            minions = (#minions == 0 and lCheckQ and GetEnemyMinions(qRange)) or minions
            if #minions == 0 then return end
            --
            local pos, hit = GetBestLinearCastPos(self.Q, nil, minions)
            if pos and hit >= Menu.Q.Min:Value() or (minions[1] and minions[1].team == TEAM_JUNGLE) then
                self.Q:Cast(pos)
            end
        end
    end
    
    function Olaf:Flee()
        if #self.enemies > 0 and Menu.Q.Flee:Value() and self.Q:IsReady() then
            local qTarget = GetClosestEnemy()
            if IsValidTarget(qTarget, self.Q.Range) then
                self.Q:CastToPred(qTarget, 2)
            end
        end
    end
    
    function Olaf:OnDraw()
        DrawSpells(self)
    end
    
    local ItemHotKey = {[ITEM_1] = HK_ITEM_1, [ITEM_2] = HK_ITEM_2, [ITEM_3] = HK_ITEM_3, [ITEM_4] = HK_ITEM_4, [ITEM_5] = HK_ITEM_5, [ITEM_6] = HK_ITEM_6}
    function Olaf:UpdateItems()
        for i = ITEM_1, ITEM_7 do
            local id = myHero:GetItemData(i).itemID
            --[[In Case They Sell Items]]
            if self.Youmuus and i == self.Youmuus.Index and id ~= 3142 then
                self.Youmuus = nil
            elseif self.Tiamat and i == self.Tiamat.Index and id ~= 3077 then
                self.Tiamat = nil
            elseif self.Hidra and i == self.Hidra.Index and id ~= 3074 then
                self.Hidra = nil
            elseif self.Titanic and i == self.Titanic.Index and id ~= 3748 then
                self.Titanic = nil
            end
            ---
            if id == 3142 then
                self.Youmuus = {Index = i, Key = ItemHotKey[i]}
            elseif id == 3077 then
                self.Tiamat = {Index = i, Key = ItemHotKey[i]}
            elseif id == 3074 then
                self.Hidra = {Index = i, Key = ItemHotKey[i]}
            elseif id == 3748 then
                self.Titanic = {Index = i, Key = ItemHotKey[i]}
            end
        end
    end
    
    function Olaf:UseItems(target)
        if self.Tiamat or self.Hidra then
            self:Hydra(target)
        elseif self.Titanic then
            self:TitanicHydra(target)
        end
    end
    
    function Olaf:UseItem(key, reset)
        KeyDown(key)
        KeyUp(key)
        return reset and DelayAction(function() ResetAutoAttack() end, 0.2)
    end
    
    function Olaf:Youmuu(target)
        if self.Youmuus and Menu.Items.Youmuu:Value() and myHero:GetSpellData(self.Youmuus.Index).currentCd == 0 and IsValidTarget(target, 600) then
            self:UseItem(self.Youmuus.Key, false)
        end
    end
    
    function Olaf:TitanicHydra(target)
        if self.Titanic and Menu.Items.TitanicHydra:Value() and myHero:GetSpellData(self.Titanic.Index).currentCd == 0 and IsValidTarget(target, 380) then
            self:UseItem(self.Titanic.Key, true)
        end
    end
    
    function Olaf:Hydra(target)
        if self.Hidra and Menu.Items.Hydra:Value() and myHero:GetSpellData(self.Hidra.Index).currentCd == 0 and IsValidTarget(target, 380) then
            self:UseItem(self.Hidra.Key, true)
        elseif self.Tiamat and Menu.Items.Tiamat:Value() and myHero:GetSpellData(self.Tiamat.Index).currentCd == 0 and IsValidTarget(target, 380) then
            self:UseItem(self.Tiamat.Key, true)
        end
    end
    
	table.insert(LoadCallbacks, function()
		Olaf()
	end)
 
elseif myHero.charName == "Riven" then
    
    class 'Riven'
    
    function Riven:__init()
        --[[Data Initialization]]
        self.Allies, self.Enemies = {}, {}
        self.scriptVersion = "1.0"
        self:Spells()
        self:Menu()
        --[[Default Callbacks]]
        Callback.Add("Tick", function() self:OnTick() end)
        Callback.Add("Tick", function() self:OnProcessSpell() end)
        Callback.Add("Tick", function() self:OnSpellLoop() end)
        Callback.Add("Draw", function() self:OnDraw() end)
        Callback.Add("WndMsg", function(msg, param) self:OnWndMsg(msg, param) end)
        --[[Orb Callbacks]]
        OnAttack(function(...) self:OnAttack(...) end)
        OnPreAttack(function(...) self:OnPreAttack(...) end)
        OnPostAttack(function(...) self:OnPostAttack(...) end)
        OnPreMovement(function(...) self:OnPreMovement(...) end)
    end
    
    function Riven:Spells()
        self.Flash = myHero:GetSpellData(SUMMONER_1).name:find("Flash") and {Index = SUMMONER_1, Key = HK_SUMMONER_1} or
        myHero:GetSpellData(SUMMONER_2).name:find("Flash") and {Index = SUMMONER_2, Key = HK_SUMMONER_2} or nil
        self.Q = Spell({
            Slot = 0,
            Range = 275,
            Delay = 0.25,
            Speed = huge,
            Radius = 100,
            Collision = false,
            From = myHero,
            Type = "Targetted"
        })
        self.W = Spell({
            Slot = 1,
            Range = 260,
            Delay = 0.25,
            Speed = huge,
            Radius = 260,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
        self.E = Spell({
            Slot = 2,
            Range = 325,
            Delay = 0.25,
            Speed = 2500,
            Radius = 100,
            Collision = false,
            From = myHero,
            Type = "Skillshot"
        })
        self.R1 = Spell({
            Slot = 3,
            Range = huge,
            Delay = 0.5,
            Speed = huge,
            Radius = huge,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
        self.R2 = Spell({
            Slot = 3,
            Range = 1100,
            Delay = 0.25,
            Speed = huge,
            Radius = 150,
            Collision = false,
            From = myHero,
            Type = "Skillshot"
        })
        self.Q.Stacks = 0
        self.Q.LastCast = Timer()
        self.Q.GetDamage = function(spellInstance, enemy, stage)
            if not spellInstance:IsReady() then return 0 end
            --
            local qLvl = myHero:GetSpellData(_Q).level
            return - 5 + 20 * qLvl + (0.40 + 0.05 * qLvl) * myHero.totalDamage
        end
        self.W.GetDamage = function(spellInstance, enemy, stage)
            if not spellInstance:IsReady() then return 0 end
            --
            local wLvl = myHero:GetSpellData(_W).level
            return 25 + 30 * wLvl + myHero.bonusDamage
        end
        self.R2.GetDamage = function(spellInstance, enemy, stage)
            if not spellInstance:IsReady() then return 0 end
            --
            local rLvl = myHero:GetSpellData(_W).level
            local mod = 1 + ((100 - HealthPercent(enemy)) * 0.02667)
            --
            return (50 + 50 * rLvl + 0.6 * myHero.bonusDamage) * mod
        end
        
    end
    
    function Riven:Menu()
        --Q--
        Menu.Q:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.Q:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.Q:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.Q:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.Q:MenuElement({name = " ", drop = {"Farm Settings"}})
        Menu.Q:MenuElement({id = "JungleClear", name = "Use on JungleClear", value = false})
        Menu.Q:MenuElement({id = "LaneClear", name = "Use on LaneClear", value = false})
        Menu.Q:MenuElement({name = " ", drop = {"Misc"}})
        Menu.Q:MenuElement({id = "KS", name = "Use on KS", value = true})
        Menu.Q:MenuElement({id = "Flee", name = "Use on Flee", value = true})
        Menu.Q:MenuElement({id = "Alive", name = "Keep Alive", value = false})
        Menu.Q:MenuElement({id = "Delay", name = "Animation Cancelling", type = MENU})
        Menu.Q.Delay:MenuElement({id = "Q1", name = "Extra Q1 Delay", value = 100, min = 0, max = 200})
        Menu.Q.Delay:MenuElement({id = "Q2", name = "Extra Q2 Delay", value = 100, min = 0, max = 200})
        Menu.Q.Delay:MenuElement({id = "Q3", name = "Extra Q3 Delay", value = 100, min = 0, max = 200})
        --W--
        Menu.W:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.W:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.W:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.W:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.W:MenuElement({name = " ", drop = {"Farm Settings"}})
        Menu.W:MenuElement({id = "JungleClear", name = "Use on JungleClear", value = false})
        Menu.W:MenuElement({id = "LaneClear", name = "Use on LaneClear", value = false})
        Menu.W:MenuElement({name = " ", drop = {"Misc"}})
        Menu.W:MenuElement({id = "AutoStun", name = "Auto Stun Nearby", value = 2, min = 0, max = 5, step = 1})
        Menu.W:MenuElement({id = "KS", name = "Use on KS", value = true})
        Menu.W:MenuElement({id = "Flee", name = "Use on Flee", value = true})
        --E--
        Menu.E:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.E:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.E:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.E:MenuElement({id = "Harass", name = "Use on Harass", value = false})
        Menu.E:MenuElement({name = " ", drop = {"Farm Settings"}})
        Menu.E:MenuElement({id = "JungleClear", name = "Use on JungleClear", value = false})
        Menu.E:MenuElement({id = "LaneClear", name = "Use on LaneClear", value = false})
        Menu.E:MenuElement({name = " ", drop = {"Misc"}})
        Menu.E:MenuElement({id = "KS", name = "Use to Allow KS", value = true})
        Menu.E:MenuElement({id = "Flee", name = "Use on Flee", value = true})
        --R--
        Menu.R:MenuElement({name = " ", drop = {"R1 Settings"}})
        Menu.R:MenuElement({id = "ComboR1", name = "Use on Combo", value = true})
        Menu.R:MenuElement({id = "Heroes", name = "Combo Targets", type = MENU})
        Menu.R:MenuElement({id = "DmgPercent", name = "Min. Damage Percent to Cast", value = 100, min = 50, max = 200})
        Menu.R:MenuElement({id = "MinHealth", name = "Min. Enemy % Health to Cast", value = 5, min = 1, max = 100})
        Menu.R:MenuElement({name = " ", drop = {"R2 Settings"}})
        Menu.R:MenuElement({id = "ComboR2", name = "Use R2 on Combo", value = true})
        Menu.R:MenuElement({id = "KS", name = "Use To KS", value = true})
        --
        Menu:MenuElement({name = " ", drop = {"Extra Features"}})
        --Burst
        Menu:MenuElement({id = "Burst", name = "Burst Settings", type = MENU})
        Menu.Burst:MenuElement({id = "Flash", name = "Allow Flash On Burst", value = true})
        Menu.Burst:MenuElement({id = "ShyKey", name = "Shy Burst Key", key = string.byte("G")})
        Menu.Burst:MenuElement({id = "WerKey", name = "Werhli Burst Key", key = string.byte("T")})
        --Items
        Menu:MenuElement({id = "Items", name = "Items Settings", type = MENU})
        Menu.Items:MenuElement({id = "Tiamat", name = "Use Tiamat", value = true})
        Menu.Items:MenuElement({id = "TitanicHydra", name = "Use Titanic Hydra", value = true})
        Menu.Items:MenuElement({id = "Hydra", name = "Use Ravenous Hydra", value = true})
        Menu.Items:MenuElement({id = "Youmuu", name = "Use Youmuu's", value = true})
        --
        Menu:MenuElement({name = "[WR] "..charName.." Script", drop = {"Release_"..self.scriptVersion}})
        --
		_G.SDK.ObjectManager:OnEnemyHeroLoad(function(args)
			Menu.R.Heroes:MenuElement({id = args.charName, name = args.charName, value = true})
		end)
    end
    
    function Riven:OnTick()
        if ShouldWait() then return end
        --
        self.enemies = GetEnemyHeroes(1300)
        self.target = GetTarget(self.R2.Range, 0)
        self.mode = GetMode()
        --
        self:UpdateSpells()
        self.BurstMode = self:GetActiveBurst()
        
        ----
        if self.BurstMode ~= 0 then return end
        self:Auto()
        self:KillSteal()
        --
        if not self.mode then return end
        local executeMode =
        self.mode == 1 and self:Combo() or
        self.mode == 2 and self:Harass() or
        self.mode == 3 and self:Clear() or
        self.mode == 4 and self:Clear() or
        self.mode == 6 and self:Flee()
    end
    
    function Riven:OnWndMsg(msg, param)
        DelayAction(function() self:UpdateItems() end, 0.1)
        if msg ~= 257 then return end
        --
        local spell
        if param == HK_Q then
            spell = "RivenTriCleave"
        elseif param == HK_E then
            spell = "RivenFeint"
        end
        if not spell then return end
        --
        if self.mode and self.mode == 1 then
            self:OnProcessSpellCombo(spell)
        elseif self.BurstMode == 1 then
            self:OnProcessSpellShy(spell)
        elseif self.BurstMode == 2 then
            self:OnProcessSpellWer(spell)
        end
    end
    
    function Riven:OnPreMovement(args) --args.Process|args.Target
        if ShouldWait() then
            args.Process = false
            return
        end
    end
    
    function Riven:OnPreAttack(args) --args.Process|args.Target
        if ShouldWait() then
            args.Process = false
            return
        end
    end
    
    function Riven:OnAttack()
        local target = GetTargetByHandle(myHero.attackData.target)
        if ShouldWait() or not IsValidTarget(target) then return end
        --
        if self.mode == 1 or self.mode == 2 then
            self:UseItems(target)
        end
    end
    
    function Riven:OnPostAttack()
        local target = GetTarget(400, 0)
        if ShouldWait() or not IsValidTarget(target) then return end
        --
        if self.BurstMode == 1 then
            self:AfterAttackShy(target)
        elseif self.BurstMode == 2 then
            self:AfterAttackWer(target)
        end
        --
        if not self.mode then return end
        if self.mode == 1 then
            self:AfterAttackCombo(target)
        elseif self.mode == 2 then
            self:AfterAttackHarass(target)
        end
    end
    
    function Riven:Auto()
        --
        local time = Timer()
        local qBuff = GetBuffByName(myHero, "RivenTriCleave")
        if qBuff and qBuff.expireTime >= time and Menu.Q.Alive:Value() and qBuff.expireTime - time <= 0.3 and not IsUnderTurret(myHero.pos + myHero.dir * self.Q.Range, TEAM_ENEMY) then
            self.Q:Cast(mousePos)
        end
        --
        local minW = Menu.W.AutoStun:Value()
        if minW ~= 0 and self.W:IsReady() and #(GetEnemyHeroes(self.W.Range)) >= minW then
            self.W:Cast()
        end
        --
        if self:IsR2() and (Menu.R.KS:Value() or (Menu.R.ComboR2:Value() and self.mode == 1)) then
            for i = 1, #self.enemies do
                local target = self.enemies[i]
                if IsValidTarget(target) then --checks for immortal and etc
                    local dmg = self.R2:CalcDamage(target)
                    if dmg > target.health + target.shieldAD then
                        self:CastR2(target, 2)
                    end
                end
            end
            --
            local rBuff = GetBuffByName(myHero, "rivenwindslashready")
            if rBuff and rBuff.expireTime >= time and rBuff.expireTime - time <= 1 or HealthPercent(myHero) <= 20 then
                local targ = GetTarget(self.R2.Range, 0)
                self:CastR2(targ, 1)
            end
        end
    end
    
    function Riven:Combo()
        local target = GetTarget(900, 0)
        if not target then return end
        --
        local attackRange, dist = GetTrueAttackRange(myHero), GetDistance(target)
        if Menu.E.Combo:Value() and self.E:IsReady() and dist <= 600 and dist > attackRange then
            self:CastE(target)
        end
        self:CastYoumuu(target)
        if Menu.Q.Combo:Value() and self.Q:IsReady() and dist <= attackRange + self.Q.Range and dist > attackRange and Timer() - self.Q.LastCast > 1.1 and not myHero.pathing.isDashing then
            self:CastQ(target)
        end
        if Menu.W.Combo:Value() and self.W:IsReady() and dist <= self.W.Range then
            self:CastW(target)
        end
        self:UseItems(target)
        if Menu.R.ComboR1:Value() and self.R1:IsReady() and dist <= 600 and target.health < self:TotalDamage(target) * Menu.R.DmgPercent:Value() / 100 then
            self:CastR1(target)
        end
    end
    
    function Riven:OnProcessSpellCombo(spell)
        local target = GetTarget(self.R2.Range, 0)
        if not (spell and target) then return end
        local dist = GetDistance(target)
        if spell:find("Tiamat") then
            if Menu.W.Combo:Value() and self.W:IsReady() and dist <= self.W.Range then
                self.W:Cast()
            elseif self.Q:IsReady() and dist <= 400 then
                self:CastQ(target)
            end
        elseif spell:find("RivenMartyr") then
            if Menu.R.ComboR2:Value() and self.R1:IsReady() and self:IsR2() then
                self:CheckCastR2(target)
            end
        elseif spell:find("RivenFeint") then
            self:UseItems(target)
            if Menu.R.ComboR1:Value() and self.R1:IsReady() and dist <= 600 and target.health < self:TotalDamage(target) * Menu.R.DmgPercent:Value() / 100 then
                self:CastR1(target)
            elseif Menu.W.Combo:Value() and self.W:IsReady() and dist <= self.W.Range then
                self.W:Cast()
            elseif self.Q:IsReady() and dist <= 400 then
                self:CastQ(target)
            elseif Menu.R.ComboR2:Value() and self.R1:IsReady() and self:IsR2() then
                self:CheckCastR2(target)
            end
        elseif spell:find("RivenFengShuiEngine") then
            if Menu.W.Combo:Value() and self.W:IsReady() and dist <= self.W.Range then
                self.W:Cast()
            end
        elseif spell:find("RivenIzunaBlade") and self.Q.Stacks == 2 then
            if self.Q:IsReady() and dist <= 400 and myHero.attackData.state ~= STATE_WINDUP then
                self:CastQ(target)
            end
        end
    end
    
    function Riven:AfterAttackCombo(target)
        local dist = GetDistance(target)
        if Menu.Q.Combo:Value() and self.Q:IsReady() and dist <= 400 then
            self:CastQ(target)
        elseif Menu.R.ComboR2:Value() and self.R1:IsReady() and self.Q:IsReady() then
            self:CheckCastR2(target)
        elseif Menu.W.Combo:Value() and self.W:IsReady() and dist <= self.W.Range then
            self:CastW(target)
        elseif Menu.E.Combo:Value() and not self.Q:IsReady() and not self.W:IsReady() and self.E:IsReady() and dist <= 400 then
            self:CastE(target)
        end
    end
    
    function Riven:Harass()
        local target = GetTarget(900, 0)
        if not target then return end
        local attackRange = GetTrueAttackRange(myHero)
        if Menu.E.Harass:Value() and self.E:IsReady() and target.distance <= 600 and target.distance > attackRange then
            self:CastE(target)
        end
        if Menu.Q.Harass:Value() and self.Q:IsReady() and target.distance <= attackRange + self.Q.Range and target.distance > attackRange and Timer() - self.Q.LastCast > 1.1 and not myHero.pathing.isDashing then
            self:CastQ(target)
        end
        if Menu.W.Harass:Value() and self.W:IsReady() and target.distance <= self.W.Range then
            self:CastW(target)
        end
        self:UseItems(target)
    end
    
    function Riven:AfterAttackHarass(target)
        if Menu.Q.Harass:Value() and target.distance <= 400 then
            self:CastQ(target)
        elseif Menu.W.Harass:Value() and target.distance <= self.W.Range then
            self:CastW(target)
        elseif Menu.E.Harass:Value() and not self.Q:IsReady() and not self.W:IsReady() and target.distance <= 400 then
            self:CastE(target)
        end
    end
    
    function Riven:Clear()
        local monsters = GetMonsters(self.E.Range)
        if #monsters > 0 then
            local qJungle, wJungle, eJungle = self.Q:IsReady() and Menu.Q.JungleClear:Value(), self.W:IsReady() and Menu.W.JungleClear:Value(), self.E:IsReady() and Menu.E.JungleClear:Value()
            for i = 1, #monsters do
                self:UseItems(monsters[i])
                if qJungle and monsters[i].distance <= self.Q.Range then
                    self.Q:Cast(monsters[i]); return
                elseif wJungle and monsters[i].distance <= self.W.Range then
                    self:PressKey(HK_W); return
                elseif eJungle then
                    self:PressKey(HK_E); return
                end
            end
        else
            local minions = GetEnemyMinions(self.Q.Range)
            if #minions == 0 then return end
            --
            local qClear, wClear = self.Q:IsReady() and Menu.Q.LaneClear:Value(), self.W:IsReady() and Menu.W.LaneClear:Value()
            for i = 1, #minions do
                local minion = minions[i]
                self:UseItems(minion)
                if wClear and minion.distance <= self.W.Range and self.W:CalcDamage(minion) >= minion.health then
                    self:PressKey(HK_W); return
                elseif qClear and minion.distance <= self.Q.Range and self.Q:CalcDamage(minion) >= minion.health then
                    self:CastQ(minion); return
                end
            end
        end
    end
    
    function Riven:Flee()
        Orbwalk()
        DelayAction(function()
            if self.W:IsReady() and Menu.W.Flee:Value() and #(GetEnemyHeroes(self.W.Range)) >= 1 then
                self.W:Cast()
            elseif self.E:IsReady() and Menu.E.Flee:Value() then
                self:PressKey(HK_E)
            elseif self.Q:IsReady() and Menu.Q.Flee:Value() then
                self:PressKey(HK_Q)
            end
        end, 0.2)
    end
    
    function Riven:KillSteal()
    end
    
    function Riven:OnDraw()
        DrawSpells(self, function(enemy)
            local dmg = self:TotalDamage(enemy)
            if IsValidTarget(enemy) and dmg >= enemy.health + enemy.shieldAD then
                local screenPos = enemy.pos:To2D()
                DrawText("Killable", 20, screenPos.x - 30, screenPos.y, DrawColor(255, 255, 0, 0))
            end
        end)
    end
    
    function Riven:ShyCombo()
        local enemy = GetTarget(1500, 0)
        if enemy and enemy.distance <= GetTrueAttackRange(myHero) then
            Orbwalker.ForceTarget = enemy
        else
            Orbwalker.ForceTarget = nil
        end
        Orbwalk()
        if not enemy then return end
        --
        if Menu.Items.Youmuu:Value() then
            self:CastYoumuu(enemy)
        end
        --
        if self.Flash and Ready(self.Flash.Index) and Menu.Burst.Flash:Value() then
            if IsValidTarget(enemy, 500 + self.Q.Range) then
                if self.E:IsReady() then
                    KeyDown(HK_E)
                    DelayAction(function() KeyUp(HK_E) end, 0.01)
                end
                if self.R1:IsReady() and self:IsR1() then
                    DelayAction(function() self.R1:Cast() end, 0.05)
                end
                if self.W:IsReady() and Ready(self.Flash.Index) and enemy.distance > self.E.Range + 100 then
                    DelayAction(function()
                        local delay = (Latency() < 60 and 0) or 0.1 + Latency() / 1000
                        DelayAction(function() self.W:Cast() end, delay)
                        Control.CastSpell(self.Flash.Key, enemy.pos:Extended(myHero.pos, 50))
                    end, 0.1)
                end
                if self.W:IsReady() and enemy.distance < self.W.Range then
                    DelayAction(function() self.W:Cast() end, 0.15)
                end
                if self:HasItems() then
                    DelayAction(function() self:UseItems(enemy) end, 0.2)
                end
                if self.R1:IsReady() and self:IsR2() and enemy.distance < self.R2.Range then
                    DelayAction(function() self.R2:Cast(enemy.pos) end, 0.3)
                end
                if self.Q:IsReady() and enemy.distance < self.Q.Range then
                    DelayAction(function() self.Q:Cast(enemy) end, 0.6)
                end
            end
        elseif enemy.distance < self.E.Range + 100 then
            if IsValidTarget(enemy, self.E.Range) then
                if self.E:IsReady() then
                    KeyDown(HK_E)
                    DelayAction(function() KeyUp(HK_E) end, 0.01)
                end
                if self.R1:IsReady() and self:IsR1() then
                    DelayAction(function() self.R1:Cast() end, 0.05)
                end
                if self.W:IsReady() and enemy.distance < self.W.Range then
                    DelayAction(function() self.W:Cast() end, 0.1)
                end
                if self:HasItems() then
                    DelayAction(function() self:UseItems(enemy) end, 0.15)
                end
                if self.R1:IsReady() and self:IsR2() and enemy.distance < self.R2.Range then
                    DelayAction(function() self.R2:Cast(enemy.pos) end, 0.3)
                end
                if self.Q:IsReady() and enemy.distance < self.Q.Range then
                    DelayAction(function() self.Q:Cast(enemy) end, 0.6)
                end
            end
        end
    end
    
    function Riven:OnProcessSpellShy(spell)
        local target = GetTarget(1500, 0)
        if not (spell and target) then return end
        --
        if spell:find("Tiamat") then
            if self.W:IsReady() and target.distance <= self.W.Range then
                self.W:Cast()
            elseif self.Q:IsReady() and target.distance <= 400 then
                self:CastQ(target)
            end
        elseif spell:find("RivenFeint") then
            if self.R1:IsReady() and self:IsR1() then
                self.R1:Cast()
            elseif self.W:IsReady() and target.distance <= self.W.Range then
                self.W:Cast()
            end
        elseif spell:find("RivenMartyr") then
            if self.R1:IsReady() and self:IsR2() then
                self.R2:Cast(target.pos)
            elseif self.Q:IsReady() and target.distance <= 400 then
                self:CastQ(target)
            end
        elseif spell:find("RivenIzunaBlade") and self.Q.Stacks ~= 2 then
            if self.Q:IsReady() and target.distance <= 400 then
                self:CastQ(target)
            end
        end
    end
    
    function Riven:AfterAttackShy(target)
        self:UseItems(target)
        if self.W:IsReady() and target.distance <= self.W.Range then
            self.W:Cast()
        elseif self.R1:IsReady() and self:IsR2() and IsValidTarget(target, self.R2.Range) then
            self.R2:Cast(target.pos)
        elseif not self.R1:IsReady() and not self.W:IsReady() and self.Q:IsReady() and IsValidTarget(target, self.Q.Range) then
            self:CastQ(target)
        end
    end
    
    function Riven:WerCombo()
        local enemy = GetTarget(1200, 0)
        if enemy and enemy.distance <= GetTrueAttackRange(myHero) then
            Orbwalker.ForceTarget = enemy
        else
            Orbwalker.ForceTarget = nil
        end
        Orbwalk()
        if not enemy then return end
        --
        if Menu.Items.Youmuu:Value() then
            self:CastYoumuu(enemy)
        end
        --
        if self.R1:IsReady() and self:IsR1() then
            DelayAction(function() self.R1:Cast() end, 0.01)
        end
        if self.Flash and Ready(self.Flash.Index) and Menu.Burst.Flash:Value() and enemy.distance > 600 then
            if IsValidTarget(enemy, self.R2.Range - 100) then
                if not self:IsR2() then return end
                if self.E:IsReady() then
                    KeyDown(HK_E)
                    DelayAction(function() KeyUp(HK_E) end, 0.01)
                end
                if self.R2:IsReady() then
                    DelayAction(function() self.R2:Cast(enemy.pos) end, 0.1)
                end
                if self.W:IsReady() and Ready(self.Flash.Index) and GetDistance(myHero, enemy) > self.E.Range + 100 then
                    DelayAction(function()
                        if not self.R1:IsReady() then
                            local delay = (Latency() < 60 and 0) or 0.1 + Latency() / 1000
                            DelayAction(function() self.W:Cast() end, delay)
                            Control.CastSpell(self.Flash.Key, enemy.pos + (myHero.pos - enemy.pos):Normalized() * 50)
                        end
                    end, 0.35)
                end
                if self.W:IsReady() and enemy.distance < self.W.Range then
                    DelayAction(function() self.W:Cast() end, 0.4)
                end
                if self.Q:IsReady() and enemy.distance < self.R2.Range then
                    DelayAction(function() self:CastQ(enemy) end, 0.45)
                end
                if self:HasItems() then
                    DelayAction(function() self:UseItems(enemy) end, 0.5)
                end
            end
        elseif enemy.distance < 600 then
            if IsValidTarget(enemy, 600) then
                if not self:IsR2() then return end
                if self.E:IsReady() then
                    KeyDown(HK_E)
                    DelayAction(function() KeyUp(HK_E) end, 0.01)
                end
                if self.R2:IsReady() then
                    DelayAction(function() self.R2:Cast(enemy.pos) end, 0.1)
                end
                if self.W:IsReady() and enemy.distance < self.W.Range then
                    DelayAction(function()
                        self.W:Cast()
                        KeyUp(HK_W)
                    end, 0.2)
                end
                if self.Q:IsReady() and enemy.distance < self.R2.Range then
                    DelayAction(function() self:CastQ(enemy) end, 0.25)
                end
                if self:HasItems() then
                    DelayAction(function() self:UseItems(enemy) end, 0.3)
                end
            end
        end
    end
    
    function Riven:OnProcessSpellWer(spell)
        local target = GetTarget(self.R2.Range, 0)
        if not (spell and target) then return end
        --
        if Menu.Items.Youmuu:Value() then
            self:CastYoumuu(enemy)
        end
        --
        if spell:find("Tiamat") then
            if self.W:IsReady() and target.distance <= self.W.Range then
                self.W:Cast()
            elseif self.Q:IsReady() and target.distance <= 400 then
                self:CastQ(target)
            end
        elseif spell:find("RivenFeint") then
            if self.R1:IsReady() and self:IsR2() then
                self.R2:Cast(target.pos)
            elseif self.W:IsReady() and target.distance <= self.W.Range then
                self.W:Cast()
            end
        elseif spell:find("RivenMartyr") then
            if self.Q:IsReady() and IsValidTarget(target, 400) then
                self:CastQ(target)
            end
        elseif spell:find("RivenIzunaBlade") and self.Q.Stacks ~= 2 then
            if self.Q:IsReady() and target.distance <= 400 then
                self:CastQ(target)
            end
        end
    end
    
    function Riven:AfterAttackWer(target)
        self:UseItems(target)
        if self.R1:IsReady() and self:IsR2() and IsValidTarget(target, self.R2.Range) then
            self.R2:Cast(target.pos)
        elseif self.W:IsReady() and target.distance <= self.W.Range then
            self.W:Cast()
        elseif self.Q:IsReady() and IsValidTarget(target, self.Q.Range) then
            self:CastQ(target)
        end
    end
    
    function Riven:OnSpellLoop()
        local time = Timer()
        if not self.Q:IsReady() then
            local spellQ = myHero:GetSpellData(_Q)
            for i = 1, 3 do
                local i3 = i ~= 3
                if (i3 and spellQ.cd or 0.25) + time - spellQ.castTime < 0.1 and (i3 and i or 0) == spellQ.ammo and (i3 or self.Q.Stacks ~= 0) and self.Q.Stacks ~= i then
                    --print("Q"..i.." Cast")
                    self.Q.LastCast = time
                    self.Q.Stacks = i
                    self:ResetQ(i); return
                end
            end
        end
    end
    
    local lastSpell = {"Spell Reset", Timer()}
    function Riven:OnProcessSpell()
        local spell = myHero.activeSpell
        local time = Timer()
        if time - lastSpell[2] > 1 then
            lastSpell = {"Spell Reset", time}
        end
        if spell.valid and spell.name ~= lastSpell[1] then
            if self.mode and self.mode == 1 then
                self:OnProcessSpellCombo(spell.name)
            elseif self.BurstMode == 1 then
                self:OnProcessSpellShy(spell.name)
            elseif self.BurstMode == 2 then
                self:OnProcessSpellWer(spell.name)
            end
            lastSpell = {spell.name, time}
        end
    end
    
    function Riven:ResetQ(x)
        if not self.mode or self.mode >= 3 then return end
        local extraDelay = Menu.Q.Delay["Q"..x]:Value()
        DelayAction(function()
            ResetAutoAttack()
            Control.Move(myHero.posTo)
        end, extraDelay / 1000)
    end
    
    function Riven:CastQ(targ)
        local target = targ or mousePos
        if not self.Q:IsReady() or (Orbwalker:CanAttack() and GetDistance(targ) <= GetTrueAttackRange(myHero)) then return end
        self.Q:Cast(targ)
    end
    
    function Riven:CastW(target)
        if not (self.W:IsReady() and IsValidTarget(target, self.W.Range)) then return end
        if self.Q.Stacks ~= 0 or (self.Q.Stacks == 0 and not self.Q:IsReady()) or HasBuff(myHero, "RivenFeint") or not IsFacing(target) then
            self.W:Cast()
        end
    end
    
    function Riven:CastE(target)
        if not (self.E:IsReady() and IsValidTarget(target)) then return end
        local dist, aaRange = GetDistance(target), GetTrueAttackRange(myHero)
        if Menu.Q.Combo:Value() and self.Q:IsReady() and dist <= aaRange + 260 and self.Q.Stacks == 0 then return end
        --
        local qReady, wReady = self.Q:IsReady(), self.W:IsReady()
        local qRange, wRange, eRange = (qReady and self.Q.Stacks == 0 and 260 or 0), (wReady and self.W.Range or 0), self.E.Range
        if (dist <= eRange + qRange) or (dist <= eRange + wRange) or (not wReady and not qReady and dist <= eRange + aaRange) then
            self.E:Cast(target.pos)
        end
    end
    
    function Riven:CastR1(target)
        if not (IsValidTarget(target, self.R2.Range) and self:IsR1() and Menu.R.ComboR1:Value()) or HealthPercent(target) <= Menu.R.MinHealth:Value() then return end
        self.R1:Cast()
    end
    
    function Riven:CastR2(target, hC)
        if not (IsValidTarget(target) and self:IsR2()) then return end
        --
        self.R2.Radius = GetDistance(target) * 0.8
        self.R2:CastToPred(target, hC)
    end
    
    function Riven:CheckCastR2(target)
        if not (IsValidTarget(target) and self:IsR2()) then return end
        local rDmg, aaDmg = self.R2:CalcDamage(target), CalcPhysicalDamage(myHero, target, myHero.totalDamage)
        --
        local rBuff = GetBuffByName(myHero, "rivenwindslashready")
        local time = Timer()
        if rBuff and rBuff.expireTime >= time and rBuff.expireTime - time <= 1 or HealthPercent(myHero) <= 20 or (target.health > rDmg + aaDmg * 2 and HealthPercent(target) < 40) or target.health <= rDmg then
            self:CastR2(target, 2)
        end
    end
    
    function Riven:UpdateSpells()
        if self.Q.Stacks ~= 0 and Timer() - self.Q.LastCast > 3.8 then self.Q.Stacks = 0 end
        if self:IsR2() then self.W.Range = 330 else self.W.Range = 260 end
    end
    
    function Riven:GetActiveBurst()
        if Menu.Burst.ShyKey:Value() then
            self:ShyCombo()
            return 1
        elseif Menu.Burst.WerKey:Value() then
            self:WerCombo()
            return 2
        end
        return 0
    end
    
    function Riven:HasItems()
        return self.Youmuu or self.Tiamat or self.Hydra or self.Titanic or false
    end
    
    function Riven:IsR1()
        return myHero:GetSpellData(_R).name:find("RivenFengShuiEngine")
    end
    
    function Riven:IsR2()
        return myHero:GetSpellData(_R).name:find("RivenIzunaBlade")
    end
    
    local itemID = {Youmuu = 3142, Tiamat = 3077, Hydra = 3074, Titanic = 3748}
    local itemName = {[3142] = "Youmuu", [3077] = "Tiamat", [3074] = "Hydra", [3748] = "Titanic"}
    function Riven:UpdateItems()
        for i = ITEM_1, ITEM_7 do
            local id = myHero:GetItemData(i).itemID
            local name = itemName[id]
            if name then
                if (self[name] and i == self[name].Index and id ~= itemID[name]) then self[name] = nil end --In Case They Sell Items Or Change Slots
                self[name] = {Index = i, Key = ItemHotKey[i]}
            end
        end
    end
    
    function Riven:GetPassive()
        return 0.2 + floor(myHero.levelData.lvl / 3) * 0.05
    end
    
    function Riven:TotalDamage(target)
        local damage = 0
        if self.Q:IsReady() or HasBuff(myHero, "RivenTriCleave") then
            local Qleft = 3 - self.Q.Stacks
            local Qpassive = Qleft * (1 + self:GetPassive())
            damage = damage + self.Q:CalcDamage(target) * (Qleft + Qpassive)
        end
        if self.W:IsReady() then
            damage = damage + self.W:CalcDamage(target)
        end
        if self.R1:IsReady() then
            damage = damage + self.R2:CalcDamage(target)
        end
        damage = damage + CalcPhysicalDamage(myHero, target, myHero.totalDamage)
        return damage
    end
    
    function Riven:UseItems(target)
        if self.Tiamat or self.Hydra then
            self:CastHydra(target)
        elseif self.Titanic then
            self:CastTitanicHydra(target)
        end
    end
    
    function Riven:CastYoumuu(target)
        if self.Youmuu and Menu.Items.Youmuu:Value() and myHero:GetSpellData(self.Youmuu.Index).currentCd == 0 and IsValidTarget(target, 600) then
            self:PressKey(self.Youmuu.Key)
        end
    end
    
    function Riven:CastTitanicHydra(target)
        if self.Titanic and Menu.Items.TitanicHydra:Value() and myHero:GetSpellData(self.Titanic.Index).currentCd == 0 and IsValidTarget(target, 380) then
            self:PressKey(self.Titanic.Key)
            ResetAutoAttack()
        end
    end
    
    function Riven:CastHydra(target)
        if not IsValidTarget(target, 380) then return end
        if self.Hydra and Menu.Items.Hydra:Value() and myHero:GetSpellData(self.Hydra.Index).currentCd == 0 then
            self:PressKey(self.Hydra.Key)
            ResetAutoAttack()
        elseif self.Tiamat and Menu.Items.Tiamat:Value() and myHero:GetSpellData(self.Tiamat.Index).currentCd == 0 then
            self:PressKey(self.Tiamat.Key)
            ResetAutoAttack()
        end
    end
    
    function Riven:PressKey(k)
        KeyDown(k)
        KeyUp(k)
    end
    
	table.insert(LoadCallbacks, function()
		Riven()
	end)
 
elseif myHero.charName == "Sion" then
    
    class 'Sion'
    
    function Sion:__init()
        --[[Data Initialization]]
        self.castingQ = false
        self.scriptVersion = "1.0"
        self:Spells()
        self:Menu()
        --[[Default Callbacks]]
        --Callback.Add("Load",          function() self:OnLoad()    end) --Just Use OnLoad()
        Callback.Add("Tick", function() self:OnTick() end)
        Callback.Add("Draw", function() self:OnDraw() end)
        Callback.Add("WndMsg", function(msg, param) self:OnWndMsg(msg, param) end)
        --[[Orb Callbacks]]
        OnPreAttack(function(...) self:OnPreAttack(...) end)
        OnPreMovement(function(...) self:OnPreMovement(...) end)
        --[[Custom Callbacks]]
        OnInterruptable(function(unit, spell) self:OnInterruptable(unit, spell) end)
        OnDash(function(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance) self:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance) end)
    end
    
    function Sion:Spells()
        self.Q = Spell({
            Slot = 0,
            Range = 750,
            Delay = 0.25,
            Speed = huge,
            Radius = 200, --reduced on purpose
            Collision = false,
            From = myHero,
            Type = "SkillShot"
        })
        self.W = Spell({
            Slot = 1,
            Range = huge,
            Delay = 0.25,
            Speed = huge,
            Radius = 550,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
        self.E = Spell({
            Slot = 2,
            Range = 750,
            Delay = 0.25,
            Speed = 2500,
            Radius = 100,
            Collision = false,
            From = myHero,
            Type = "Skillshot"
        })
        self.E2 = Spell({
            Slot = 2,
            Range = 1550,
            Delay = 0.25,
            Speed = 2500,
            Radius = 100,
            Collision = false,
            From = myHero,
            Type = "Skillshot"
        })
        self.E.ExtraRange = 775
        self.R = Spell({
            Slot = 3,
            Range = 7600,
            Delay = 8,
            Speed = 950,
            Radius = 200,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
    end
    
    function Sion:Menu()
        --Q--
        Menu.Q:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.Q:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.Q:MenuElement({id = "Count", name = "Enemies To Cast", value = 1, min = 0, max = 5, step = 1})
        Menu.Q:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.Q:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.Q:MenuElement({id = "CountHarass", name = "Enemies To Cast", value = 1, min = 0, max = 5, step = 1})
        Menu.Q:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Farm Settings"}})
        Menu.Q:MenuElement({id = "Jungle", name = "Use on JungleClear", value = false})
        Menu.Q:MenuElement({id = "Clear", name = "Use on LaneClear", value = false})
        Menu.Q:MenuElement({id = "Min", name = "Minions To Cast", value = 3, min = 0, max = 6, step = 1})
        Menu.Q:MenuElement({id = "ManaClear", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        --W--
        Menu.W:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.W:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.W:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.W:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.W:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.W:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.W:MenuElement({name = " ", drop = {"Farm Settings"}})
        Menu.W:MenuElement({id = "Jungle", name = "Use on JungleClear", value = false})
        Menu.W:MenuElement({id = "Clear", name = "Use on LaneClear", value = false})
        Menu.W:MenuElement({id = "Min", name = "Minions To Cast", value = 3, min = 0, max = 6, step = 1})
        Menu.W:MenuElement({id = "ManaClear", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.W:MenuElement({name = " ", drop = {"Misc"}})
        Menu.W:MenuElement({id = "Flee", name = "Use on Flee", value = true})
        --E--
        Menu.E:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.E:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.E:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.E:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.E:MenuElement({id = "Harass", name = "Use on Harass", value = false})
        Menu.E:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.E:MenuElement({name = " ", drop = {"Farm Settings"}})
        Menu.E:MenuElement({id = "Jungle", name = "Use on JungleClear", value = false})
        Menu.E:MenuElement({id = "Clear", name = "Use on LaneClear", value = false})
        Menu.E:MenuElement({id = "Min", name = "Minions To Cast", value = 3, min = 0, max = 6, step = 1})
        Menu.E:MenuElement({id = "ManaClear", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.E:MenuElement({name = " ", drop = {"Misc"}})
        Menu.E:MenuElement({id = "KS", name = "Use on KS", value = true})
        Menu.E:MenuElement({id = "Flee", name = "Use on Flee", value = true})
        --R--
        Menu.R:MenuElement({name = "Spell Not Supported", drop = {" "}})
        Menu:MenuElement({name = "[WR] "..charName.." Script", drop = {"Release_"..self.scriptVersion}})
        --
    end
    
    function Sion:OnTick()
        if ShouldWait()then return end
        --
        self.enemies = GetEnemyHeroes(1500)
        self.target = GetTarget(GetTrueAttackRange(myHero), 0)
        self.mode = GetMode()
        --
        if myHero.isChanneling then return end
        self:Auto()
        self:KillSteal()
        --
        if not self.mode then return end
        local executeMode =
        self.mode == 1 and self:Combo() or
        self.mode == 2 and self:Harass() or
        self.mode == 3 and self:Clear() or
        self.mode == 4 and self:Clear() or
        self.mode == 6 and self:Flee()
    end
    
    function Sion:OnWndMsg(msg, param)
        if not self.qCastPos and msg == 256 and param == HK_Q then
            for i = 1, 3 do
                DelayAction(function() self:CheckParticle() end, i * 0.1)
            end
        end
    end
    
    function Sion:OnPreMovement(args) --args.Process|args.Target
        if ShouldWait() or self.castingQ then
            args.Process = false
            return
        end
    end
    
    function Sion:OnPreAttack(args) --args.Process|args.Target
        if ShouldWait() or self.castingQ then
            args.Process = false
            return
        end
    end
    
    function Sion:OnInterruptable(unit, spell)
        if ShouldWait() or self.castingQ then return end
        if Menu.R.Interrupt[spell.name]:Value() and IsValidTarget(enemy) and Ready(_R) then
        end
    end
    
    function Sion:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance)
        if ShouldWait() or self.castingQ then return end
        if IsValidTarget(unit) and GetDistance(unitPosTo) < 500 and unit.team == TEAM_ENEMY and IsFacing(unit, myHero) then --Gapcloser
        end
    end
    
    function Sion:Auto()
    end
    
    function Sion:Combo()
        if self.W:IsReady() and Menu.W.Combo:Value() and ManaPercent(myHero) >= Menu.W.Mana:Value() then
            self:CastW()
        end
        if self.E:IsReady() and Menu.E.Combo:Value() and ManaPercent(myHero) >= Menu.E.Mana:Value() then
            local eTarget = GetTarget(self.E.Range + 775)
            self:CastE(eTarget)
        elseif self.Q:IsReady() and Menu.Q.Combo:Value() and ManaPercent(myHero) >= Menu.Q.Mana:Value() then
            local pos, hit = self.Q:GetBestCircularCastPos(nil, GetEnemyHeroes(self.Q.Range))
            local willHit, entering, leaving = self:CheckPolygon(pos)
            if pos and GetDistance(pos) < 600 and willHit >= Menu.Q.Count:Value() and leaving == 0 then
                self:StartCharging(pos)
            end
        end
    end
    
    function Sion:Harass()
        if self.W:IsReady() and Menu.W.Combo:Value() and ManaPercent(myHero) >= Menu.W.Mana:Value() then
            self:CastW()
        end
        if self.E:IsReady() and Menu.E.Harass:Value() and ManaPercent(myHero) >= Menu.E.ManaHarass:Value() then
            local eTarget = GetTarget(self.E.Range + 775)
            self:CastE(eTarget)
        elseif self.Q:IsReady() and Menu.Q.Harass:Value() and ManaPercent(myHero) >= Menu.Q.ManaHarass:Value() then
            local pos, hit = self.Q:GetBestCircularCastPos(nil, GetEnemyHeroes(self.Q.Range))
            local willHit, entering, leaving = self:CheckPolygon(pos)
            if pos and willHit >= Menu.Q.Count:Value() and leaving == 0 then
                self:StartCharging(pos)
            end
        end
    end
    
    function Sion:Clear()
        local qRange, jCheckQ, lCheckQ = self.Q.Range, Menu.Q.Jungle:Value(), Menu.Q.Clear:Value()
        local wRange, jCheckW, lCheckW = self.W.Radius, Menu.W.Jungle:Value(), Menu.W.Clear:Value()
        local eRange, jCheckE, lCheckE = self.E.Range, Menu.E.Jungle:Value(), Menu.E.Clear:Value()
        --
        if self.W:IsReady() and (jCheckW or lCheckW) then
            local minions = (jCheckW and GetMonsters(wRange)) or {}
            minions = (#minions == 0 and lCheckW and GetEnemyMinions(wRange)) or minions
            if #minions == 0 then return end
            --
            self.W:Cast()
        elseif self.E:IsReady() and (jCheckE or lCheckE) then
            local minions = (jCheckE and GetMonsters(eRange)) or {}
            minions = (#minions == 0 and lCheckE and GetEnemyMinions(eRange)) or minions
            if #minions == 0 then return end
            --
            local pos, hit = GetBestLinearCastPos(self.E, nil, minions)
            if pos and hit >= Menu.E.Min:Value() or (minions[1] and minions[1].team == TEAM_JUNGLE) then
                self.E:Cast(pos)
            end
        elseif self.Q:IsReady() and (jCheckQ or lCheckQ) then
            local minions = (jCheckQ and GetMonsters(qRange)) or {}
            minions = (#minions == 0 and lCheckQ and GetEnemyMinions(qRange)) or minions
            if #minions == 0 then return end
            --
            local pos, hit = GetBestCircularCastPos(self.Q, nil, minions)
            if pos and (hit >= Menu.Q.Min:Value() or (minions[1] and minions[1].team == TEAM_JUNGLE)) then
                self:StartCharging(pos)
                return
            end
        end
    end
    
    function Sion:Flee()
        if self.E:IsReady() and Menu.E.Flee:Value() then
            local eTarget = GetTarget(self.E.Range)
            self:CastE(eTarget)
        elseif self.W:IsReady() and Menu.W.Flee:Value() then
            self:CastW()
        end
    end
    
    function Sion:KillSteal()
        if self.E:IsReady() and Menu.E.KS:Value() then
            local targets = GetEnemyHeroes(self.E.Range + 775)
            for i = 1, #targets do
                local eTarget = targets[i]
                local hp = eTarget.health
                if self.E:GetDamage(eTarget) >= hp and (hp >= 50 or HeroesAround(400, eTarget.pos, TEAM_ALLY) == 0) then
                    if self:CastE(eTarget) then return end
                end
            end
        end
    end
    
    function Sion:OnDraw()
        self:LogicQ()
        DrawSpells(self)
    end
    
    function Sion:LogicQ()
        --[[As of March/2018 EXT's myHero.dir wont update if you cast the spell somewhere you're not facing. To fix that, I used Sion's Q particle.]]
        local spell = myHero.activeSpell
        self.castingQ = spell.isCharging and spell.name == "SionQ" --HasBuff(myHero, "SionQ")
        if not self.castingQ then
            local qSpell = myHero:GetSpellData(self.Q.Slot)
            if (qSpell.currentCd ~= 0 and qSpell.cd - qSpell.currentCd > 0.5) then
                self.qCastPos = nil
                if IsKeyDown(HK_Q) then KeyUp(HK_Q) end--release stuck key
            end
            return
        end
        --
        local qRange = self.Q.Range
        local willHit, entering, leaving = self:CheckPolygon()
        DrawText("Q will hit: "..willHit, myHero.pos:To2D())
        if entering <= leaving and (willHit > 0 or entering == 0) then
            if leaving > 0 and IsKeyDown(HK_Q) then
                KeyUp(HK_Q) --release skill
            end
        end
    end
    
    function Sion:CheckPolygon(targetPos)
        local pP, eP = myHero.pos, targetPos or self.qCastPos
        local endPointCenter = targetPos and pP + (eP - pP):Normalized() * 770 or RotateAroundPoint(pP + (eP - pP):Normalized() * 770, pP, (0.5 / 180) * pi) --0.5 degrees for angleCorrection fml
        --
        local perpend1, perpend2 = (pP - eP):Perpendicular():Normalized(), (pP - eP):Perpendicular2():Normalized()
        local startPoint1, startPoint2 = pP + 160 * perpend1, pP + 180 * perpend2 --why the fuck is this not symmetrical rito
        local endPoint1, endPoint2 = endPointCenter + 290 * perpend1, endPointCenter + 290 * perpend2
        --
        local willHit, entering, leaving = 0, 0, 0
        local qPolygon = Polygon(Point(startPoint1), Point(endPoint1), Point(endPoint2), Point(startPoint2))
        for i = 1, #self.enemies do
            local target = self.enemies[i]
            local tP, tP2 = Point(target.pos), Point(target:GetPrediction(huge, 0.2))
            --
            if qPolygon:__contains(tP) then --if inside(might leave)
                willHit = willHit + 1
                if not qPolygon:__contains(tP2) then leaving = leaving + 1 end
            else --if outside(might come in)
                if qPolygon:__contains(tP2) then entering = entering + 1 end
            end
        end
        --qPolygon:__draw()
        --[[Maxxx 2dGeoLib draw functions are broken, I told him already how to fix and am waiting for response.]] --Fixed, we're waiting for Fere to push a lib update
        --DrawLine(startPoint1:To2D(), startPoint2:To2D())
        --DrawLine(startPoint1:To2D(), endPoint1:To2D())
        --DrawLine(endPoint1:To2D(), endPoint2:To2D())
        --DrawLine(endPoint2:To2D(), startPoint2:To2D())
        return willHit, entering, leaving
    end
    
    function Sion:CheckParticle()
        for i = 1, ParticleCount() do
            local obj = Particle(i)
            if obj then
                if obj.name:find("Sion_Base_Q_Indicator") then
                    self.qCastPos = obj.pos
                    return true
                end
            end
        end
    end
    
    local castSpell = {state = 0, tick = GetTickCount(), casting = GetTickCount() - 1000, mouse = mousePos}
    function Sion:StartCharging(pos)
        local ticker = GetTickCount()
        if castSpell.state == 0 and GetDistance(myHero.pos, pos) < self.Q.Range + 100 and ticker - castSpell.casting > self.Q.Delay + Latency() and pos:ToScreen().onScreen then
            castSpell.state = 1
            castSpell.mouse = mousePos
            castSpell.tick = ticker
        end
        if castSpell.state == 1 then
            if ticker - castSpell.tick < Latency() then
                SetCursorPos(pos)
                self.qCastPos = pos
                KeyDown(HK_Q)
                castSpell.casting = ticker + self.Q.Delay
                DelayAction(function()
                    if castSpell.state == 1 then
                        SetCursorPos(castSpell.mouse)
                        castSpell.state = 0
                    end
                end, Latency() / 1000)
            end
            if ticker - castSpell.casting > Latency() then
                SetCursorPos(castSpell.mouse)
                castSpell.state = 0
            end
        end
    end
    
    function Sion:CastE(eTarget)
        if not IsValidTarget(eTarget) then return end
        if GetDistance(eTarget) <= self.E.Range then
            return self.E:CastToPred(eTarget, 2)
        else
            local extendTargets, temp = GetEnemyMinions(self.E.Range), GetMonsters(self.E.Range)
            for i = 1, #temp do extendTargets[#extendTargets + 1] = temp[i] end
            local bestPos, castPos, hC = self.E2:GetPrediction(eTarget)
            if bestPos and hC >= 2 and #mCollision(myHero.pos, bestPos, self.E, extendTargets) >= 1 then
                return self.E:Cast(bestPos)
            end
        end
    end
    
    function Sion:CastW()
        if #GetEnemyHeroes(self.W.Radius) >= 1 then
            return self.W:Cast()
        end
    end
    
    table.insert(LoadCallbacks, function()
        Sion()
    end)
    
elseif myHero.charName == "Syndra" then
    
    class 'Syndra'
    
    function Syndra:__init()
        --[[Data Initialization]]
        self.scriptVersion = "1.0"
        self:Spells()
        self:Menu()
        --[[Default Callbacks]]
        Callback.Add("Tick", function() self:OnTick() end)
        Callback.Add("Draw", function() self:OnDraw() end)
        Callback.Add("WndMsg", function(msg, param) self:OnWndMsg(msg, param) end)
        --[[Orb Callbacks]]
        OnPreAttack(function(...) self:OnPreAttack(...) end)
        OnPreMovement(function(...) self:OnPreMovement(...) end)
        --[[Custom Callbacks]]
        OnInterruptable(function(unit, spell) self:OnInterruptable(unit, spell) end)
        OnDash(function(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance) self:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance) end)
        
    end
    
    function Syndra:Spells()
        self.Q = Spell({
            Slot = 0,
            Range = 800,
            Delay = 0.85,
            Speed = huge,
            Radius = 150,
            Collision = false,
            From = myHero,
            Type = "AOE",
            DmgType = "Magical"
        })
        self.QE = Spell({
            Slot = 2,
            Range = 1200,
            Delay = 0.25,
            Speed = 1600,
            Radius = 60,
            Collision = false,
            From = myHero,
            Type = "Skillshot",
        })
        self.W = Spell({
            Slot = 1,
            Range = 925,
            Delay = 0.25,
            Speed = 1450,
            Radius = 100,
            Collision = false,
            From = myHero,
            Type = "AOE",
            DmgType = "Magical"
        })
        self.E = Spell({
            Slot = 2,
            Range = 700,
            Delay = 0.25,
            Speed = 2500,
            Radius = 100,
            Collision = false,
            From = myHero,
            Type = "Skillshot",
            DmgType = "Magical"
        })
        self.R = Spell({
            Slot = 3,
            Range = 675,
            Delay = 0.25,
            Speed = huge,
            Radius = 0,
            Collision = false,
            From = myHero,
            Type = "Targetted",
            DmgType = "Magical"
        })
        self.OrbData = {
            Obj = {},
            Spawning = nil,
            SearchParticles = true,
            SearchMissiles = true,
        }
        self.Q.GetDamage = function(spellInstance, enemy, stage)
            if not spellInstance:IsReady() then return 0 end
            --
            local qLvl = myHero:GetSpellData(_Q).level
            local dmg = 30 + 40 * qLvl + 0.65 * myHero.ap
            --
            if qLvl == 5 and enemy.type == Obj_AI_Hero then
                dmg = dmg + 34.5 + 0.0975 * myHero.ap
            end
            return dmg
        end
        self.W.GetDamage = function(spellInstance, enemy, stage)
            if not spellInstance:IsReady() then return 0 end
            --
            local wLvl = myHero:GetSpellData(_W).level
            local dmg = 30 + 40 * wLvl + 0.7 * myHero.ap
            --
            if wLvl == 5 then
                dmg = dmg + 46 + 0.14 * myHero.ap
            end
            return dmg
        end
        self.R.GetDamage = function(spellInstance, enemy, stage)
            if not spellInstance:IsReady() then return 0 end
            --
            local rLvl = myHero:GetSpellData(_R).level
            local ammo = myHero:GetSpellData(_R).ammo or 3
            --
            return (45 + 45 * rLvl + 0.2 * myHero.ap) * ammo
        end
    end
    
    function Syndra:Menu()
        --Q--
        Menu.Q:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.Q:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.Q:MenuElement({id = "Pred", name = "Prediction Mode", value = 1, drop = {"Faster", "More Precise"}})
        Menu.Q:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.Q:MenuElement({id = "AutoHarass", name = "Auto Harass", value = true})
        Menu.Q:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.Q:MenuElement({id = "PredHarass", name = "Prediction Mode", value = 2, drop = {"Faster", "More Precise"}})
        Menu.Q:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Misc"}})
        Menu.Q:MenuElement({id = "KS", name = "Use to KS", value = true})
        Menu.Q:MenuElement({id = "Auto", name = "Auto Use on Immobile", value = true})
        --W--
        Menu.W:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.W:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.W:MenuElement({id = "Pred", name = "Prediction Mode", value = 1, drop = {"Faster", "More Precise"}})
        Menu.W:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.W:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.W:MenuElement({id = "AutoHarass", name = "Auto Harass", value = true})
        Menu.W:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.W:MenuElement({id = "PredHarass", name = "Prediction Mode", value = 2, drop = {"Faster", "More Precise"}})
        Menu.W:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.W:MenuElement({name = " ", drop = {"Misc"}})
        Menu.W:MenuElement({id = "KS", name = "Use to KS", value = true})
        Menu.W:MenuElement({id = "Auto", name = "Auto Use on Immobile", value = true})
        --E--
        Menu.E:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.E:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.E:MenuElement({id = "Pred", name = "Prediction Mode", value = 1, drop = {"Faster", "More Precise"}})
        Menu.E:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.E:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.E:MenuElement({id = "Harass", name = "Use on Harass", value = false})
        Menu.E:MenuElement({id = "PredHarass", name = "Prediction Mode", value = 1, drop = {"Faster", "More Precise"}})
        Menu.E:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.E:MenuElement({name = " ", drop = {"Misc"}})
        Menu.E:MenuElement({id = "KS", name = "Use on KS", value = true})
        Menu.E:MenuElement({id = "Flee", name = "Use on Flee", value = true})
        --R--
        Menu.R:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.R:MenuElement({id = "KS", name = "Use on KS", value = true})
        Menu.R:MenuElement({id = "Heroes", name = "Whitelist", type = MENU})
        --
        Menu:MenuElement({name = " ", drop = {"Extra Features"}})
        --Q+E
        Menu:MenuElement({id = "QE", name = "Q+E Settings", type = MENU})
        Menu.QE:MenuElement({id = "ComboQ", name = "Use on Combo", value = true})
        Menu.QE:MenuElement({id = "HarassQ", name = "Use on Harass", value = true})
        Menu.QE:MenuElement({id = "Flee", name = "Use on Flee", value = true})
        Menu.QE:MenuElement({id = "Interrupt", name = "Interrupt Targets", type = MENU})
        Menu.QE:MenuElement({id = "Gapcloser", name = "Anti Gapcloser", type = MENU})
        --
        Menu:MenuElement({name = "[WR] "..charName.." Script", drop = {"Release_"..self.scriptVersion}})
        --
		_G.SDK.ObjectManager:OnEnemyHeroLoad(function(args)
			local hero = args.unit
			local charName = args.charName
			Interrupter:AddToMenu(hero, Menu.QE.Interrupt)
			Menu.QE.Gapcloser:MenuElement({id = charName, name = charName, value = true})
			Menu.R.Heroes:MenuElement({id = charName, name = charName, value = true})
		end)
    end
    
    function Syndra:OnTick()
        if ShouldWait() then return end
        --
        self:ClearBalls()
        self.enemies = GetEnemyHeroes(1200)
        self.target = GetTarget(1200, 0)
        self.mode = GetMode()
        --
        if myHero.isChanneling then return end
        self:Auto()
        self:KillSteal()
        --
        if not self.mode then return end
        local executeMode =
        self.mode == 1 and self:Combo() or
        self.mode == 2 and self:Harass() or
        self.mode == 6 and self:Flee()
    end
    
    function Syndra:OnWndMsg(msg, param)
        if param >= HK_Q and param <= HK_R then
            self:UpdateBalls()
        end
    end
    
    function Syndra:OnPreMovement(args) --args.Process|args.Target
        if ShouldWait() then
            args.Process = false
            return
        end
    end
    
    function Syndra:OnPreAttack(args) --args.Process|args.Target
        if ShouldWait() then
            args.Process = false
            return
        end
    end
    
    function Syndra:OnInterruptable(unit, spell)
        if ShouldWait() then return end
        if Menu.QE.Interrupt[spell.name] and Menu.QE.Interrupt[spell.name]:Value() and IsValidTarget(enemy) and self.E:IsReady() then
            self:CastE(1, unit)
        end
    end
    
    function Syndra:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance)
        if ShouldWait() or not (IsValidTarget(unit, self.Q.Range) and unit.team == TEAM_ENEMY) then return end
        if Menu.QE.Gapcloser[unit.charName] and Menu.QE.Gapcloser[unit.charName]:Value() and GetDistance(unitPosTo) <= self.QE.Range and IsFacing(unit, myHero) then --Gapcloser
            self:CastE(1, unit)
        elseif Menu.Q.Auto:Value() and GetDistance(unitPosTo) <= self.Q.Range then
            self.Q:CastToPred(unit, 2)
        end
    end
    
    function Syndra:Auto()
        if Menu.Q.Auto:Value() then
            for i = 1, #self.enemies do
                local enemy = self.enemies[i]
                if GetDistance(enemy) <= self.Q.Range and IsImmobile(enemy, 0.5) then
                    self.Q:Cast(enemy)
                end
            end
        end
        if Menu.Q.AutoHarass:Value() then
            self:Harass(true)
        end
    end
    
    function Syndra:Combo()
        local target = self.target
        if not target then return end
        --
        if Menu.Q.Combo:Value() and ManaPercent(myHero) >= Menu.Q.Mana:Value() then
            self:CastQ(target, Menu.Q.Pred:Value())
        end
        if Menu.E.Combo:Value() and ManaPercent(myHero) >= Menu.E.Mana:Value() then
            self:CastE(Menu.E.Pred:Value())
        end
        if Menu.W.Combo:Value() and ManaPercent(myHero) >= Menu.W.Mana:Value() then
            self:CastW(target, Menu.W.Pred:Value())
        end
    end
    
    function Syndra:Harass(auto)
        local target = self.target
        if not target then return end
        --
        if Menu.Q.Harass:Value() and ManaPercent(myHero) >= Menu.Q.ManaHarass:Value() then
            self:CastQ(target, Menu.Q.PredHarass:Value())
        end
        --
        if auto then return end
        if Menu.W.Harass:Value() and ManaPercent(myHero) >= Menu.W.ManaHarass:Value() then
            self:CastW(target, Menu.W.PredHarass:Value())
        end
        if Menu.E.Harass:Value() and ManaPercent(myHero) >= Menu.E.ManaHarass:Value() then
            self:CastE(Menu.E.PredHarass:Value())
        end
    end
    
    function Syndra:Flee()
        if not self.E:IsReady() then return end
        for i = 1, #self.enemies do
            local enemy = self.enemies[i]
            if GetDistance(enemy) <= 900 and Menu.QE.Flee:Value() then
                self:CastE(1, enemy)
            elseif GetDistance(enemy) <= 400 and Menu.E.Flee:Value() then
                self.E:CastToPred(enemy, 1)
            end
        end
    end
    
    function Syndra:KillSteal(unit)
        for i = 1, #self.enemies do
            local unit = self.enemies[i]
            if not IsValidTarget(unit) then return end
            --
            if self.Q:IsReady() and self.Q:CanCast(unit) and Menu.Q.KS:Value() then
                local damage = self.Q:CalcDamage(unit)
                if unit.health + unit.shieldAP < damage then
                    self:CastQ(unit, 1); return
                end
            end
            if self.W:IsReady() and self.W:CanCast(unit) and Menu.W.KS:Value() then
                local damage = self.W:CalcDamage(unit)
                if unit.health + unit.shieldAP < damage then
                    self:CastW(unit, 1); return
                end
            end
            if self.R:IsReady() and self.R:CanCast(unit) and Menu.R.KS:Value() and Menu.R.Heroes[unit.charName] and Menu.R.Heroes[unit.charName]:Value() then
                local damage = self.R:CalcDamage(unit, 2)
                if unit.health + unit.shieldAP < damage then
                    self.R:Cast(unit); return
                end
            end
        end
    end
    
    function Syndra:OnDraw()
        DrawSpells(self)
    end
    
    function Syndra:UpdateBalls()
        --
        local qCd = myHero:GetSpellData(_Q).currentCd
        if qCd == 0 then
            self.OrbData.SearchParticles = true
        elseif qCd > 0 and self.OrbData.SearchParticles then
            self.OrbData.SearchParticles = false
            self.OrbData.Spawning = self:GetSpawningOrb()
        end
        
        DelayAction(function()
            self.OrbData.Spawning = nil
            self:LoopOrbs()
        end, 0.75)
        
        --Update spells
        if self.R.Range ~= 750 and myHero:GetSpellData(_R).level >= 3 then
            self.R.Range = 750
        end
    end
    
    function Syndra:CastQ(target, hC)
        if self.Q:IsReady() and self.Q:CanCast(target) then
            self.Q:CastToPred(target, hC)
        end
    end
    
    function Syndra:CastW(target, hC)
        if self.W:IsReady() and self.W:CanCast(target) then
            local toggleState = myHero:GetSpellData(_W).toggleState
            if toggleState == 2 then
                self.W:CastToPred(target, hC)
            elseif toggleState == 1 then
                CastPosition = self:GrabObj()
                if CastPosition then
                    self.W:Cast(CastPosition)
                end
            end
        end
    end
    
    function Syndra:CanHitQE(target, orbPos, castPos)
        if self.E:IsReady() and GetDistance(orbPos) <= self.E.Range then
            local startPos, endPos = orbPos:Extended(myHero.pos, 100), orbPos:Extended(myHero.pos, -(1050 - 0.6 * GetDistance(orbPos)))
            DrawCircle(startPos)
            DrawCircle(endPos)
            local pointSegment, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(startPos, endPos, castPos)
            return isOnSegment and GetDistance(pointLine, castPos) <= (self.QE.Radius + target.boundingRadius)
        end
    end
    
    function Syndra:CastE(hC, target)
        local enemy = target or GetTarget(1200, 1)
        if not (self.E:IsReady() and enemy) then return end
        --
        local unitPos, castPos, hitChance = self.QE:GetPrediction(enemy)
        if castPos and hitChance >= 1 then
            local pos = self.OrbData.PrePos
            if pos and self:CanHitQE(enemy, pos, castPos) then
                self.E:Cast(pos)
            else
                for i, orb in pairs(self.OrbData.Obj) do
                    if orb and not orb.dead and self:CanHitQE(enemy, orb.pos, castPos) then
                        self.E:Cast(orb.pos)
                        return
                    end
                end
                --[[In Case there are no orbs]]
                if self.Q:IsReady() then
                    local bestCast = myHero.pos:Extended(castPos, GetDistance(myHero, enemy) * 0.6)
                    self.Q:Cast(bestCast)
                    DelayAction(function() self.E:Cast(bestCast) end, 0.2)
                end
            end
        end
    end
    
    function Syndra:GrabObj()
        for i = 1, #self.OrbData.Obj do
            local orb = self.OrbData.Obj[i]
            if orb and not orb.dead and GetDistance(orb) <= self.W.Range then
                return orb.pos
            end
        end
        
        local minions = GetEnemyMinions(self.W.Range)
        for i = 1, #minions do
            local minion = minions[i]
            if minion and not minion.dead and GetDistance(minion) < self.W.Range then
                return minion.pos
            end
        end
    end
    
    function Syndra:ClearBalls()
        for i = 1, #self.OrbData.Obj do
            local orb = self.OrbData.Obj[i]
            if orb and orb.dead then
                remove(self.OrbData.Obj, i)
            end
        end
    end
    
    function Syndra:GetSpawningOrb()
        for i = ParticleCount(), 1, -1 do
            local obj = Particle(i)
            if obj and obj.type == "obj_GeneralParticleEmitter" and obj.name:find("_aoe_gather.troy") then
                return obj.pos
            end
        end
    end
    
    function Syndra:LoopOrbs()
        objectCount = ObjectCount()
        for i = ObjectCount(), 1, -1 do
            local obj = Object(i)
            if obj and not obj.dead and obj.name:lower() == "seed" then
                self.OrbData.Obj[#self.OrbData.Obj + 1] = obj
            end
        end
    end
    
    table.insert(LoadCallbacks, function()
        Syndra()
    end)
    
elseif myHero.charName == "Talon" then
    
    class 'Talon'
    
    function Talon:__init()
        --[[Data Initialization]]
        self.fleeTimer = Timer()
        self.scriptVersion = "1.0"
        self:Spells()
        self:Menu()
        --[[Default Callbacks]]
        Callback.Add("Tick", function() self:OnTick() end)
        Callback.Add("Draw", function() self:OnDraw() end)
    end
    
    function Talon:Spells()
        self.Q = Spell({
            Slot = 0,
            Range = 500,
            Delay = 0.25,
            Speed = huge,
            Radius = 0,
            Collision = false,
            From = myHero,
            Type = "Targetted"
        })
        self.W = Spell({
            Slot = 1,
            Range = 750,
            Delay = 0.25,
            Speed = 1450,
            Radius = 250,
            Collision = false,
            From = myHero,
            Type = "Skillshot"
        })
        self.E = Spell({
            Slot = 2,
            Range = 0,
            Delay = 0.25,
            Speed = 0,
            Radius = 0,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
        self.R = Spell({
            Slot = 3,
            Range = 550,
            Delay = 0.25,
            Speed = huge,
            Radius = 550,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
        local flashData = myHero:GetSpellData(SUMMONER_1).name:find("Flash") and SUMMONER_1 or myHero:GetSpellData(SUMMONER_2).name:find("Flash") and SUMMONER_2 or nil
        self.Flash = flashData and Spell({
            Slot = flashData,
            Range = 400,
            Delay = 0.25,
            Speed = huge,
            Radius = 200,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
    end
    
    function Talon:Menu()
        --Q--
        Menu.Q:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.Q:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.Q:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.Q:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.Q:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Farm Settings"}})
        Menu.Q:MenuElement({id = "LastHit", name = "Use to LastHit", value = false})
        Menu.Q:MenuElement({id = "ManaClear", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Misc"}})
        Menu.Q:MenuElement({id = "Auto", name = "Auto Proc Passive", value = true})
        --W--
        Menu.W:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.W:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.W:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.W:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.W:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.W:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.W:MenuElement({name = " ", drop = {"Farm Settings"}})
        Menu.W:MenuElement({id = "Clear", name = "Use on LaneClear", value = false})
        Menu.W:MenuElement({id = "Min", name = "Minions To Cast", value = 3, min = 0, max = 6, step = 1})
        Menu.W:MenuElement({id = "ManaClear", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        --E--
        Menu.E:MenuElement({name = " ", drop = {"Misc"}})
        Menu.E:MenuElement({id = "Flee", name = "Use on Flee", value = true})
        --R--
        Menu.R:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.R:MenuElement({id = "Auto", name = "Use When Surrounded", value = true})
        Menu.R:MenuElement({id = "Min", name = "Min X Enemies Around", value = 2, min = 1, max = 5, step = 1})
        Menu.R:MenuElement({id = "Combo", name = "Use To Assassinate", value = true})
        Menu.R:MenuElement({id = "Heroes", name = "Assassinate Targets", type = MENU})
        Menu.R:MenuElement({id = "Mana", name = "Min Mana %", value = 0, min = 0, max = 100, step = 1})
        --Burst
        Menu:MenuElement({id = "Burst", name = "Burst Settings", type = MENU})
        Menu.Burst:MenuElement({id = "Flash", name = "Allow Flash On Burst", value = true})
        Menu.Burst:MenuElement({id = "Key", name = "Burst Key", key = string.byte("T")})
        Menu:MenuElement({name = "[WR] "..charName.." Script", drop = {"Release_"..self.scriptVersion}})
        --
		_G.SDK.ObjectManager:OnEnemyHeroLoad(function(args)
			Menu.R.Heroes:MenuElement({id = args.charName, name = args.charName, value = false})
		end)
    end
    
    function Talon:OnTick()
        if ShouldWait() then return end
        --
        self.enemies = GetEnemyHeroes(self.W.Range)
        self.target = GetTarget(self.W.Range, 0)
        self.mode = GetMode()
        --
        if Menu.Burst.Key:Value() then
            self:Burst()
            return
        end
        if myHero.isChanneling then return end
        self:Auto()
        --
        if not self.mode then return end
        local executeMode =
        self.mode == 1 and self:Combo() or
        self.mode == 2 and self:Harass() or
        self.mode == 3 and self:Clear() or
        self.mode == 4 and self:Clear() or
        self.mode == 5 and self:LastHit() or
        self.mode == 6 and self:Flee()
    end
    
    function Talon:Auto()
        if not self.target then return end
        --
        if self.Q:IsReady() and Menu.Q.Auto:Value() then
            self:ProcQ()
        end
        if self.mode == 1 and self.R:IsReady() and Menu.R.Auto:Value() and #self.enemies >= Menu.R.Min:Value() and not self:Stealthed() then
            self.R:Cast()
        end
    end
    
    function Talon:Combo()
        local wTarget = self.target
        if not wTarget then return end
        --
        if self.R:IsReady() and Menu.R.Combo:Value() and ManaPercent(myHero) >= Menu.R.Mana:Value() and not self:Stealthed() then
            if GetDistance(wTarget) <= self.R.Range and Menu.R.Heroes[wTarget.charName] and Menu.R.Heroes[wTarget.charName]:Value() then
                self.R:Cast()
                return
            end
        end
        if self.W:IsReady() and Menu.W.Combo:Value() and not self:Stealthed() and ManaPercent(myHero) >= Menu.W.Mana:Value() then
            self.W:CastToPred(wTarget, 2)
        elseif self.Q:IsReady() and Menu.Q.Combo:Value() and ManaPercent(myHero) >= Menu.Q.Mana:Value() then
            self.Q:Cast(wTarget)
            ResetAutoAttack()
        end
    end
    
    function Talon:Harass()
        local wTarget = self.target
        if not wTarget then return end
        --
        if self.W:IsReady() and Menu.W.Harass:Value() and not self:Stealthed() and ManaPercent(myHero) >= Menu.W.ManaHarass:Value() then
            self.W:CastToPred(wTarget, 2)
        elseif self.Q:IsReady() and Menu.Q.Harass:Value() and ManaPercent(myHero) >= Menu.Q.ManaHarass:Value() then
            self:ProcQ()
        end
    end
    
    function Talon:Clear()
        if self.W:IsReady() and Menu.W.Clear:Value() and ManaPercent(myHero) >= Menu.W.ManaClear:Value() then
            local pos, hit = GetBestCircularFarmPos(self.W)
            if hit >= Menu.W.Min:Value() then
                self.W:Cast(pos)
            end
        end
    end
    
    dmgTableClean = 0
    function Talon:LastHit()
        if self.Q:IsReady() and Menu.Q.LastHit:Value() and ManaPercent(myHero) >= Menu.Q.ManaClear:Value() then
            --
            if Timer() - dmgTableClean >= 1 then
                self.dmgTable = {Melee = {}, Ranged = {}}
                self.minions = GetEnemyMinions(self.Q.Range)
                dmgTableClean = Timer()
            end
            --
            for i = 1, #self.minions do
                local minion = self.minions[i]
                --
                local range = GetDistance(minion) <= 225 and "Melee" or "Ranged"
                local qDmg = self.dmgTable[range][minion.charName]
                if not qDmg then
                    qDmg = self:GetDamage(_Q, minion)
                    self.dmgTable[range][minion.charName] = qDmg
                end
                --
                if qDmg >= minion.health then
                    self.Q:Cast(minion)
                    return --Last Hit
                end
            end
        end
    end
    
    function Talon:Flee()
        if Timer() - self.fleeTimer >= 0.5 then
            self.E:Cast()
            self.fleeTimer = Timer()
        end
    end
    
    function Talon:OnDraw()
        DrawSpells(self)
    end
    
    function Talon:Burst()
        Orbwalk()
        if self.Q:IsReady() and self.W:IsReady() and self.R:IsReady() then
            local canFlash = self.Flash and self.Flash:IsReady() and Menu.Burst.Flash:Value()
            local range = self.Q.Range + (canFlash and self.Flash.Range or 0)
            local bTarget, eTarget = GetTarget(range, 0), GetTarget(self.Q.Range, 0)
            local shouldFlash = canFlash and bTarget ~= eTarget
            --
            if bTarget then
                self:BurstCombo(bTarget, shouldFlash, shouldFlash and 1 or 2)
            end
        end
    end
    
    function Talon:BurstCombo(target, shouldFlash, step)
        if step == 1 then
            if shouldFlash then
                local pos, hK = mousePos, self.Flash:SlotToHK()
                SetCursorPos(target.pos)
                KeyDown(hK)
                KeyUp(hK)
                DelayAction(function() SetCursorPos(pos) end, 0.05)
            end
            DelayAction(function() self:BurstCombo(target, shouldFlash, 2) end, 0.3)
        elseif step == 2 then
            self.W:CastToPred(target, 1)
            DelayAction(function()
                self.Q:Cast(target)
                self.R:Cast()
            end, 0.3)
        end
    end
    
    function Talon:CalculatePhysicalDamage(target, damage)
        if target and damage then
            local targetArmor = target.armor * myHero.armorPenPercent - myHero.armorPen
            local damageReduction = 100 / (100 + targetArmor)
            if targetArmor < 0 then
                damageReduction = 2 - (100 / (100 - targetArmor))
            end
            damage = damage * damageReduction
            return damage
        end
        return 0
    end
    
    function Talon:GetDamage(skill, targ)
        if skill == _Q then
            local level = myHero:GetSpellData(_Q).level
            local IsMelee = targ and GetDistance(targ) <= 225
            local rawDmg = (40 + 25 * level + 1.1 * myHero.bonusDamage) * (IsMelee and 1.5 or 1)
            return self:CalculatePhysicalDamage(targ, rawDmg)
        end
    end
    
    function Talon:Stealthed()
        return HasBuff(myHero, "TalonRStealth")
    end
    
    function Talon:ProcQ()
        for i = 1, #self.enemies do
            local target = self.enemies[i]
            if GetDistance(target) <= self.Q.Range then
                local buff = GetBuffByName(target, "TalonPassiveStack")
                if buff and buff.count == 2 then
                    self.Q:Cast(target)
                    return
                end
            end
        end
    end
    
    table.insert(LoadCallbacks, function()
        Talon()
    end)
    
elseif myHero.charName == "Teemo" then
    
    class 'Teemo'
    
    function Teemo:__init()
        --[[Data Initialization]]
        self:ShroomData()
        self.Color1 = DrawColor(255, 35, 219, 81)
        self.Color2 = DrawColor(255, 216, 121, 26)
        self.scriptVersion = "1.0"
        self:Spells()
        self:Menu()
        --[[Default Callbacks]]
        Callback.Add("Tick", function() self:OnTick() end)
        Callback.Add("Draw", function() self:OnDraw() end)
        Callback.Add("WndMsg", function(msg, param) self:OnWndMsg(msg, param) end)
    end
    
    function Teemo:Spells()
        self.Q = Spell({
            Slot = 0,
            Range = 680,
            Delay = 0.25,
            Speed = 0,
            Radius = 0,
            Collision = false,
            From = myHero,
            Type = "Targetted"
        })
        self.W = Spell({
            Slot = 1,
            Range = 0,
            Delay = 0.25,
            Speed = 0,
            Radius = 0,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
        self.R = Spell({
            Slot = 3,
            Range = 400,
            Delay = 1.0,
            Speed = 1600,
            Radius = 150,
            Collision = false,
            From = myHero,
            Type = "AOE"
        })
        self.R.LastCast = 0
    end
    
    function Teemo:Menu()
        --Q--
        Menu.Q:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.Q:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.Q:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.Q:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.Q:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Misc"}})
        Menu.Q:MenuElement({id = "Melee", name = "Auto Use on Melee", value = true})
        --W--
        Menu.W:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.W:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.W:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.W:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.W:MenuElement({id = "Harass", name = "Use on Harass", value = false})
        Menu.W:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.W:MenuElement({name = " ", drop = {"Misc"}})
        Menu.W:MenuElement({id = "Flee", name = "Use on Flee", value = true})
        --E--
        Menu.E:MenuElement({name = " ", drop = {"Misc"}})
        Menu.E:MenuElement({id = "Auto", name = "Free ELO", value = true})
        --R--
        Menu.R:MenuElement({name = " ", drop = {"WR Shroom Helper"}})
        Menu.R:MenuElement({id = "Enabled", name = "Enabled", value = true})
        Menu.R:MenuElement({id = "MinAmmo", name = "Save Min X Shrooms", value = 2, min = 0, max = 2, step = 1})
        Menu.R:MenuElement({id = "Draw", name = "Draw Nearby Spots", value = true})
        
        Menu.R:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.R:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.R:MenuElement({id = "Mana", name = "Min Mana %", value = 0, min = 0, max = 100, step = 1})
        Menu:MenuElement({name = "[WR] "..charName.." Script", drop = {"Release_"..self.scriptVersion}})
        --
    end
    
    function Teemo:OnTick()
        if ShouldWait() then return end
        --
        self.enemies = GetEnemyHeroes(1500)
        self.target = GetTarget(self.Q.Range + 300, 0)
        self.mode = GetMode()
        --
        self:UpdateSpots()
        if myHero.isChanneling then return end
        self:Auto()
        --
        if not self.target or not self.mode then return end
        local executeMode =
        self.mode == 1 and self:Combo() or
        self.mode == 2 and self:Harass() or
        self.mode == 6 and self:Flee()
    end
    
    function Teemo:OnWndMsg(msg, param)
        if param == HK_R then
            for delay = 1, 2, 0.5 do
                DelayAction(function()
                    self:FindShrooms()
                end, delay)
            end
        end
        
        local level = myHero:GetSpellData(_R).level
        if level > 1 then
            self.R.Range = 150 + 250 * level
        end
    end
    
    function Teemo:Auto()
        local qMelee = GetTarget(300, 1)
        if self.Q:IsReady() and qMelee and Menu.Q.Melee:Value() then
            self.Q:Cast(qMelee)
        end
        
        if self.mode ~= 6 and self.R:IsReady() and Timer() - self.R.LastCast >= 1.5 and Menu.R.Enabled:Value() and myHero:GetSpellData(_R).ammo > Menu.R.MinAmmo:Value() then
            for i = 1, #self.nearbySpots do
                local spot = self.nearbySpots[i]
                if GetDistance(myHero, spot) <= self.R.Range and not spot.active then
                    self.R:Cast(spot.pos)
                    self.R.LastCast = Timer()
                    return
                end
            end
        end
    end
    
    function Teemo:Combo()
        local target = self.target
        local distance = GetDistance(myHero, target)
        --
        if self.W:IsReady() and Menu.W.Combo:Value() and ManaPercent(myHero) >= Menu.W.Mana:Value() and (distance <= 300 or distance >= 550) then
            self.W:Cast()
        elseif self.Q:IsReady() and Menu.Q.Combo:Value() and ManaPercent(myHero) >= Menu.Q.Mana:Value() and distance <= self.Q.Range then
            self.Q:Cast(target)
        elseif self.R:IsReady() and Timer() - self.R.LastCast >= 3 and Menu.R.Combo:Value() and ManaPercent(myHero) >= Menu.R.Mana:Value() and distance <= self.R.Range then
            self.R:CastToPred(target, 3)
            self.R.LastCast = Timer()
        end
    end
    
    function Teemo:Harass()
        local target = self.target
        local distance = GetDistance(myHero, target)
        --
        if self.W:IsReady() and Menu.W.Combo:Value() and ManaPercent(myHero) >= Menu.W.Mana:Value() and (distance <= 300 or distance >= 550) then
            self.W:Cast()
        elseif self.Q:IsReady() and Menu.Q.Combo:Value() and ManaPercent(myHero) >= Menu.Q.Mana:Value() and distance <= self.Q.Range then
            self.Q:Cast(target)
        end
    end
    
    function Teemo:Flee()
        if self.W:IsReady() and Menu.W.Flee:Value() and GetTarget(self.Q.Range, 1) then
            self.W:Cast()
        end
    end
    
    function Teemo:OnDraw()
        DrawSpells(self)
        --
        if Menu.Draw.ON:Value() then
            if self.nearbySpots and Menu.R.Draw:Value() then
                for i = 1, #self.nearbySpots do
                    local spot = self.nearbySpots[i]
                    DrawCircle(spot.pos, 30, spot.active and self.Color1 or self.Color2)
                end
            end
        end
    end
    
    function Teemo:UpdateSpots()
        for k, obj in pairs(self.nearbyShrooms) do
            if not obj or not obj.valid or obj.dead then
                self:SectorDataExecutor(obj, function(spot, obj)
                    if GetDistanceSqr(spot, obj) <= 200 * 200 then
                        spot.active = false
                    end
                end)
                self.nearbyShrooms[k] = nil
            end
        end
        
        self.nearbySpots = {}
        self:SectorDataExecutor(myHero, function(spot, obj)
            if GetDistanceSqr(spot.pos, myHero) <= 1000 * 1000 and spot.pos:To2D().onScreen then
                self.nearbySpots[#self.nearbySpots + 1] = spot
            end
        end)
    end
    
    function Teemo:CheckNearbySpots(x, z)
        if self.shroomSpots[x][z] then
            local t = self.shroomSpots[x][z]
            for i = 1, #t do --Worst Case = 3
                local spot = t[i]
                if GetDistanceSqr(spot.pos, myHero) <= 1000 * 1000 and spot.pos:To2D().onScreen then
                    self.nearbySpots[#self.nearbySpots + 1] = spot
                end
            end
        end
    end
    
    function Teemo:FindShrooms()
        for i = ObjectCount(), 1, -1 do
            local obj = Object(i)
            if obj and not obj.dead and obj.name == "Noxious Trap" then
                self:SectorDataExecutor(obj, function(spot, obj)
                    if GetDistanceSqr(spot, obj) <= 200 * 200 then
                        spot.active = true
                    end
                end)
                self.nearbyShrooms[obj.networkID] = obj
            end
        end
    end
    
    function Teemo:SectorDataExecutor(obj, func)
        local xFloor, zFloor = floor(obj.pos.x / 1000), floor(obj.pos.z / 1000)
        for x = xFloor - 1, xFloor + 1 do
            if self.shroomSpots[x] then
                for z = zFloor - 1, zFloor + 1 do
                    if self.shroomSpots[x][z] then
                        local t = self.shroomSpots[x][z]
                        for j = 1, #t do
                            local spot = t[j]
                            func(spot, obj)
                        end
                    end
                end
            end
        end
    end
    
    function Teemo:ShroomData()
        self.nearbySpots = {}
        self.nearbyShrooms = {}
        self.shroomSpots = {
            [1] = {
                [12] = {
                    {active = false, pos = Vector(1170, 0, 12320)},
                },
                [13] = {
                    {active = false, pos = Vector(1671, 0, 13000)},
                },
            },
            [2] = {
                [4] = {
                    {active = false, pos = Vector(2742, 0, 4959)},
                },
                [7] = {
                    {active = false, pos = Vector(2997, 0, 7597)},
                },
                [11] = {
                    {active = false, pos = Vector(2807, 0, 11909)},
                    {active = false, pos = Vector(2247, 0, 11847)},
                },
                [12] = {
                    {active = false, pos = Vector(2875, 0, 12553)},
                },
                [13] = {
                    {active = false, pos = Vector(2400, 0, 13511)},
                },
            },
            [3] = {
                [7] = {
                    {active = false, pos = Vector(3157, 0, 7206)},
                },
                [9] = {
                    {active = false, pos = Vector(3548, 0, 9286)},
                    {active = false, pos = Vector(3752, 0, 9437)},
                },
                [10] = {
                    {active = false, pos = Vector(3067, 0, 10899)},
                },
                [11] = {
                    {active = false, pos = Vector(3857, 0, 11358)},
                },
                [12] = {
                    {active = false, pos = Vector(3900, 0, 12829)},
                },
            },
            [4] = {
                [2] = {
                    {active = false, pos = Vector(4972, 0, 2882)},
                },
                [6] = {
                    {active = false, pos = Vector(4698, 0, 6140)},
                },
                [7] = {
                    {active = false, pos = Vector(4750, 0, 7211)},
                },
                [8] = {
                    {active = false, pos = Vector(4749, 0, 8022)},
                },
                [10] = {
                    {active = false, pos = Vector(4703, 0, 10063)},
                },
                [11] = {
                    {active = false, pos = Vector(4467, 0, 11841)},
                },
            },
            [5] = {
                [3] = {
                    {active = false, pos = Vector(5716, 0, 3505)},
                },
            },
            [6] = {
                [4] = {
                    {active = false, pos = Vector(6546, 0, 4723)},
                },
                [9] = {
                    {active = false, pos = Vector(6200, 0, 9288)},
                },
                [10] = {
                    {active = false, pos = Vector(6019, 0, 10405)},
                },
                [11] = {
                    {active = false, pos = Vector(6800, 0, 11558)},
                },
                [12] = {
                    {active = false, pos = Vector(6780, 0, 13011)},
                },
            },
            [7] = {
                [2] = {
                    {active = false, pos = Vector(7968, 0, 2197)},
                },
                [3] = {
                    {active = false, pos = Vector(7973, 0, 3362)},
                    {active = false, pos = Vector(7117, 0, 3100)},
                },
                [6] = {
                    {active = false, pos = Vector(7225, 0, 6216)},
                },
                [11] = {
                    {active = false, pos = Vector(7768, 0, 11808)},
                },
                [12] = {
                    {active = false, pos = Vector(7252, 0, 12546)},
                },
            },
            [8] = {
                [5] = {
                    {active = false, pos = Vector(8619, 0, 5622)},
                },
                [10] = {
                    {active = false, pos = Vector(8280, 0, 10245)},
                },
            },
            [9] = {
                [2] = {
                    {active = false, pos = Vector(9222, 0, 2129)},
                },
                [6] = {
                    {active = false, pos = Vector(9702, 0, 6319)},
                },
                [11] = {
                    {active = false, pos = Vector(9371, 0, 11445)},
                },
                [12] = {
                    {active = false, pos = Vector(9845, 0, 12060)},
                },
            },
            [10] = {
                [1] = {
                    {active = false, pos = Vector(10900, 0, 1970)},
                },
                [3] = {
                    {active = false, pos = Vector(10407, 0, 3091)},
                },
                [4] = {
                    {active = false, pos = Vector(10097, 0, 4972)},
                },
                [6] = {
                    {active = false, pos = Vector(10081, 0, 6590)},
                },
                [7] = {
                    {active = false, pos = Vector(10070, 0, 7299)},
                },
            },
            [11] = {
                [2] = {
                    {active = false, pos = Vector(11700, 0, 2036)},
                    {active = false, pos = Vector(11866, 0, 3186)},
                },
                [3] = {
                    {active = false, pos = Vector(11024, 0, 3883)},
                    {active = false, pos = Vector(11866, 0, 3186)},
                },
                [4] = {
                    {active = false, pos = Vector(11730, 0, 4091)},
                },
                [5] = {
                    {active = false, pos = Vector(11230, 0, 5575)},
                },
                [7] = {
                    {active = false, pos = Vector(11627, 0, 7103)},
                    {active = false, pos = Vector(11873, 0, 7530)},
                },
            },
            [12] = {
                [1] = {
                    {active = false, pos = Vector(12225, 0, 1292)},
                },
                [2] = {
                    {active = false, pos = Vector(12987, 0, 2028)},
                },
                [3] = {
                    {active = false, pos = Vector(12827, 0, 3131)},
                },
                [5] = {
                    {active = false, pos = Vector(12611, 0, 5318)},
                },
                [8] = {
                    {active = false, pos = Vector(12133, 0, 8821)},
                },
                [9] = {
                    {active = false, pos = Vector(12063, 0, 9974)},
                },
            },
            [13] = {
                [2] = {
                    {active = false, pos = Vector(13499, 0, 2837)},
                },
            },
        }
    end
    
    table.insert(LoadCallbacks, function()
        Teemo()
    end)
    
elseif myHero.charName == "Thresh" then
    
    class 'Thresh'
    
    function Thresh:__init()
        --[[Data Initialization]]
        self.scriptVersion = "1.0"
        self:Spells()
        self:Menu()
        --[[Default Callbacks]]
        Callback.Add("Tick", function() self:OnTick() end)
        Callback.Add("Draw", function() self:OnDraw() end)
        --[[Custom Callbacks]]
        OnInterruptable(function(unit, spell) self:OnInterruptable(unit, spell) end)
        OnDash(function(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance) self:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance) end)
    end
    
    function Thresh:Spells()
        self.Q = Spell({
            Slot = 0,
            Range = 1100 - 100, --max range misses most of the time zz
            Delay = 0.5,
            Speed = 1900,
            Radius = 70,
            Collision = true,
            From = myHero,
            Type = "SkillShot"
        })
        self.Q2 = Spell({
            Slot = 0,
            Range = huge,
            Delay = 0.5,
            Speed = 1900,
            Radius = 70,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
        self.W = Spell({
            Slot = 1,
            Range = 950,
            Delay = 0.25,
            Speed = 1450,
            Radius = 150,
            Collision = false,
            From = myHero,
            Type = "AOE"
        })
        self.E = Spell({
            Slot = 2,
            Range = 450,
            Delay = 0.25,
            Speed = 1100,
            Radius = 150,
            Collision = false,
            From = myHero,
            Type = "SkillShot"
        })
        self.R = Spell({
            Slot = 3,
            Range = 375,
            Delay = 0.25,
            Speed = huge,
            Radius = 320,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
    end
    
    function Thresh:Menu()
        --Q--
        Menu.Q:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.Q:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.Q:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.Q:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.Q:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Interrupt Settings"}})
        Menu.Q:MenuElement({id = "Interrupter", name = "Use To Interrupt", value = true})
        Menu.Q:MenuElement({id = "Interrupt", name = "Interrupt Targets", type = MENU})
        Menu.Q:MenuElement({name = " ", drop = {"Misc"}})
        Menu.Q:MenuElement({id = "Auto", name = "Auto Use on Immobile", value = true})
        Menu.Q:MenuElement({id = "Dashing", name = "Auto Use on Dashing", value = true})
        --W--
        Menu.W:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.W:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.W:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.W:MenuElement({name = " ", drop = {"Misc"}})
        Menu.W:MenuElement({id = "Flee", name = "Use on Flee", value = true})
        Menu.W:MenuElement({id = "HardCC", name = "Use on CCed Allies", value = true})
        --E--
        Menu.E:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.E:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.E:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.E:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.E:MenuElement({id = "Harass", name = "Use on Harass", value = false})
        Menu.E:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.E:MenuElement({name = " ", drop = {"Interrupt Settings"}})
        Menu.E:MenuElement({id = "Interrupter", name = "Use To Interrupt", value = true})
        Menu.E:MenuElement({id = "Interrupt", name = "Interrupt Targets", type = MENU})
        Menu.E:MenuElement({name = " ", drop = {"Misc"}})
        Menu.E:MenuElement({id = "Dashing", name = "Auto Use on Dashing", value = true})
        Menu.E:MenuElement({id = "Flee", name = "Use on Flee", value = true})
        Menu.E:MenuElement({id = "Key", name = "Toggle Push-Pull", key = string.byte("T"), toggle = true})
        Menu.E:MenuElement({id = "Draw", name = "Draw Toggle State", value = false})
        --R--
        Menu.R:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.R:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.R:MenuElement({id = "Count", name = "When X Enemies Around", value = 2, min = 1, max = 5, step = 1})
        Menu.R:MenuElement({name = " ", drop = {"Misc"}})
        Menu.R:MenuElement({id = "Auto", name = "Auto Use When X Enemies Around", value = 3, min = 0, max = 5, step = 1})
        
        Menu.R:MenuElement({id = "Mana", name = "Min Mana %", value = 0, min = 0, max = 100, step = 1})
        Menu:MenuElement({name = "[WR] "..charName.." Script", drop = {"Release_"..self.scriptVersion}})
        --
		_G.SDK.ObjectManager:OnEnemyHeroLoad(function(args)
			Interrupter:AddToMenu(args.unit, Menu.Q.Interrupt)
			Interrupter:AddToMenu(args.unit, Menu.E.Interrupt)
		end)
    end
    
    function Thresh:OnTick()
        if ShouldWait() then return end
        --
        self.enemies = GetEnemyHeroes(self.Q.Range)
        self.target = GetTarget(self.E.Range, 0)
        self.mode = GetMode()
        --
        if myHero.isChanneling then return end
        self:Auto()
        --
        if not self.mode then return end
        local executeMode =
        self.mode == 1 and self:Combo() or
        self.mode == 2 and self:Harass() or
        self.mode == 6 and self:Flee()
    end
    
    function Thresh:OnInterruptable(unit, spell)
        if not IsValidTarget(unit) or ShouldWait() then return end
        --
        if self.E:IsReady() and GetDistance(unit) < self.E.Range and Menu.E.Interrupter:Value() and Menu.E.Interrupt[spell.name]:Value() then
            self.E:Cast(self:GetPosE(unit, "Pull"))
        elseif self.Q:IsReady() and GetDistance(unit) < self.Q.Range and Menu.Q.Interrupter:Value() and Menu.Q.Interrupt[spell.name]:Value() then
            self.Q:CastToPred(unit, 2)
        end
    end
    
    function Thresh:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance)
        if unit.team ~= TEAM_ENEMY or ShouldWait() or not IsValidTarget(unit, self.Q.Range) then return end
        --
        if self.E:IsReady() and GetDistance(unit) < self.E.Range then
            if GetDistance(unitPosTo) < self.E.Range and IsFacing(unit, myHero) then --Gapcloser
                self.E:Cast(self:GetPosE(unit, "Push"))
            elseif GetDistance(unitPosTo) > self.E.Range and not IsFacing(unit, myHero) then --Running Away
                self.E:Cast(self:GetPosE(unit, "Pull"))
            end
        elseif Menu.Q.Dashing:Value() and self.Q:IsReady() then
            self.Q:CastToPred(unit, 3)
        end
    end
    
    function Thresh:OnDraw()
        DrawSpells(self)
        local pLambda = Menu.E.Draw:Value() and DrawText("E Mode:" .. (Menu.E.Key:Value() and "Push" or "Pull"), 20, myHero.pos:To2D().x - 33, myHero.pos:To2D().y + 60, DrawColor(255, 000, 255, 000))
    end
    
    function Thresh:Auto()
        local nearby = #GetEnemyHeroes(self.R.Range)
        --
        if self.R:IsReady() and nearby > 0 then
            local autoMin = Menu.R.Auto:Value()
            local autoCheck = autoMin ~= 0 and nearby >= autoMin and Menu.R.Auto:Value()
            local comboCheck = self.mode == 1 and nearby >= Menu.R.Count:Value() and Menu.R.Combo:Value()
            --
            if autoCheck or comboCheck then
                self.R:Cast()
                return
            end
        end
        --
        if self.Q:IsReady() and Menu.Q.Auto:Value() then
            for i = 1, #self.enemies do
                local enemy = self.enemies[i]
                if IsImmobile(enemy, 0.75) then
                    self.Q:Cast(enemy)
                    return
                end
            end
        end
        --
        if self.W:IsReady() then
            local comboCheck = Menu.W.Combo:Value() and self.mode == 1 and ManaPercent(myHero) >= Menu.W.Mana:Value()
            if Menu.W.HardCC:Value() or comboCheck then
                local allies = GetAllyHeroes(self.W.Range)
                local furthest = myHero
                --
                for i = 1, #allies do
                    local ally = allies[i]
                    local enemyCount = CountEnemiesAround(ally, 800)
                    --
                    if ally.health < enemyCount * ally.levelData.lvl * 25 then
                        self.W:Cast(ally); return
                    end
                    if hardCC and IsImmobile(ally) and enemyCount > 0 then
                        self.W:Cast(ally); return
                    end
                    --
                    if GetDistanceSqr(ally) >= GetDistanceSqr(furthest) then
                        furthest = ally
                    end
                end
                --
                if comboCheck and not self.Q:IsReady() and GetDistance(furthest) >= 600 then
                    self.W:Cast(furthest)
                end
            end
        end
    end
    
    function Thresh:Flee()
        if self.target then
            if Menu.E.Flee:Value() and self.E:IsReady() then
                self.E:Cast(self:GetPosE(self.target, "Push"))
            elseif Menu.W.Flee:Value() and self.W:IsReady() then
                self.W:Cast(myHero)
            end
        end
    end
    
    function Thresh:GetPosE(unit, mode)
        local push = mode == "Push" and true or Menu.E.Key:Value()
        --
        return myHero.pos:Extended(unit.pos, self.E.Range * (push and 1 or - 1))
    end
    
    function Thresh:Combo()
        local target = GetTarget(self.Q.Range, 0)
        if not target then return end
        --
        if self.E:IsReady() and Menu.E.Combo:Value() and GetDistance(target) < self.E.Range and ManaPercent(myHero) >= Menu.E.Mana:Value() then
            local flayTowards = self:GetPosE(target)
            self.E:Cast(flayTowards)
        elseif self.Q:IsReady() and Menu.Q.Combo:Value() and ManaPercent(myHero) >= Menu.Q.Mana:Value()then
            self.Q:CastToPred(target, 2)
        end
    end
    
    function Thresh:Harass()
        local target = GetTarget(self.Q.Range, 0)
        if not target then return end
        --
        if self.E:IsReady() and Menu.E.Harass:Value() and GetDistance(target) < self.E.Range and ManaPercent(myHero) >= Menu.E.ManaHarass:Value() then
            local flayTowards = self:GetPosE(target)
            self.E:Cast(flayTowards)
        elseif self.Q:IsReady() and Menu.Q.Harass:Value() and ManaPercent(myHero) >= Menu.Q.ManaHarass:Value()then
            self.Q:CastToPred(target, 2)
        end
    end
    
    table.insert(LoadCallbacks, function()
        Thresh()
    end)
    
elseif myHero.charName == "TwistedFate" then
    
    class 'TwistedFate'
    
    function TwistedFate:__init()
        --[[Data Initialization]]
        self.Allies, self.Enemies = {}, {}
        self.scriptVersion = "1.0"
        self:Spells()
        self:Menu()
        --[[Default Callbacks]]
        Callback.Add("Tick", function() self:OnTick() end)
        Callback.Add("Draw", function() self:OnDraw() end)
        --[[Orb Callbacks]]
        OnAttack(function(...) self:OnAttack(...) end)
        OnPreAttack(function(...) self:OnPreAttack(...) end)
        OnPreMovement(function(...) self:OnPreMovement(...) end)
    end
    
    function TwistedFate:Spells()
        self.Q = Spell({
            Slot = 0,
            Range = 1400,
            Delay = 0.25,
            Speed = huge,
            Radius = 50,
            Collision = false,
            From = myHero,
            Type = "SkillShot"
        })
        self.W = Spell({
            Slot = 1,
            Range = huge,
            From = myHero,
            Type = "Press"
        })
        self.R = Spell({
            Slot = 3,
            Range = 5500,
            Delay = 1,
            Speed = huge,
            Radius = 150,
            Collision = false,
            From = myHero,
            Type = "AOE"
        })
        self.W.Pick = "DONTPICKSHIT"
        self.W.LastCast = 0
    end
    
    function TwistedFate:Menu()
        --Q--
        Menu.Q:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.Q:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.Q:MenuElement({id = "Pred", name = "Prediction Mode", value = 2, drop = {"Faster", "More Precise"}})
        Menu.Q:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.Q:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.Q:MenuElement({id = "PredHarass", name = "Prediction Mode", value = 2, drop = {"Faster", "More Precise"}})
        Menu.Q:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Misc"}})
        Menu.Q:MenuElement({id = "Auto", name = "Auto Use on Immobile", value = true})
        Menu.Q:MenuElement({id = "KS", name = "Use on KS", value = true})
        --W--
        Menu.W:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.W:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.W:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.W:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.W:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.W:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.W:MenuElement({name = " ", drop = {"Misc"}})
        Menu.W:MenuElement({id = "Auto", name = "Pick Gold Card On Ult", value = true})
        Menu.W:MenuElement({id = "ManaMin", name = "Pick Blue Card if Mana < X", value = 30, min = 0, max = 100, step = 1})
        Menu.W:MenuElement({id = "Flee", name = "Use on Flee", value = true})
        
        Menu:MenuElement({name = " ", drop = {"Extra Features"}})
        --CardPicker
        Menu:MenuElement({id = "Key", name = "Card Picker", type = MENU})
        Menu.Key:MenuElement({id = "Gold", name = "Pick Gold Card", key = string.byte("E")})
        Menu.Key:MenuElement({id = "Blue", name = "Pick Blue Card", key = string.byte("T")})
        Menu.Key:MenuElement({id = "Red", name = "Pick Red Card", key = string.byte("Z")})
        
        Menu:MenuElement({name = "[WR] "..charName.." Script", drop = {"Release_"..self.scriptVersion}})
    end
    
    function TwistedFate:OnTick()
        if ShouldWait() then return end
        --
        self.enemies = GetEnemyHeroes(self.Q.Range)
        self.target = GetTarget(GetTrueAttackRange(myHero), 0)
        self.mode = GetMode()
        --
        self:Auto()
        if myHero.isChanneling then return end
        self:KillSteal()
        --
        if not (self.mode and self.enemies) then return end
        local executeMode =
        self.mode == 1 and self:Combo() or
        self.mode == 2 and self:Harass() or
        self.mode == 6 and self:Flee()
    end
    
    function TwistedFate:OnPreMovement(args) --args.Process|args.Target
        if ShouldWait() then
            args.Process = false
            return
        end
    end
    
    function TwistedFate:OnPreAttack(args) --args.Process|args.Target
        if ShouldWait() then
            args.Process = false
            return
        end
    end
    
    function TwistedFate:OnAttack()
        if self.W:IsReady() and ManaPercent(myHero) <= Menu.W.ManaMin:Value() then
            self:PickCard("Blue")
        end
    end
    
    function TwistedFate:Auto()
        if Menu.Key.Gold:Value() or Menu.W.Auto:Value() and HasBuff(myHero, "Gate") and self:CanPick() then
            self:PickCard("Gold")
        elseif Menu.Key.Blue:Value() then
            self:PickCard("Blue")
        elseif Menu.Key.Red:Value() then
            self:PickCard("Red")
        end
        if HasBuff(myHero, "pickacard_tracker") then
            self.IsPicking = true
            local spellName = myHero:GetSpellData(_W).name
            if spellName:find(self.W.Pick) and self.W:IsReady() then
                self.W:Cast()
                self.W.Pick = "DONTPICKSHIT"
            end
        else
            self.IsPicking = false
        end
        
        if self.Q:IsReady() and Menu.Q.Auto:Value() and ManaPercent(myHero) >= Menu.Q.Mana:Value() and self.enemies then
            for i = 1, #self.enemies do
                local enemy = self.enemies[i]
                if IsImmobile(enemy) then
                    self.Q:Cast(enemy.pos)
                end
            end
        end
    end
    
    function TwistedFate:Combo()
        if Menu.Q.Combo:Value() and ManaPercent(myHero) >= Menu.Q.Mana:Value() and self.Q:IsReady() then
            qTarget = GetTarget(self.Q.Range)
            self.Q:CastToPred(qTarget, Menu.Q.Pred:Value())
        end
        if Menu.W.Combo:Value() and ManaPercent(myHero) >= Menu.W.Mana:Value() and self:CanPick() and self.target then
            self:PickCard("Gold")
        end
    end
    
    function TwistedFate:Harass()
        if Menu.Q.Harass:Value() and ManaPercent(myHero) >= Menu.Q.ManaHarass:Value() and self.Q:IsReady() then
            qTarget = GetTarget(self.Q.Range)
            self.Q:CastToPred(qTarget, Menu.Q.PredHarass:Value())
        end
        if Menu.W.Harass:Value() and ManaPercent(myHero) >= Menu.W.ManaHarass:Value() and self:CanPick() and self.target then
            self:PickCard("Gold")
        end
    end
    
    function TwistedFate:Flee()
        if not self.target then return end
        if Menu.W.Flee:Value() and self:CanPick() then
            self:PickCard("Gold")
        end
        if HasBuff(myHero, "GoldCardPreAttack") then
            Control.Attack(self.target)
        end
    end
    
    function TwistedFate:KillSteal()
        for i = 1, #self.enemies do
            local unit = self.enemies[i]
            if IsValidTarget(unit) and self.Q:IsReady() and Menu.Q.KS:Value() then
                local damage = self.Q:GetDamage(unit)
                if unit.health + unit.shieldAP < damage then
                    self.Q:CastToPred(unit, 1); return
                end
            end
        end
    end
    
    function TwistedFate:OnDraw()
        DrawSpells(self)
    end
    
    function TwistedFate:PickCard(card)
        self.W.Pick = card
        if self:CanPick() then
            self.W.LastCast = Timer()
            self.W:Cast()
        end
    end
    
    function TwistedFate:CanPick(card)
        return self.W:IsReady() and self.IsPicking == false and Timer() - self.W.LastCast >= 0.3
    end
    
    table.insert(LoadCallbacks, function()
        TwistedFate()
    end)
    
elseif myHero.charName == "Twitch" then
    
    class 'Twitch'
    
    function Twitch:__init()
        --[[Data Initialization]]
        self.poisonTable = {}
        self.Killable = {}
        self.scriptVersion = "1.0"
        self:Spells()
        self:Menu()
        --[[Default Callbacks]]
        Callback.Add("Tick", function() self:OnTick() end)
        Callback.Add("Draw", function() self:OnDraw() end)
        --[[Orb Callbacks]]
        OnPreAttack (function(...) self:OnPreAttack(...) end)
        OnPostAttack (function(...) self:OnPostAttack(...) end)
        OnPreMovement(function(...) self:OnPreMovement(...) end)
        --[[Custom Callbacks]]
        OnDash(function(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance) self:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance) end)
    end
    
    function Twitch:Spells()
        self.Q = Spell({
            Slot = 0,
            Range = 800,
            Delay = 0.85,
            Speed = huge,
            Radius = huge,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
        self.W = Spell({
            Slot = 1,
            Range = 950,
            Delay = 0.25,
            Speed = 1400,
            Radius = 100,
            Collision = false,
            From = myHero,
            Type = "AOE"
        })
        self.E = Spell({
            Slot = 2,
            Range = 1200,
            Delay = 0.25,
            Speed = huge,
            Radius = 100,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
        self.R = Spell({
            Slot = 3,
            Range = 850,
            Delay = 0.25,
            Speed = huge,
            Radius = 150,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
    end
    
    function Twitch:Menu()
        --Q--
        Menu.Q:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.Q:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.Q:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.Q:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.Q:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Misc"}})
        Menu.Q:MenuElement({id = "Turret", name = "Use on Turret", value = true})
        Menu.Q:MenuElement({id = "Flee", name = "Use on Flee", value = true})
        --W--
        Menu.W:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.W:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.W:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.W:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.W:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.W:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.W:MenuElement({name = " ", drop = {"Misc"}})
        Menu.W:MenuElement({id = "Flee", name = "Use on Flee", value = true})
        Menu.W:MenuElement({id = "Gapcloser", name = "Use on Gapcloser", value = true})
        --E--
        Menu.E:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.E:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.E:MenuElement({id = "Min", name = "Min Stacks", value = 6, min = 1, max = 30, step = 1})
        Menu.E:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.E:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.E:MenuElement({id = "Harass", name = "Use on Harass", value = false})
        Menu.E:MenuElement({id = "MinHarass", name = "Min Stacks", value = 6, min = 1, max = 30, step = 1})
        Menu.E:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.E:MenuElement({name = " ", drop = {"Misc"}})
        Menu.E:MenuElement({id = "KS", name = "Use to KS", value = true})
        Menu.E:MenuElement({id = "Dying", name = "Use If Dying", value = true})
        --R--
        Menu.R:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.R:MenuElement({id = "Count", name = "Use When X Enemies", value = 2, min = 0, max = 5, step = 1})
        Menu.R:MenuElement({id = "Duel", name = "Use on Duel", value = true})
        Menu.R:MenuElement({id = "Heroes", name = "Duel Targets", type = MENU})
        _G.SDK.ObjectManager:OnEnemyHeroLoad(function(args)
            self.poisonTable[args.networkID] = {stacks = 0, endTime = 0, dmg = 0}
            Menu.R.Heroes:MenuElement({id = args.charName, name = args.charName, value = false})
        end)
        Menu.R:MenuElement({id = "Mana", name = "Min Mana %", value = 0, min = 0, max = 100, step = 1})
        
        Menu:MenuElement({name = "[WR] "..charName.." Script", drop = {"Release_"..self.scriptVersion}})
    end
    
    function Twitch:OnTick()
        if ShouldWait() then return end
        --
        self.enemies = GetEnemyHeroes(self.E.Range)
        self.target = GetTarget(GetTrueAttackRange(myHero), 0)
        self.mode = GetMode()
        --
        if myHero.isChanneling then return end
        self:UpdatePoison()
        self:KillSteal()
        --
        if not self.mode then return end
        local executeMode =
        self.mode == 1 and self:Combo() or
        self.mode == 2 and self:Harass() or
        self.mode == 6 and self:Flee()
    end
    
    function Twitch:OnPreMovement(args) --args.Process|args.Target
        if ShouldWait() then
            args.Process = false
            return
        end
    end
    
    function Twitch:OnPreAttack(args) --args.Process|args.Target
        if ShouldWait() then
            args.Process = false
            return
        end
    end
    
    function Twitch:OnPostAttack()
        local target = GetTargetByHandle(myHero.attackData.target)
        if ShouldWait() or not IsValidTarget(target) then return end
        local tType = target.type
        --
        if self.Q:IsReady() and not self:IsInvisible() then
            local qCombo, qHarass = self.mode == 1 and Menu.Q.Combo:Value() and ManaPercent(myHero) >= Menu.Q.Mana:Value(), not qCombo and self.mode == 2 and Menu.Q.Harass:Value() and ManaPercent(myHero) >= Menu.Q.ManaHarass:Value()
            if (tType == Obj_AI_Turret and Menu.Q.Turret:Value()) or (tType == Obj_AI_Hero and (qCombo or qHarass)) then
                self.Q:Cast()
            end
        end
        if self.W:IsReady() and tType == Obj_AI_Hero and not self:IsUlting() then
            local wCombo, wHarass = self.mode == 1 and Menu.W.Combo:Value() and ManaPercent(myHero) >= Menu.W.Mana:Value(), not wCombo and self.mode == 2 and Menu.W.Harass:Value() and ManaPercent(myHero) >= Menu.W.ManaHarass:Value()
            if wCombo or wHarass then
                self.W:CastToPred(target, 2)
            end
        end
    end
    
    function Twitch:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance)
        if ShouldWait() or not (Menu.W.Gapcloser:Value() and self.W:IsReady()) then return end
        if not self:IsInvisible() and IsValidTarget(unit) and GetDistance(unitPosTo) < self.W.Range and unit.team == TEAM_ENEMY and IsFacing(unit, myHero) then --Gapcloser
            self.W:CastToPred(unit, 2)
        end
    end
    
    function Twitch:Combo()
        if self.R:IsReady() and ManaPercent(myHero) >= Menu.R.Mana:Value() and Menu.R.Count:Value() ~= 0 then
            local rTarget = GetTarget(self.R.Range)
            if (#GetEnemyHeroes(self.R.Range) >= Menu.R.Count:Value()) or (Menu.R.Duel:Value() and IsValidTarget(rTarget) and Menu.R.Heroes[rTarget.charName]:Value()) then
                self.R:Cast()
                return
            end
        end
        --
        if self.E:IsReady() and Menu.E.Combo:Value() and ManaPercent(myHero) >= Menu.E.Mana:Value() then
            local stacks = 0
            for i = 1, #self.enemies do
                stacks = stacks + self.poisonTable[self.enemies[i].networkID].stacks
            end
            if stacks >= Menu.E.Min:Value() then
                self.E:Cast()
            end
        end
        --
        if not self:IsInvisible() and not GetTarget(GetTrueAttackRange(myHero), 0) and GetTarget(self.W.Range, 0) then
            if self.Q:IsReady() and Menu.Q.Combo:Value() and ManaPercent(myHero) >= Menu.Q.Mana:Value()then
                self.Q:Cast()
            end
            if self.W:IsReady() and not self:IsUlting() and Menu.W.Combo:Value() and ManaPercent(myHero) >= Menu.W.Mana:Value() then
                self.W:CastToPred(target, 2)
            end
        end
    end
    
    function Twitch:Harass()
        if self.E:IsReady() and Menu.E.Harass:Value() and ManaPercent(myHero) >= Menu.E.ManaHarass:Value() then
            local stacks = 0
            for i = 1, #self.enemies do
                stacks = stacks + self.poisonTable[self.enemies[i].networkID].stacks
            end
            if stacks >= Menu.E.MinHarass:Value() then
                self.E:Cast()
            end
        end
        --
        if not self:IsInvisible() and not GetTarget(GetTrueAttackRange(myHero), 0) and GetTarget(self.W.Range, 0) then
            if self.Q:IsReady() and Menu.Q.Harass:Value() and ManaPercent(myHero) >= Menu.Q.ManaHarass:Value() then
                self.Q:Cast()
            end
            if self.W:IsReady() and not self:IsUlting() and Menu.W.Harass:Value() and ManaPercent(myHero) >= Menu.W.ManaHarass:Value() then
                self.W:CastToPred(target, 2)
            end
        end
    end
    
    function Twitch:Flee()
        if #GetEnemyHeroes(1000) == 0 then return end
        local wTarget = GetTarget(600, 0)
        if not self:IsInvisible() and self.W:IsReady() and Menu.W.Flee:Value() and wTarget then
            self.W:CastToPred(wTarget, 2)
        elseif self.Q:IsReady() and Menu.Q.Flee:Value() then
            self.Q:Cast()
        end
    end
    
    function Twitch:KillSteal()
        if not self.E:IsReady() then return end
        if Menu.E.Dying:Value() and HealthPercent(myHero) <= 10 then
            self.E:Cast()
        elseif Menu.E.KS:Value() then
            for k, enemy in pairs(self.Killable) do
                if IsValidTarget(enemy, self.E.Range) then
                    self.E:Cast()
                end
            end
        end
    end
    
    function Twitch:OnDraw()
        DrawSpells(self)
        --
        if Menu.Draw.ON:Value() then
            for k, enemy in pairs(self.Killable) do
                local pos = enemy.toScreen
                if pos.onScreen and IsValidTarget(enemy, self.E.Range) then
                    DrawText("Killable", 50, pos.x - enemy.boundingRadius, pos.y, DrawColor(255, 66, 244, 98))
                end
            end
        end
    end
    
    function Twitch:IsInvisible()
        return HasBuff(myHero, "TwitchHideInShadows")
    end
    
    function Twitch:IsUlting()
        return myHero.range >= 800
    end
    
    function Twitch:CalcDamage(enemy)
        local eLvl = myHero:GetSpellData(_E).level
        local stacks = self.poisonTable[enemy.networkID].stacks
        if stacks ~= 0 then
            local baseDmg, stackDmg = (10 + 10 * eLvl), (10 + 5 * eLvl + 0.35 * myHero.bonusDamage + 0.2 * myHero.ap)
            return CalcPhysicalDamage(myHero, enemy, baseDmg + stackDmg * stacks)
        end
        return 0
    end
    
    function Twitch:UpdatePoison()
        for i = 1, #self.enemies do
            local enemy = self.enemies[i]
            local ID = enemy.networkID
            --
            if not self.poisonTable[ID] then
                self.poisonTable[ID] = {stacks = 0, endTime = 0, dmg = 0}
            end
            --
            local oldStacks, oldTime = self.poisonTable[ID].stacks, self.poisonTable[ID].endTime
            --
            local buff = GetBuffByName(enemy, "TwitchDeadlyVenom")
            if buff and buff.count > 0 and Timer() < buff.expireTime then
                if buff.expireTime > oldTime and oldStacks < 6 then
                    self.poisonTable[ID].stacks = oldStacks + 1
                end
                self.poisonTable[ID].endTime = buff.expireTime
            else
                self.poisonTable[ID].stacks = 0
            end
            --
            local eDmg = self:CalcDamage(enemy)
            self.poisonTable[ID].dmg = eDmg
            if eDmg >= enemy.health + enemy.shieldAD then
                self.Killable[ID] = enemy
            else
                self.Killable[ID] = nil
            end
        end
    end
    
    table.insert(LoadCallbacks, function()
        Twitch()
    end)
    
elseif myHero.charName == "Varus" then
    
    class 'Varus'
    
    function Varus:__init()
        --[[Data Initialization]]
        self.Allies, self.Enemies = {}, {}
        self.scriptVersion = "1.0"
        self:Spells()
        self:Menu()
        --[[Default Callbacks]]
        Callback.Add("Tick", function() self:OnTick() end)
        Callback.Add("Draw", function() self:OnDraw() end)
        --[[Orb Callbacks]]
        OnPreAttack(function(...) self:OnPreAttack(...) end)
        OnPreMovement(function(...) self:OnPreMovement(...) end)
        --[[Custom Callbacks]]
        OnDash(function(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance) self:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance) end)
    end
    
    function Varus:Spells()
        self.Q = Spell({
            Slot = 0,
            Range = 975,
            Delay = 0.25,
            Speed = 1900,
            Radius = 70,
            Collision = false,
            From = myHero,
            Type = "SkillShot"
        })
        self.W = Spell({
            Slot = 1,
            Range = huge,
            From = myHero,
            Type = "Press"
        })
        self.E = Spell({
            Slot = 2,
            Range = 925,
            Delay = 0.25,
            Speed = 1500,
            Radius = 250,
            Collision = false,
            From = myHero,
            Type = "AOE"
        })
        self.R = Spell({
            Slot = 3,
            Range = 1075,
            Delay = 0.25,
            Speed = 1950,
            Radius = 120,
            Collision = false,
            From = myHero,
            Type = "SkillShot"
        })
        self.Q.MaxRange = 1550
    end
    
    function Varus:Menu()
        --Q--
        Menu.Q:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.Q:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.Q:MenuElement({id = "Stack", name = "Save To Proc 3 Stacks", value = true})
        Menu.Q:MenuElement({id = "Pred", name = "Prediction Mode", value = 2, drop = {"Faster", "More Precise"}})
        Menu.Q:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.Q:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.Q:MenuElement({id = "StackHarass", name = "Save To Proc 3 Stacks", value = false})
        Menu.Q:MenuElement({id = "PredHarass", name = "Prediction Mode", value = 1, drop = {"Faster", "More Precise"}})
        Menu.Q:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Misc"}})
        Menu.Q:MenuElement({id = "KS", name = "Use on KS", value = true})
        --W--
        Menu.W:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.W:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.W:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.W:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        --E--
        Menu.E:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.E:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.E:MenuElement({id = "Stack", name = "Save To Proc 3 Stacks", value = true})
        Menu.E:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.E:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.E:MenuElement({id = "Harass", name = "Use on Harass", value = false})
        Menu.E:MenuElement({id = "StackHarass", name = "Save To Proc 3 Stacks", value = true})
        Menu.E:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.E:MenuElement({name = " ", drop = {"Misc"}})
        Menu.E:MenuElement({id = "KS", name = "Use on KS", value = true})
        Menu.E:MenuElement({id = "Flee", name = "Use on Flee", value = true})
        --R--
        Menu.R:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.R:MenuElement({id = "Combo", name = "Use on Duel", value = true})
        Menu.R:MenuElement({id = "Min", name = "Min Target HP%", value = 15, min = 0, max = 100, step = 1})
        Menu.R:MenuElement({id = "Heroes", name = "Duel Targets", type = MENU})
        Menu.R:MenuElement({name = " ", drop = {"Misc"}})
        Menu.R:MenuElement({id = "Peel", name = "Auto Use To Peel", value = true})
        Menu.R:MenuElement({id = "PeelList", name = "Whitelist", type = MENU})
        Menu.R:MenuElement({id = "Gapcloser", name = "Auto Use On Dash", value = true})
        Menu.R:MenuElement({id = "GapList", name = "Whitelist", type = MENU})
        Menu.R:MenuElement({id = "Auto", name = "Auto Use On Immobile", value = true})
        --
        Menu:MenuElement({name = "[WR] "..charName.." Script", drop = {"Release_"..self.scriptVersion}})
        --
		_G.SDK.ObjectManager:OnEnemyHeroLoad(function(args)
			local charName = args.charName
			Menu.R.Heroes :MenuElement({id = charName, name = charName, value = false})
			Menu.R.PeelList:MenuElement({id = charName, name = charName, value = true})
			Menu.R.GapList :MenuElement({id = charName, name = charName, value = true})
		end)
    end
    
    function Varus:OnTick()
        if ShouldWait() then return end
        --
        self.enemies = GetEnemyHeroes(self.Q.MaxRange)
        self.target = GetTarget(GetTrueAttackRange(myHero), 0)
        self.mode = GetMode()
        --
        self:LogicQ()
        if myHero.isChanneling then return end
        self:Auto()
        self:KillSteal()
        --
        if not self.mode then return end
        local executeMode =
        self.mode == 1 and self:Combo() or
        self.mode == 2 and self:Harass() or
        self.mode == 6 and self:Flee()
    end
    
    function Varus:OnPreMovement(args) --args.Process|args.Target
        if ShouldWait() then
            args.Process = false
            return
        end
    end
    
    function Varus:OnPreAttack(args) --args.Process|args.Target
        if self.Charging or ShouldWait() then
            args.Process = false
            return
        end
    end
    
    function Varus:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance)
        if ShouldWait() or not (self.R:IsReady() and Menu.R.Gapcloser:Value()) then return end
        if IsValidTarget(unit) and GetDistance(unitPosTo) < 500 and unit.team == TEAM_ENEMY and Menu.R.GapList[unit.charName] and Menu.R.GapList[unit.charName]:Value() and IsFacing(unit, myHero) then --Gapcloser
            self.R:CastToPred(unit, 3)
        end
    end
    
    function Varus:Auto()
        if not self.R:IsReady() then return end
        local autoCheck, peelCheck = Menu.R.Auto:Value(), Menu.R.Peel:Value()
        if autoCheck or peelCheck then
            for i = 1, #self.enemies do
                local enemy = self.enemies[i]
                if autoCheck and GetDistance(enemy) <= self.R.Range and IsImmobile(enemy, 0.5) then
                    self.R:Cast(enemy)
                end
                if peelCheck and GetDistance(enemy) <= 400 and Menu.R.PeelList[enemy.charName] and Menu.R.PeelList[enemy.charName]:Value() then
                    self.R:CastToPred(enemy, 2)
                end
            end
        end
    end
    
    function Varus:Combo()
        local target = GetTarget(self.R.Range, 0)
        if not IsValidTarget(target) then return end
        --
        local validTarg = Menu.R.Heroes[target.charName] and Menu.R.Heroes[target.charName]:Value() and HealthPercent(target) >= Menu.R.Min:Value()
        if Menu.R.Combo:Value() and validTarg and HealthPercent(myHero) <= 60 then
            self.R:CastToPred(target, 2)
        end
        if Menu.E.Combo:Value() and ManaPercent(myHero) >= Menu.E.Mana:Value() then
            local waitForStacks = self.mode == 1 and Menu.E.Stack:Value()
            local target = self:GetBestTarget(waitForStacks, self.E.Range)
            if target then
                self.E:CastToPred(target, 2)
            end
        end
    end
    
    function Varus:Harass()
        local waitForStacks = self.mode == 2 and Menu.E.StackHarass:Value()
        local target = self:GetBestTarget(waitForStacks, self.E.Range)
        if not IsValidTarget(target) then return end
        --
        if Menu.E.Harass:Value() and ManaPercent(myHero) >= Menu.E.ManaHarass:Value() then
            self.E:CastToPred(target, 2)
        end
    end
    
    function Varus:Flee()
        if not self.E:IsReady() then return end
        for i = 1, #self.enemies do
            local enemy = self.enemies[i]
            if Menu.E.Flee:Value() then
                self.E:CastToPred(enemy, 2)
            end
        end
    end
    
    function Varus:KillSteal()
    end
    
    function Varus:OnDraw()
        DrawSpells(self)
    end
    
    function Varus:LogicQ()
        self.Charging = self:IsCharging()
        self:UpdateCharge()
        
        if not (self.Q:IsReady() and #self.enemies >= 1 and self.mode and self.mode <= 2) then return end
        --
        local isCombo, isHarass = self.mode == 1, self.mode == 2
        local waitForStacks = ((isCombo and Menu.Q.Stack:Value()) or (isHarass and Menu.Q.StackHarass:Value()))
        local target = self:GetBestTarget(waitForStacks, self.Q.Range)
        --
        if not self:IsCastE(target) then return end
        if target or not waitForStacks then
            if not self.Charging then
                if isCombo and ManaPercent(myHero) >= Menu.Q.Mana:Value() or isHarass and ManaPercent(myHero) >= Menu.Q.ManaHarass:Value() then
                    self.W:Cast()
                    KeyDown(HK_Q)
                end
            elseif target then
                local minHitChance = isCombo and Menu.Q.Pred:Value() or isHarass and Menu.Q.PredHarass:Value()
                local bestPos, castPos, hC = self.Q:GetPrediction(target)
                if bestPos and hC >= minHitChance then
                    print("release")
                    self:ReleaseSpell(bestPos)
                end
            end
        end
    end
    
    function Varus:UpdateCharge()
        if self.Charging then
            self.Q.Range = min(975 + 425 * (Timer() - myHero.activeSpell.startTime), 1550)
        else
            self.Q.Range = 975
            if IsKeyDown(HK_Q) then
                DelayAction(function()
                    if IsKeyDown(HK_Q) and not self.Charging then
                        KeyUp(HK_Q)
                    end
                end, Latency() * 2 / 1000)
            end
        end
    end
    
    function Varus:GetBestTarget(waitStacks, range)
        local lowestHealth, bestTarget = 10000, nil
        for i = 1, #self.enemies do
            local enemy = self.enemies[i]
            local health = enemy.health
            if health <= lowestHealth and IsValidTarget(enemy, range) and (not waitStacks or self:GetStacks(enemy) == 3) then
                bestTarget = enemy
                lowestHealth = health
            end
        end
        return bestTarget
    end
    
    local spellData = {state = 0, tick = GetTickCount(), casting = GetTickCount() - 1000, mouse = mousePos}
    function Varus:ReleaseSpell(pos) --Noddy's Cast Method adapted to my needs
        if ShouldWait() then return end
        local ticker, latency = GetTickCount(), Latency()
        if spellData.state == 0 and GetDistance(myHero.pos, pos) < self.Q.Range and ticker - spellData.casting > self.Q.Delay + latency then
            spellData.state = 1
            spellData.mouse = mousePos
            spellData.tick = ticker
        end
        if spellData.state == 1 then
            if ticker - spellData.tick < latency then
                if not pos:ToScreen().onScreen then
                    local dist = GetDistance(pos)
                    repeat
                        dist = dist - 100
                        pos = myHero.pos:Extended(pos, dist)
                    until (pos:ToScreen().onScreen)
                end
                local pos2 = pos:To2D()
                Control.LeftClick(pos2.x, pos2.y)
                spellData.casting = ticker
                DelayAction(function()
                    if spellData.state == 1 then
                        SetCursorPos(spellData.mouse)
                        spellData.state = 0
                    end
                end, latency / 1000)
            end
            if ticker - spellData.casting > latency then
                SetCursorPos(spellData.mouse)
                spellData.state = 0
            end
        end
    end
    
    function Varus:IsCharging()
        local spell = myHero.activeSpell
        return spell and spell.valid and spell.name == "VarusQ"
    end
    
    function Varus:GetStacks(target)
        local buff = GetBuffByName(target, "VarusWDebuff")
        return buff and buff.expireTime >= Timer() and buff.count
    end
    
    function Varus:IsCastE(target)
        local spell = myHero:GetSpellData(_E)
        local checkMode = (self.mode == 1 and Menu.E.Combo:Value() and ManaPercent(myHero) >= Menu.E.Mana:Value()) or (self.mode == 3 and Menu.E.Harass:Value() and ManaPercent(myHero) >= Menu.E.ManaHarass:Value())
        return (not target or GetDistance(target) > self.E.Range) or (checkMode and spell.currentCd ~= 0 and spell.cd - spell.currentCd >= 1)
    end
    
    table.insert(LoadCallbacks, function()
        Varus()
    end)
    
elseif myHero.charName == "Vayne" then
    
    local mapPos = MapPosition
    local intersectsWall = MapPosition.intersectsWall
    class 'Vayne'
    
    function Vayne:__init()
        --[[Data Initialization]]
        self.scriptVersion = "1.1"
        self:Spells()
        self:Menu()
        --[[Default Callbacks]]
        Callback.Add("Tick", function() self:OnTick() end)
        Callback.Add("Draw", function() self:OnDraw() end)
        --[[Orb Callbacks]]
        OnPreAttack(function(...) self:OnPreAttack(...) end)
        OnPostAttackTick(function(...) self:OnPostAttack(...) end)
        OnPreMovement(function(...) self:OnPreMovement(...) end)
        --[[Custom Callbacks]]
        OnInterruptable(function(unit, spell) self:OnInterruptable(unit, spell) end)
        OnDash(function(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance) self:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance) end)
    end
    
    function Vayne:Spells()
        self.Q = Spell({
            Slot = 0,
            Range = 300,
            Delay = 0.25,
            Speed = 200,
            Radius = 200,
            Collision = false,
            From = myHero,
            Type = "SkillShot"
        })
        self.W = Spell({
            Slot = 1,
            Range = huge,
            Delay = 0,
            Speed = huge,
            Radius = 0,
            Collision = false,
            From = myHero,
            Type = ""
        })
        self.E = Spell({
            Slot = 2,
            Range = 650,
            Delay = 0.5,
            Speed = 2000,
            Radius = 100,
            Collision = false,
            From = myHero,
            Type = "Targetted"
        })
        self.R = Spell({
            Slot = 3,
            Range = 1000,
            Delay = 0.5,
            From = myHero,
            Type = "Press"
        })
        self.Q.LastReset = Timer()
    end
    
    function Vayne:Menu()
        Menu.Q:MenuElement({name = " ", drop = {"Combo Settings"}}) --
        Menu.Q:MenuElement({id = "Combo", name = "Use on Combo", value = true}) --
        Menu.Q:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1}) --
        Menu.Q:MenuElement({name = " ", drop = {"Harass Settings"}}) --
        Menu.Q:MenuElement({id = "Harass", name = "Use on Harass", value = true}) --
        Menu.Q:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1}) --
        Menu.Q:MenuElement({name = " ", drop = {"Farm Settings"}}) --
        Menu.Q:MenuElement({id = "Jungle", name = "Use on JungleClear", value = false}) --
        Menu.Q:MenuElement({id = "ManaClear", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1}) --
        Menu.Q:MenuElement({name = " ", drop = {"Misc"}}) --
        Menu.Q:MenuElement({id = "Logic", name = "Tumble Logic", value = 1, drop = {"Prestigious Smart", "Agressive", "Kite[To Mouse]"}}) --
        Menu.Q:MenuElement({id = "Flee", name = "Use on Flee", value = true}) --
        --W--
        Menu.W:MenuElement({id = "Heroes", name = "Force Marked Heroes", value = true}) --
        Menu.W:MenuElement({id = "Minions", name = "Force Marked Minions", value = false}) --
        --E--
        Menu.E:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.E:MenuElement({id = "Combo", name = "Use on Combo", value = true}) --
        Menu.E:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1}) --
        Menu.E:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.E:MenuElement({id = "Third", name = "Use To Proc 3rd Mark", value = false})
        Menu.E:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        --
        Menu.E:MenuElement({name = " ", drop = {"Peel Settings"}})
        Menu.E:MenuElement({id = "Gapcloser", name = "Use as Anti Gapcloser", value = true}) --
        Menu.E:MenuElement({id = "Flee", name = "Use on Flee", value = true}) --
        Menu.E:MenuElement({id = "AutoPeel", name = "Auto Peel", value = true}) --
        Menu.E:MenuElement({id = "Peel", name = "Whitelist", type = MENU}) --
        --
        Menu.E:MenuElement({name = " ", drop = {"Interrupter Settings"}}) --
        Menu.E:MenuElement({id = "Interrupter", name = "Use as Interrupter", value = true}) --
        Menu.E:MenuElement({id = "Interrupt", name = "Whitelist", type = MENU}) --
        --
        Menu.E:MenuElement({name = " ", drop = {"Misc"}}) --
        Menu.E:MenuElement({id = "Auto", name = "Auto Stun", value = true}) --
        Menu.E:MenuElement({id = "Push", name = "Distance", value = 450, min = 400, max = 475, step = 25}) --
        --R--
        Menu.R:MenuElement({id = "Count", name = "Use When X Enemies", value = 2, min = 0, max = 5, step = 1}) --
        Menu.R:MenuElement({id = "Combo", name = "Use on Duel", value = true}) --
        Menu.R:MenuElement({id = "Duel", name = "Duel Targets", type = MENU}) --
        Menu:MenuElement({name = "[WR] "..charName.." Script", drop = {"Release_"..self.scriptVersion}}) --
        --
		_G.SDK.ObjectManager:OnEnemyHeroLoad(function(args)
			local hero = args.unit
			local charName = args.charName
			Interrupter:AddToMenu(hero, Menu.E.Interrupt)
			if GetTrueAttackRange(hero) <= 500 then
				Menu.E.Peel:MenuElement({id = charName, name = charName, value = false})
			end
			Menu.R.Duel:MenuElement({id = charName, name = charName, value = false})
		end)
    end

    function Vayne:OnTick()
        if ShouldWait() then return end
        --
        self.enemies = GetEnemyHeroes(self.E.Range + self.Q.Range)
        self.target = GetTarget(GetTrueAttackRange(myHero), 0)
        self.mode = GetMode()
        --
        self:ResetAA()
        if myHero.isChanneling or not self.enemies then return end
        self:Auto()
        --
        if not self.mode then return end
        local executeMode =
        self.mode == 6 and self:Flee()
    end
    
    function Vayne:ResetAA()
        if Timer() > self.Q.LastReset + 1 and HasBuff(myHero, "vaynetumblebonus") then
            ResetAutoAttack()
            self.Q.LastReset = Timer()
        end
    end
    
    function Vayne:OnPreMovement(args) --args.Process|args.Target
        if ShouldWait() then
            args.Process = false
            return
        end
    end
    
    function Vayne:OnPreAttack(args) --args.Process|args.Target
        if ShouldWait() then
            args.Process = false
            return
        end
        --
        local range = GetTrueAttackRange(myHero)
        if HasBuff(myHero, "VayneTumbleFade") then
            for i = 1, #self.enemies do
                if GetDistance(self.enemies[i]) <= 300 then
                    args.Process = false
                    return
                end
            end
        end
        if Menu.W.Heroes:Value() then
            local nearby = GetEnemyHeroes(range)
            for i = 1, #nearby do
                local hero = nearby[i]
                if self:GetStacks(hero) >= 2 then
                    args.Target = hero
                    return
                end
            end
        end
        if args.Target.type == myHero.type then return end
        if Menu.W.Minions:Value() then
            local nearby = GetEnemyMinions(range)
            for i = 1, #nearby do
                local minion = nearby[i]
                if self:GetStacks(minion) >= 2 then
                    args.Target = minion
                    return
                end
            end
        end
    end
    
    function Vayne:OnPostAttack()
        local target = GetTargetByHandle(myHero.attackData.target)
        if ShouldWait() or not IsValidTarget(target) then return end
        --
        local tType, tTeam = target.type, target.team
        
        if tType == Obj_AI_Hero then
            if self.R:IsReady() and Menu.R.Combo:Value() and Menu.R.Duel[target.charName] and Menu.R.Duel[target.charName]:Value() then
                self.R:Cast()
            elseif self.mode == 2 and self.E:IsReady() and Menu.E.Third:Value() and ManaPercent(myHero) >= Menu.E.ManaHarass:Value() and self:GetStacks(target) == 1 then
                self.E:Cast(target)
            elseif self.Q:IsReady() then
                local modeCheck = (self.mode == 1 and Menu.Q.Combo:Value() and ManaPercent(myHero) >= Menu.Q.Mana:Value()) or (self.mode == 2 and Menu.Q.Harass:Value() and ManaPercent(myHero) >= Menu.Q.ManaHarass:Value())
                local tPos = self:GetBestTumblePos()
                if modeCheck and tPos then
                    self.Q:Cast(tPos)
                end
            end
        elseif self.Q:IsReady() and self.mode and self.mode >= 3 and Menu.Q.Jungle:Value() and ManaPercent(myHero) >= Menu.Q.ManaClear:Value() and tTeam == 300 then
            local tPos = self:GetKitingTumblePos(target)
            if tPos then
                self.Q:Cast(tPos)
            end
            --elseif self.Q:IsReady() and tType == Obj_AI_Turret then
            --tumble to closest wall
        end
    end
    
    function Vayne:OnInterruptable(unit, spell)
        if ShouldWait() or not Menu.E.Interrupter:Value() or not self.E:IsReady() then return end
        if IsValidTarget(unit, self.E.Range) and unit.team == TEAM_ENEMY and Menu.E.Interrupt[spell.name]:Value() then
            self.E:Cast(unit)
        end
    end
    
    function Vayne:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance)
        if ShouldWait() or not Menu.E.Gapcloser:Value() or not self.E:IsReady() then return end
        if IsValidTarget(unit) and GetDistance(unitPosTo) < 500 and unit.team == TEAM_ENEMY and IsFacing(unit, myHero) then
            self.E:Cast(unit)
        end
    end
    
    function Vayne:Auto()
        local rCount = Menu.R.Count:Value()
        if self.R:IsReady() and rCount ~= 0 and #self.enemies >= rCount and self.mode == 1 then
            self.R:Cast()
        end
        local autoE, peelE, comboE = Menu.E.Auto:Value(), Menu.E.AutoPeel:Value(), (Menu.E.Combo:Value() and self.mode == 1 and ManaPercent(myHero) >= Menu.E.Mana:Value())
        if self.E:IsReady() and (autoE or peelE or comboE) then
            for i = 1, #self.enemies do
                local enemy = self.enemies[i]
                local enemyRange = GetTrueAttackRange(enemy)
                local autoPeel = GetDistance(enemy) <= enemyRange + 50 and Menu.E.Peel[enemy.charName] and Menu.E.Peel[enemy.charName]:Value()
                if IsValidTarget(enemy, self.E.Range) and (((autoE or comboE) and self:CheckCondemn(enemy)) or (peelE and autoPeel)) then
                    self.E:Cast(enemy)
                    break
                end
            end
        end
    end
    
    function Vayne:Flee()
        local closest = GetClosestEnemy()
        local dist = GetDistance(closest)
        local castCheck = dist <= GetTrueAttackRange(closest) or HealthPercent(myHero) <= 30
        --
        if IsValidTarget(closest) then
            if Menu.E.Flee:Value() and self.E:IsReady() and dist <= 400 and castCheck then
                self.E:Cast(closest)
            elseif Menu.Q.Flee:Value() and self.Q:IsReady() and dist <= 600 then
                local bestPos = self:GetBestTumblePos()
                if bestPos then self.Q:Cast(bestPos) end
            end
        end
    end
    
    function Vayne:OnDraw()
        DrawSpells(self)
    end
    
    function Vayne:CheckCondemn(enemy, pos)
        local eP, pP, pD = enemy.pos, pos or myHero.pos, Menu.E.Push:Value()
        local segment = LineSegment(eP, eP:Extended(pP, -pD))
        return intersectsWall(mapPos, segment)
    end
    
    function Vayne:GetStacks(target)
        if not target then error("", 2) end
        local buff = GetBuffByName(target, "VayneSilveredDebuff")
        return buff and buff.count or 0
    end
    
    function Vayne:GetBestTumblePos()
        local logic = Menu.Q.Logic:Value()
        local target = GetClosestEnemy()
        if not target then return end
        --
        if logic == 1 then
            return self:GetSmartTumblePos(target)
        elseif logic == 2 then
            return self:GetAggressiveTumblePos(target)
        elseif logic == 3 then
            return self:GetKitingTumblePos(target)
        end
    end
    
    function Vayne:GetAggressiveTumblePos(target)
        local root1, root2 = CircleCircleIntersection(myHero.pos, target.pos, GetTrueAttackRange(myHero), 500)
        if root1 and root2 then
            local closest = GetDistance(root1, mousePos) < GetDistance(root2, mousePos) and root1 or root2
            return myHero.pos:Extended(closest, 300)
        end
    end
    
    function Vayne:GetKitingTumblePos(target)
        local hP, tP = myHero.pos, target.pos
        local posToKite = hP:Extended(tP, -300)
        local posToMouse = hP:Extended(mousePos, 300)
        local range = GetTrueAttackRange(myHero)
        --
        if not self:IsDangerousPosition(posToKite) and GetDistance(tP, posToKite) <= range then
            return posToKite
        elseif not self:IsDangerousPosition(posToMouse) and GetDistance(tP, posToMouse) <= range then
            return posToMouse
        end
    end
    
    function Vayne:GetSmartTumblePos(target)
        if not self.enemies or not self.Q:IsReady() then return end
        local pP, range = myHero.pos, self.E.Range ^ 2
        local offset, rAngle = pP + Vector(0, 0, 300), 360 / 16 * pi / 180
        --
        local result = {}
        for i = 1, 17 do
            local pos = RotateAroundPoint(offset, pP, rAngle * (i - 1))
            for j = 1, #self.enemies do --Max 5
                local enemy = self.enemies[j]
                if GetDistanceSqr(pos, enemy) <= range and self:CheckCondemn(enemy, pos) then
                    result[i] = pos
                    break
                else
                    result[i] = 1
                end
            end
        end
        return self:GetBestPoint(result) or self:GetKitingTumblePos(target)
    end
    
    function Vayne:IsDangerousPosition(pos, turretList, heroList)
        local turretList = turretList or GetEnemyTurrets(1200)
        for i = 1, #turretList do --Max 2 (on nexus)
            local turret = turretList[i]
            if GetDistance(turret, pos) < 900 then return true end
        end
        --
        local heroList = heroList or GetEnemyHeroes(1200)
        for i = 1, #heroList do --Max 5
            local enemy = heroList[i]
            local range = GetTrueAttackRange(enemy)
            if range < 500 and GetDistance(enemy, pos) < range then return true end
        end
    end
    
    function Vayne:GetBestPoint(t)
        local dist, best = 10000, nil
        local heroList, turretList = GetEnemyHeroes(1200), GetEnemyTurrets(1200)
        for i = 1, #t do
            local point = t[i]
            if point and point ~= 1 then
                local dist2 = GetDistance(point, mousePos)
                if dist2 <= dist and not self:IsDangerousPosition(point, turretList, heroList) then
                    best = point
                    dist = dist2
                end
            end
        end
        return best
    end
    
    table.insert(LoadCallbacks, function()
        Vayne()
    end)
    
elseif myHero.charName == "Vladimir" then
    
    class 'Vladimir'
    
    function Vladimir:__init()
        --[[Data Initialization]]
        self.Allies, self.Enemies = {}, {}
        self.scriptVersion = "1.01"
        self:Spells()
        self:Menu()
        --[[Default Callbacks]]
        Callback.Add("Tick", function() self:OnTick() end)
        Callback.Add("Draw", function() self:OnDraw() end)
        --[[Orb Callbacks]]
        OnPreAttack(function(...) self:OnPreAttack(...) end)
        OnPreMovement(function(...) self:OnPreMovement(...) end)
        OnDash(function(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance) self:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance) end)
    end
    
    function Vladimir:Spells()
        local flashData = myHero:GetSpellData(SUMMONER_1).name:find("Flash") and SUMMONER_1 or myHero:GetSpellData(SUMMONER_2).name:find("Flash") and SUMMONER_2 or nil
        self.Q = Spell({
            Slot = 0,
            Range = 600,
            Delay = 0.25,
            Speed = huge,
            Radius = huge,
            Collision = false,
            From = myHero,
            Type = "Targetted"
        })
        self.W = Spell({
            Slot = 1,
            Range = huge,
            Delay = 0.25,
            Speed = huge,
            Radius = 150,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
        self.E = Spell({
            Slot = 2,
            Range = 600,
            Delay = 0.25,
            Speed = 2500,
            Radius = 100,
            Collision = true,
            From = myHero,
            Type = "Press"
        })
        self.R = Spell({
            Slot = 3,
            Range = 750,
            Delay = 0.25,
            Speed = huge,
            Radius = 200,
            Collision = false,
            From = myHero,
            Type = "AOE"
        })
        self.Flash = flashData and Spell({
            Slot = flashData,
            Range = 400,
            Delay = 0.25,
            Speed = huge,
            Radius = 200,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
    end
    
    function Vladimir:Menu()
		_G.SDK.ObjectManager:OnAllyHeroLoad(function(args)
			insert(self.Allies, args.unit)
		end)
		_G.SDK.ObjectManager:OnEnemyHeroLoad(function(args)
			insert(self.Enemies, args.unit)
		end)
        --Q--
        Menu.Q:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.Q:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.Q:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.Q:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.Q:MenuElement({name = " ", drop = {"Farm Settings"}})
        Menu.Q:MenuElement({id = "LastHit", name = "Use to LastHit", value = false}) --add
        Menu.Q:MenuElement({id = "Unkillable", name = "    Only when Unkillable", value = false}) -- add
        Menu.Q:MenuElement({id = "Jungle", name = "Use on JungleClear", value = false})
        Menu.Q:MenuElement({id = "Clear", name = "Use on LaneClear", value = false})
        Menu.Q:MenuElement({name = " ", drop = {"Misc"}})
        Menu.Q:MenuElement({id = "Auto", name = "Auto Use to Harass", value = true})
        Menu.Q:MenuElement({id = "MinHealth", name = "    When Health Below %", value = 100, min = 10, max = 100, step = 1})
        Menu.Q:MenuElement({id = "KS", name = "Use on KS", value = true})
        Menu.Q:MenuElement({id = "Flee", name = "Use on Flee", value = true})
        --W--
        Menu.W:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.W:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.W:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.W:MenuElement({id = "Harass", name = "Use on Harass", value = false})
        Menu.W:MenuElement({name = " ", drop = {"Misc"}})
        Menu.W:MenuElement({id = "Gapcloser", name = "Use on GapCloser", value = false})
        Menu.W:MenuElement({id = "Count", name = "Auto Use When X Enemies Around", value = 2, min = 0, max = 5, step = 1})
        Menu.W:MenuElement({id = "Flee", name = "Use on Flee", value = true})
        --E--
        Menu.E:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.E:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.E:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.E:MenuElement({id = "Harass", name = "Use on Harass", value = false})
        Menu.E:MenuElement({name = " ", drop = {"Farm Settings"}})
        Menu.E:MenuElement({id = "Jungle", name = "Use on JungleClear", value = false})
        Menu.E:MenuElement({id = "Clear", name = "Use on LaneClear", value = false})
        Menu.E:MenuElement({id = "Min", name = "Minions To Cast", value = 3, min = 0, max = 6, step = 1})
        --R--
        Menu.R:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.R:MenuElement({id = "Duel", name = "Use To Duel", value = true})
        Menu.R:MenuElement({id = "Heroes", name = "Duel Targets", type = MENU})
        Menu.R:MenuElement({name = " ", drop = {"Misc"}})
        Menu.R:MenuElement({id = "Count", name = "Auto Use When X Enemies", value = 2, min = 0, max = 5, step = 1})
        --Burst
        Menu:MenuElement({id = "Burst", name = "Burst Settings", type = MENU})
        Menu.Burst:MenuElement({id = "Flash", name = "Allow Flash On Burst", value = true})
        Menu.Burst:MenuElement({id = "Key", name = "Burst Key", key = string.byte("T")})
        --
        Menu:MenuElement({name = "[WR] "..charName.." Script", drop = {"Release_"..self.scriptVersion}})
        --
		_G.SDK.ObjectManager:OnEnemyHeroLoad(function(args)
			Menu.R.Heroes:MenuElement({id = args.charName, name = args.charName, value = false})
		end)
    end
    
    function Vladimir:OnTick()
        if ShouldWait() then return end
        --
        self.enemies = GetEnemyHeroes(1500)
        self.target = GetTarget(self.Q.Range, 1)
        self.mode = GetMode()
        --
        if Menu.Burst.Key:Value() then
            self:Burst()
            return
        end
        self:LogicE()
        self:LogicW()
        if myHero.isChanneling then return end
        self:Auto()
        self:KillSteal()
        --
        if not self.mode then return end
        local executeMode =
        self.mode == 1 and self:Combo() or
        self.mode == 2 and self:Harass() or
        self.mode == 3 and self:Clear() or
        self.mode == 4 and self:Clear() or
        self.mode == 5 and self:LastHit() or
        self.mode == 6 and self:Flee()
    end
    
    function Vladimir:OnPreMovement(args) --args.Process|args.Target
        if ShouldWait() then
            args.Process = false
            return
        end
    end
    
    function Vladimir:OnPreAttack(args) --args.Process|args.Target
        if ShouldWait() or not myHero.valid then
            args.Process = false
            return
        end
    end
    
    function Vladimir:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance)
        if ShouldWait() or not self.W:IsReady() or not Menu.W.Gapcloser:Value() then return end
        if IsValidTarget(unit) and GetDistance(unitPosTo) < 500 and unit.team == TEAM_ENEMY and IsFacing(unit, myHero) then --Gapcloser
            self.W:Cast()
        end
    end
    
    function Vladimir:Auto()
        local rMinHit, wMinHit = Menu.R.Count:Value(), Menu.W.Count:Value()
        --
        if self.Q:IsReady() and (Menu.Q.Auto:Value() and HealthPercent(myHero) <= Menu.Q.MinHealth:Value()) then
            if self.target then
                self.Q:Cast(self.target); return
            end
        end
        if rMinHit ~= 0 and self.R:IsReady() then
            local bestPos, hit = self.R:GetBestCircularCastPos(nil, GetEnemyHeroes(1000))
            if bestPos and hit >= rMinHit then
                self.R:Cast(bestPos); return
            end
        end
        if wMinHit ~= 0 and self.W:IsReady() then
            local nearby = GetEnemyHeroes(600)
            if #nearby >= wMinHit then
                self.W:Cast(); return
            end
        end
    end
    
    function Vladimir:Combo()
        if not self.target then return end
        --
        if self.R:IsReady() and Menu.R.Duel:Value() and Menu.R.Heroes[self.target.charName] and Menu.R.Heroes[self.target.charName]:Value() then
            self.R:CastToPred(self.target, 2)
        elseif self.Q:IsReady() and Menu.Q.Combo:Value() then
            self.Q:Cast(self.target)
        elseif self.E:IsReady() and not IsKeyDown(HK_E) and Menu.E.Combo:Value() then
            KeyDown(HK_E)
        end
    end
    
    function Vladimir:Harass()
        if not self.target then return end
        --
        if self.Q:IsReady() and Menu.Q.Harass:Value() then
            self.Q:Cast(self.target)
        elseif self.E:IsReady() and not IsKeyDown(HK_E) and Menu.E.Harass:Value() then
            KeyDown(HK_E)
        end
    end
    
    function Vladimir:Clear()
        local qRange, jCheckQ, lCheckQ = self.Q.Range, Menu.Q.Jungle:Value(), Menu.Q.Clear:Value()
        local eRange, jCheckE, lCheckE = self.E.Range, Menu.E.Jungle:Value(), Menu.E.Clear:Value()
        --
        if self.Q:IsReady() and (jCheckQ or lCheckQ) then
            local minions = (jCheckQ and GetMonsters(qRange)) or {}
            minions = (#minions == 0 and lCheckQ and GetEnemyMinions(qRange)) or minions
            for i = 1, #minions do
                local minion = minions[i]
                if minion.health <= self.Q:GetDamage(minion) or minion.team == TEAM_JUNGLE then
                    self.Q:Cast(minion)
                    return
                end
            end
        end
        if self.E:IsReady() and (jCheckE or lCheckE) then
            local minions = (jCheckE and GetMonsters(eRange)) or {}
            minions = (#minions == 0 and lCheckE and GetEnemyMinions(eRange)) or minions
            if #minions >= Menu.E.Min:Value() or (minions[1] and minions[1].team == TEAM_JUNGLE) then
                KeyDown(HK_E)
            end
        end
    end
    
    function Vladimir:LastHit()
        if self.Q:IsReady() and Menu.Q.LastHit:Value() then
            local minions = GetEnemyMinions(self.Q.Range)
            for i = 1, #minions do
                local minion = minions[i]
                if minion.health <= self.Q:GetDamage(minion) then --check if Q dmg is right
                    self.Q:Cast(minion)
                    return
                end
            end
        end
    end
    
    function Vladimir:Flee()
        if Menu.Q.Flee:Value() and self.Q:IsReady() then
            if self.target then
                self.Q:Cast(self.target)
            end
        elseif Menu.W.Flee:Value() and self.W:IsReady() then
            if #GetEnemyHeroes(400) >= 1 then
                self.W:Cast()
            end
        end
    end
    
    function Vladimir:KillSteal()
        if (Menu.Q.KS:Value() and self.Q:IsReady()) then
            for i = 1, #self.enemies do
                local enemy = self.enemies[i]
                if enemy and self.Q:GetDamage(enemy) >= enemy.health then
                    self.Q:Cast(self.target); return
                end
            end
        end
    end
    
    function Vladimir:OnDraw()
        DrawSpells(self)
    end
    
    function Vladimir:LogicE()
        if not HasBuff(myHero, "VladimirE") then
            local eSpell = myHero:GetSpellData(self.E.Slot)
            if eSpell.currentCd ~= 0 and eSpell.cd - eSpell.currentCd > 0.5 and IsKeyDown(HK_E) then
                KeyUp(HK_E) --release stuck key
            end
            return
        end
        --
        local eRange = self.E.Range
        local enemies, minions = GetEnemyHeroes(eRange + 300), GetEnemyMinions(eRange + 300)
        local willHit, entering, leaving = 0, 0, 0
        for i = 1, #enemies do
            local target = enemies[i]
            local tP, tP2, pP2 = target.pos, target:GetPrediction(huge, 0.2), myHero:GetPrediction(huge, 0.2)
            --
            if GetDistance(tP) <= eRange then --if inside(might go out)
                if #mCollision(myHero.pos, tP, self.E, minions) == 0 then
                    willHit = willHit + 1
                end
                if GetDistance(tP2, pP2) > eRange then
                    leaving = leaving + 1
                end
            elseif GetDistance(tP2, pP2) < eRange then --if outside(might come in)
                entering = entering + 1
            end
        end
        if entering <= leaving and (willHit > 0 or entering == 0) then
            if leaving > 0 and IsKeyDown(HK_E) then
                KeyUp(HK_E) --release skill
            end
        end
    end
    
    function Vladimir:LogicW()
        if self.W:IsReady() and not self.Q:IsReady() and not self.E:IsReady() and ((self.mode == 1 and Menu.W.Combo:Value()) or (self.mode == 2 and Menu.W.Harass:Value())) then
            local nearby = GetEnemyHeroes(600)
            --
            for i = 1, #nearby do
                local enemy = nearby[i]
                if GetDistance(enemy) <= 300 then
                    self.W:Cast()
                end
            end
        end
    end
    
    local bursting, startEarly = false, false
    function Vladimir:Burst()
        Orbwalk()
        if not HasBuff(myHero, "vladimirqfrenzy") then
            return self.Q:IsReady() and self:LoadQ()
        end
        if not bursting and self.Q:IsReady() and (self.E:IsReady() or startEarly) and self.R:IsReady() then
            local canFlash = self.Flash and self.Flash:IsReady() and Menu.Burst.Flash:Value()
            local range = self.E.Range + (canFlash and self.Flash.Range or 0)
            local bTarget, eTarget = GetTarget(range + 300, 1), GetTarget(self.E.Range, 1)
            local shouldFlash = canFlash and bTarget ~= eTarget
            --
            if bTarget then
                startEarly = GetDistance(bTarget) > 600 and KeyDown(HK_E)
                if GetDistance(bTarget) < range then
                    self:BurstCombo(bTarget, shouldFlash, 1)
                end
            end
        end
    end
    
    function Vladimir:BurstCombo(target, shouldFlash, step)
        if step == 1 then
            bursting = true
            local chargeE = not IsKeyDown(HK_E) and KeyDown(HK_E)
            if shouldFlash then
                local pos, hK = mousePos, self.Flash:SlotToHK()
                SetCursorPos(target.pos)
                KeyDown(hK)
                KeyUp(hK)
                DelayAction(function() SetCursorPos(pos) end, 0.05)
            end
            DelayAction(function() self:BurstCombo(target, shouldFlash, 2) end, 0.3)
        elseif step == 2 then
            Control.CastSpell(HK_R, target, pos)
            local releaseE = IsKeyDown(HK_E) and KeyUp(HK_E)
            DelayAction(function() self:BurstCombo(target, shouldFlash, 3) end, 0.3)
        elseif step == 3 then
            self.Q:Cast(target)
            DelayAction(function() self.W:Cast() end, 0.05)
            bursting = false
            DelayAction(function() self:Protobelt(target) end, 0.3)
        end
    end
    
    function Vladimir:LoadQ()
        local qRange = self.Q.Range
        local qTarget = GetTarget(qRange, 1)
        if qTarget then return self.Q:Cast(qTarget) end
        --
        local minions = GetEnemyMinions(qRange)
        if #minions < 1 then minions = GetMonsters(qRange) end
        if minions[1] then return self.Q:Cast(minions[1]) end
    end
    
    function Vladimir:Protobelt(target)
        local slot, key = GetItemSlot(3152)
        if key and slot ~= 0 then
            Control.CastSpell(key, target)
        end
    end
    
    table.insert(LoadCallbacks, function()
        Vladimir()
    end)

elseif myHero.charName == "Xayah" then
    
    class 'Xayah'
    
    function Xayah:__init()
        --[[Data Initialization]]
        self.Allies, self.Enemies = {}, {}
        self.scriptVersion = "1.0"
        self:Spells()
        self:Menu()
        --[[Default Callbacks]]
        Callback.Add("Tick", function() self:OnTick() end)
        Callback.Add("Draw", function() self:OnDraw() end)
        Callback.Add("WndMsg", function(msg, param) self:OnWndMsg(msg, param) end)
        --Callback.Add("ProcessRecall", function(unit, proc) self:OnRecall(unit, proc) end)
        --[[Orb Callbacks]]
        OnPreAttack(function(...) self:OnPreAttack(...) end)
        OnPostAttack(function(...) self:OnPostAttack(...) end)
        OnPreMovement(function(...) self:OnPreMovement(...) end)
        --[[Custom Callbacks]]
        OnDash(function(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance) self:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance) end)
    end
    
    function Xayah:Spells()
        self.PassiveTable = {}
        self.Q = Spell({
            Slot = 0,
            Range = 1100,
            Delay = 0.5,
            Speed = 1200,
            Width = 70,
            Collision = false,
            From = myHero,
            Type = "SkillShot"
        })
        self.W = Spell({
            Slot = 1,
            Range = 925,
            Delay = 0.25,
            Speed = 1450,
            Radius = 100,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
        self.E = Spell({
            Slot = 2,
            Range = 1000,
            Delay = 0.25,
            Speed = 2000,
            Width = 70,
            Collision = false,
            From = myHero,
            Type = "Press"
        })
        self.R = Spell({
            Slot = 3,
            Range = 1100,
            Delay = 1,
            Speed = 1200,
            Radius = 150,
            Collision = false,
            From = myHero,
            Type = "AOE"
        })
    end
    
    function Xayah:Menu()
		_G.SDK.ObjectManager:OnAllyHeroLoad(function(args)
			insert(self.Allies, args.unit)
		end)
		_G.SDK.ObjectManager:OnEnemyHeroLoad(function(args)
			insert(self.Enemies, args.unit)
		end)
        --Q--
        Menu.Q:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.Q:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.Q:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.Q:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.Q:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        --Menu.Q:MenuElement({name = " ", drop = {"Farm Settings"}})
        --Menu.Q:MenuElement({id = "Clear", name = "Use on LaneClear", value = false})
        --Menu.Q:MenuElement({id = "Min", name = "Minions To Cast", value = 3, min = 0, max = 6, step = 1})
        --Menu.Q:MenuElement({id = "ManaClear", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.Q:MenuElement({name = " ", drop = {"Misc"}})
        Menu.Q:MenuElement({id = "KS", name = "Use on KS[Not Implemented]", value = true})
        --W--
        Menu.W:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.W:MenuElement({id = "Combo", name = "Use on Combo", value = true})
        Menu.W:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.W:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.W:MenuElement({id = "Harass", name = "Use on Harass", value = true})
        Menu.W:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.W:MenuElement({name = " ", drop = {"Farm Settings"}})
        Menu.W:MenuElement({id = "Jungle", name = "Use on JungleClear", value = false})
        Menu.W:MenuElement({id = "Clear", name = "Use on LaneClear", value = false})
        Menu.W:MenuElement({id = "Min", name = "Minions To Cast", value = 3, min = 0, max = 6, step = 1})
        Menu.W:MenuElement({id = "ManaClear", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        --E--
        Menu.E:MenuElement({name = " ", drop = {"Auto Settings"}})
        Menu.E:MenuElement({id = "Auto", name = "Auto Use", value = true})
        Menu.E:MenuElement({id = "MinRoot", name = "If Can Root X Enemies", value = 2, min = 1, max = 5, step = 1})
        Menu.E:MenuElement({id = "MinFeather", name = "If Can Hit X Feathers", value = 10, min = 3, max = 20, step = 1})
        Menu.E:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.E:MenuElement({id = "Combo", name = "Use in Combo", value = true})
        Menu.E:MenuElement({id = "MinRootCombo", name = "If Can Root X Enemies", value = 2, min = 1, max = 5, step = 1})
        Menu.E:MenuElement({id = "MinFeatherCombo", name = "If Can Hit X Feathers", value = 5, min = 3, max = 20, step = 1})
        Menu.E:MenuElement({id = "Mana", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.E:MenuElement({name = " ", drop = {"Harass Settings"}})
        Menu.E:MenuElement({id = "Harass", name = "Use in Harass", value = false})
        Menu.E:MenuElement({id = "MinRootHarass", name = "If Can Root X Enemies", value = 2, min = 1, max = 5, step = 1})
        Menu.E:MenuElement({id = "MinFeatherHarass", name = "If Can Hit X Feathers", value = 5, min = 3, max = 20, step = 1})
        Menu.E:MenuElement({id = "ManaHarass", name = "Min Mana %", value = 15, min = 0, max = 100, step = 1})
        Menu.E:MenuElement({name = " ", drop = {"Misc"}})
        Menu.E:MenuElement({id = "KS", name = "Use in KS", value = true})
        --R--
        Menu.R:MenuElement({name = " ", drop = {"Combo Settings"}})
        Menu.R:MenuElement({id = "Peel", name = "Use To Peel", value = true})
        Menu.R:MenuElement({id = "Min", name = "Use When X Enemies", value = 2, min = 1, max = 5, step = 1})
        Menu.R:MenuElement({id = "Gapcloser", name = "Use On Gapcloser", value = true})
        Menu.R:MenuElement({id = "Heroes", name = "Dodge Gapclosers From", type = MENU})
        --Menu.R:MenuElement({id = "Spells", name = "Dodge Spells", type = MENU})
        Menu.R:MenuElement({id = "Mana", name = "Min Mana %", value = 0, min = 0, max = 100, step = 1})
        --Draw--
        Menu.Draw:MenuElement({id = "Hit", name = "Draw X Feathers Hit", value = true})
        Menu.Draw:MenuElement({id = "Feathers", name = "Draw Feathers Pos", value = true})
        Menu.Draw:MenuElement({id = "Lines", name = "Draw Feathers Collision Lines", value = true})
        --
        Menu:MenuElement({name = "[WR] "..charName.." Script", drop = {"Release_"..self.scriptVersion}})
        --
		_G.SDK.ObjectManager:OnEnemyHeroLoad(function(args)
			Menu.R.Heroes:MenuElement({id = args.charName, name = args.charName, value = false})
		end)
    end
    
    function Xayah:OnTick()
        if ShouldWait() then return end
        --
        self.enemies = GetEnemyHeroes(1500)
        self.target = GetTarget(GetTrueAttackRange(myHero), 0)
        self.mode = GetMode()
        --
        if myHero.isChanneling then return end
        self:Auto()
        self:KillSteal()
        --
        if not self.mode or (self.mode < 3 and #self.enemies == 0) then return end
        local executeMode =
        self.mode == 1 and self:Combo() or
        self.mode == 2 and self:Harass() or
        self.mode == 3 and self:Clear() or
        self.mode == 4 and self:Clear()
        
    end
    
    function Xayah:OnWndMsg(msg, param)
        if msg == 257 then
            local ping, delay = Game.Latency() / 1000, nil
            if param == HK_Q then
                delay = self.Q.Delay + ping
            elseif param == HK_R then
                delay = self.R.Delay + ping
            elseif param == HK_E then
                delay = ping
            end
            if delay then
                DelayAction(function() self:UpdateFeathers() end, delay)
            end
        end
    end
    
    --function Xayah:OnRecall(unit, proc)
    --    --something with rakan later (?)
    --end
    
    function Xayah:OnPreMovement(args) --args.Process|args.Target
        if ShouldWait() then
            args.Process = false
            return
        end
    end
    
    function Xayah:OnPreAttack(args) --args.Process|args.Target
        if ShouldWait() then
            args.Process = false
            return
        end
        local wMenu = Menu.W
        if args.Target and self.W:IsReady() and myHero.hudAmmo <= 2 then
            local check = (self.mode == 1 and wMenu.Combo:Value() and ManaPercent(myHero) >= wMenu.Mana:Value()) or
            (self.mode == 2 and wMenu.Harass:Value() and ManaPercent(myHero) >= wMenu.ManaHarass:Value()) or
            (self.mode == 3 and wMenu.Clear:Value() and ManaPercent(myHero) >= wMenu.ManaClear:Value() and #GetEnemyMinions(600) >= wMenu.Min:Value()) or
            (self.mode == 4 and wMenu.Jungle:Value() and ManaPercent(myHero) >= wMenu.ManaClear:Value() and args.Target.team == TEAM_JUNGLE)
            if check then
                self.W:Cast()
            end
        end
    end
    
    function Xayah:OnPostAttack()
        self:UpdateFeathers()
        local target = GetTargetByHandle(myHero.attackData.target)
        if ShouldWait() or not IsValidTarget(target) then return end
    end
    
    function Xayah:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance)
        if ShouldWait() or not self.R:IsReady() then return end
        if IsValidTarget(unit) and GetDistance(unitPosTo) < 400 and unit.team == TEAM_ENEMY and IsFacing(unit, myHero) and Menu.R.Gapcloser:Value() then --Gapcloser
            if Menu.R.Heroes[unit.charName] and Menu.R.Heroes[unit.charName]:Value() then
                self.R:Cast(unitPosTo)
            end
        end
    end
    
    function Xayah:Auto()
        if Menu.E.Auto:Value() or Menu.E.KS:Value() then
            self:AutoE()
        end
        if Menu.R.Peel:Value() and self.R:IsReady() then
            local nearby = GetEnemyHeroes(400)
            if #nearby >= Menu.R.Min:Value() then
                self.R:Cast(nearby[1])
            end
        end
    end
    
    function Xayah:Combo()
        if not Menu.E.Auto:Value() and Menu.E.Combo:Value() and ManaPercent(myHero) >= Menu.E.Mana:Value() then
            self:AutoE()
        end
        --
        if not HasBuff(myHero, "XayahW") or myHero.hudAmmo <= 2 then
            if Menu.Q.Combo:Value() and self.Q:IsReady() and ManaPercent(myHero) >= Menu.Q.Mana:Value() then
                local qTarget = GetTarget(self.Q.Range, 1)
                self.Q:CastToPred(qTarget, 2)
            end
        end
    end
    
    function Xayah:Harass()
        if not Menu.E.Auto:Value() and Menu.E.Harass:Value() and ManaPercent(myHero) >= Menu.E.ManaHarass:Value() then
            self:AutoE()
        end
        --
        if not HasBuff(myHero, "XayahW") or myHero.hudAmmo <= 2 then
            if Menu.Q.Combo:Value() and self.Q:IsReady() and ManaPercent(myHero) >= Menu.Q.Mana:Value() then
                local qTarget = GetTarget(self.Q.Range, 1)
                self.Q:CastToPred(qTarget, 2)
            end
        end
    end
    
    function Xayah:Clear()
    end
    
    function Xayah:KillSteal()
        
    end
    
    local col1, col2 = DrawColor(255, 255, 0, 0), DrawColor(255, 153, 0, 153)
    function Xayah:OnDraw()
        local drawSettings = Menu.Draw
        if drawSettings.ON:Value() then
            local qLambda = drawSettings.Q:Value() and self.Q and self.Q:Draw(66, 244, 113)
            local wLambda = drawSettings.W:Value() and self.W and self.W:Draw(66, 229, 244)
            local eLambda = drawSettings.E:Value() and self.E and self.E:Draw(244, 238, 66)
            local rLambda = drawSettings.R:Value() and self.R and self.R:Draw(244, 66, 104)
            local tLambda = drawSettings.TS:Value() and self.target and DrawMark(self.target.pos, 3, self.target.boundingRadius, col1)
            if self.enemies then
                local Hit, Feathers, Lines = drawSettings.Hit:Value(), drawSettings.Feathers:Value(), drawSettings.Lines:Value()
                local currentTime = Timer()
                local myPos = myHero.pos:To2D()
                if Hit then
                    for i = 1, #self.enemies do
                        local target = self.enemies[i]
                        local hits = self:CountFeatherHits(target)
                        local pos = target.pos:To2D()
                        DrawText(tostring(hits), 25, pos.x, pos.y, DrawColor(255, 255, 255, 0))
                    end
                end
                if Feathers or Lines then
                    for i = 1, #self.PassiveTable do
                        local object = self.PassiveTable[i]
                        if object and object.placetime > currentTime then
                            if Feathers then
                                DrawCircle(object.pos, 50, 3, object.hit and col1 or col2)
                            end
                            if Lines then
                                local pos = object.pos:To2D()
                                DrawLine(myPos.x, myPos.y, pos.x, pos.y, 4, object.hit and col1 or col2)
                            end
                            object.hit = false
                        else
                            remove(self.PassiveTable, i)
                        end
                    end
                end
            end
        end
    end
    
    function Xayah:CheckFeather(obj)
        for i = 1, #self.PassiveTable do
            if self.PassiveTable[i].ID == obj.networkID then
                return true
            end
        end
    end
    
    function Xayah:CountFeatherHits(target)
        local HitCount = 0
        if target then
            for i = 1, #self.PassiveTable do
                local collidingLine = LineSegment(myHero.pos, self.PassiveTable[i].pos)
                if Point(target):__distance(collidingLine) < 80 + target.boundingRadius then
                    HitCount = HitCount + 1
                    self.PassiveTable[i].hit = true
                end
            end
        end
        return HitCount
    end
    
    function Xayah:UpdateFeathers()
        --[[Particles are more precise but will only be detected on endPos]]
        --for i = 0,GameObjectCount() do
        --    local obj = GameObject(i)
        --    if obj.owner == myHero and obj.name == "Feather" and not obj.dead and not self:CheckFeather(obj) then
        --        self.PassiveTable[#self.PassiveTable+1] = {placetime = Timer() + 6, ID = obj.networkID, pos = Vector(obj.pos), hit = false})
        --    end
        --end
        --[[Missiles will be detected instantly but can lead to wrong positions (eg out of map bondaries)]]
        for i = 1, MissileCount() do
            local missile = Missile(i)
            --print(missile.missileData.name)
            if missile.missileData and missile.missileData.owner == myHero.handle and not self:CheckFeather(missile) then
                if missile.missileData.name:find("XayahQMissile1") or missile.missileData.name:find("XayahQMissile2") then --pls dont change this line
                    self.PassiveTable[#self.PassiveTable + 1] = {placetime = Timer() + 6, ID = missile.networkID, pos = Vector(missile.missileData.endPos), hit = false} --pls dont remove Vector() here
                elseif missile.missileData.name:find("XayahRMissile") then
                    self.PassiveTable[#self.PassiveTable + 1] = {placetime = Timer() + 6, ID = missile.networkID, pos = Vector(missile.missileData.endPos):Extended(myHero.pos, 100), hit = false} --pls dont remove Vector() here
                elseif missile.missileData.name:find("XayahPassiveAttack") then
                    self.PassiveTable[#self.PassiveTable + 1] = {placetime = Timer() + 6, ID = missile.networkID, pos = Vector(myHero.pos:Extended(missile.missileData.endPos, 1000)), hit = false} --pls dont remove Vector() here
                elseif missile.missileData.name:find("XayahEMissileSFX") then
                    self.PassiveTable = {}
                end
            end
        end
    end
    
    function Xayah:AutoE()
        if not (self.enemies and self.E:IsReady()) then return end
        local config = Menu.E
        local ksActive = config.KS:Value()
        local Auto, Combo, Harass = config.Auto:Value() and self.mode and self.mode >= 3, (config.Combo:Value() and ManaPercent(myHero) >= Menu.E.Mana:Value() and self.mode == 1), (config.Harass:Value() and ManaPercent(myHero) >= Menu.E.ManaHarass:Value() and self.mode == 2)
        local minRoot = (Auto and config.MinRoot:Value()) or (Combo and config.MinRootCombo:Value()) or (Harass and config.MinRootHarass:Value()) or huge
        local minHit = (Auto and config.MinFeather:Value()) or (Combo and config.MinFeatherCombo:Value()) or (Harass and config.MinFeatherHarass:Value()) or huge
        local rootedEnemies, feathersHit = 0, 0
        --
        if not (Auto or Combo or Harass or ksActive) then return end
        for i = 1, #(self.enemies) do
            local target = self.enemies[i]
            if IsValidTarget(target) then
                local hitsOnTarget = self:CountFeatherHits(target)
                --
                feathersHit = feathersHit + hitsOnTarget
                if hitsOnTarget >= 3 then
                    rootedEnemies = rootedEnemies + 1
                end
                --
                if ksActive then
                    local rawDmg = (45 + myHero:GetSpellData(_E).level * 10 + 0.6 * myHero.bonusDamage) * hitsOnTarget * (1 + myHero.critChance / 2)
                    local dmg = CalcPhysicalDamage(myHero, target, rawDmg)
                    if dmg > target.health then
                        self.E:Cast()
                    end
                end
            end
        end
        if rootedEnemies >= minRoot or feathersHit >= minHit then
            self.E:Cast()
        end
    end
    
    table.insert(LoadCallbacks, function()
        Xayah()
    end)
end

Callback.Add('Load', function()
    for i = 1, #LoadCallbacks do
        LoadCallbacks[i]()
    end
end)
