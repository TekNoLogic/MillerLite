
local myname, ns = ...
local HGAP, VGAP = 5, -18


local bgFrame = {bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", insets = {left = PADDING, right = PADDING, top = PADDING, bottom = PADDING},
	tile = true, tileSize = 16, edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16}


local frames = {}
local function panel_factory(buttname, itemids, ...)
	local f = CreateFrame("Frame", nil, AuctionFrameBrowse)
	f:SetPoint("TOP", 0, -21)
	f:SetPoint("BOTTOM", 0, 21)
	f:SetPoint("LEFT", AuctionFrameBrowse, "RIGHT", 65, 0)
	f:Hide()
	frames[f] = true

	f:SetFrameLevel(AuctionFrameBrowse:GetFrameLevel()-1)


	f:SetBackdrop(bgFrame)
	f:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b)
	f:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)


	local frame = CreateFrame("Frame", nil, f)
	frame:SetPoint("TOPLEFT", 10, 0)
	frame:SetPoint("BOTTOMRIGHT")


	local numrows, lastrow = 0
	local num_columns = 0
	for ids in itemids:gmatch("[^\n]+") do
		local this_num_columns = 0
		numrows = numrows + 1
		local row = CreateFrame("Frame", nil, frame)
		row:SetHeight(32) row:SetWidth(1)
		row:SetPoint("TOPLEFT", lastrow or frame, lastrow and "BOTTOMLEFT" or "TOPLEFT", 0, lastrow and VGAP or -HGAP)
		lastrow = row

		local gap, lastframe = 0
		for id in ids:gmatch("%d+") do
			this_num_columns = this_num_columns + 1
			gap = gap + (lastframe and HGAP or 0)
			id = tonumber(id)
			if id == 0 then gap = gap + 32 + (not lastframe and HGAP or 0)
			else
				lastframe = ns.ButtonFactory(frame, id, "TOPLEFT", lastframe or row, lastframe and "TOPRIGHT" or "TOPLEFT", gap, 0)
				gap = 0
			end
		end
		num_columns = math.max(num_columns, this_num_columns)
	end

	f:SetWidth((ns.BUTTON_SIZE + HGAP) * num_columns + 12)

	local butt = LibStub("tekKonfig-Button").new_small(...)
	butt:SetText(buttname)
	butt:SetWidth(30)
	butt:SetHeight(18)
	butt:SetScript("OnClick", function()
		local shown = f:IsShown()
		for frame in pairs(frames) do frame:Hide() end
		if not shown then f:Show() end
	end)

	return butt
end


local in_butt = panel_factory("Ins", [[
	79254 72234 72235 72237 79010 79011 89639
  61978 52983 52984 52985 52986 52987 52988
  43126 36901 36904 36907 37921 36905 36906 36903 39970
  43124 22785 22786 22787 22789 22790 22791 22792 22793
]], AuctionFrameBrowse, "TOPRIGHT", 40, -15)

local in2_butt = panel_factory("Ins2", [[
  43122 13464 13463 13465 13466 13467
  43120  4625  8831  8836  8838  8845  8839  8846
  43118  3818  3821  3358  3819
  43116  3369  3355  3356  3357
  39774   785  2450  2452  3820  2453
  39469  2447   765  2449
]], AuctionFrameBrowse, "RIGHT", in_butt, "LEFT", -2, 0)


local ench_butt = panel_factory("Ench", [[
  10940 11083 11137 11176 16204 22445 34054 52555
  10938 10998 11134 11174 16202 22447 34056 52718
  10939 11082 11135 11175 16203 22446 34055 52719
    0   10978 11138 11177 14343 22448 34053 52720
    0   11084 11139 11178 14344 22449 34052 52721
  41163   0     0     0   20725 22450 34057 52722
    0     0     0   52328 52326 52325 52329 52327
    0     0   35627 35623 35622 36860 35625 35624
]], AuctionFrameBrowse, "RIGHT", in2_butt, "LEFT", -2, 0)


local gem_butt = panel_factory("JC", [[
  72092 72093 72103 72094
  76136 76131
  76130 76140
  76134 76142
  76137 76139
  76133 76138
  76135 76141
]], AuctionFrameBrowse, "RIGHT", ench_butt, "LEFT", -2, 0)


local gem2_butt = panel_factory("JC2", [[
  23424 23425   0   36909 36912 36910 53038 52185 52183
  23077 23436 32227 36917 36918 36919 52177 52190 71805
  21929 23439 32231 36929 36930 36931 52181 52193 71808
  23112 23440 32229 36920 36921 36922 52179 52195 71806
  23079 23437 32249 36932 36933 36934 52182 52192 71810
  23117 23438 32228 36923 36924 36925 52178 52191 71807
  23107 23441 32230 36926 36927 36928 52180 52194 71809
    0   25867 25868 41334 41266
]], AuctionFrameBrowse, "RIGHT", gem_butt, "LEFT", -2, 0)


local resell_butt = panel_factory("Re", [[
	43102 33567
	36908 33568
	36860 38425
	45087 44128
	47556
]], AuctionFrameBrowse, "RIGHT", gem2_butt, "LEFT", -2, 0)

