local function enum(tbl)
	local index = {}
	local call = {}
	for k, v in pairs(tbl) do
		if index[k] then
			return error(string.format('enum clash for %q and %q', k, index[k]))
		end
		index[k] = v
		call[v] = k
		tbl[k] = nil
	end
	return setmetatable(tbl, {
		__call = function(_, k) return call[k] end,
		__index = function(_, k) return index[k] end,
		__newindex = function() return error('cannot overwrite enumeration') end,
	})
end

local enums = {enum = enum}

enums.channelType = enum {
	text    = 0,
	private = 1,
	voice   = 2,
	group   = 3,
}

enums.messageType = enum {
    default           = 0,
    recipientAdd      = 1,
    recipientRemove   = 2,
    call              = 3,
    channelNameChange = 4,
	channelIconchange = 5,
	pinsAdd           = 6,
	join              = 7,
}

enums.verificationLevel = enum {
    none            = 0,
    low             = 1,
    medium          = 2,
	tableFlip       = 3,
	doubleTableFlip = 4,
}

enums.permission = enum {
	createInstantInvite = 0x00000001,
	kickMembers         = 0x00000002,
	banMembers          = 0x00000004,
	administrator       = 0x00000008,
	manageChannels      = 0x00000010,
	manageGuild         = 0x00000020,
	addReactions        = 0x00000040,
	viewAuditLog        = 0x00000080,
	readMessages        = 0x00000400,
	sendMessages        = 0x00000800,
	sendTextToSpeech    = 0x00001000,
	manageMessages      = 0x00002000,
	embedLinks          = 0x00004000,
	attachFiles         = 0x00008000,
	readMessageHistory  = 0x00010000,
	mentionEveryone     = 0x00020000,
	useExternalEmojis   = 0x00040000,
	connect             = 0x00100000,
	speak               = 0x00200000,
	muteMembers         = 0x00400000,
	deafenMembers       = 0x00800000,
	moveMembers         = 0x01000000,
	useVoiceActivity    = 0x02000000,
	changeNickname      = 0x04000000,
	manageNicknames     = 0x08000000,
	manageRoles         = 0x10000000,
	manageWebhooks      = 0x20000000,
	manageEmojis        = 0x40000000,
}

enums.logLevel = enum {
	none    = 0,
	error   = 1,
	warning = 2,
	info    = 3,
	debug   = 4,
}

return enums