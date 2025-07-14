Config = {}

Config.Translation = function(source, name, reason)
    return 'PELAAJA ~b~[~y~'..source..'~b~] ~b~'..name..'~s~ LÄHTI PALVELIMELTA\n~o~SYYSTÄ~s~: ~r~'..reason;
end

Config.Reasons = {
    ['timed out'] = 'Timed Out',
    ['crash'] = 'Crash',
    ['Exiting'] = 'Quit',
    ['Disconnected.'] = 'Disconnect',
}
