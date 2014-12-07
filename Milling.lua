
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
  113111 114931 109124 109125 109126 109127 109128 109129
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
  10940 11083 11137 11176 16204 22445 34054 52555 74249 109693
  10938 10998 11134 11174 16202 22447 34056 52718 74250
  10939 11082 11135 11175 16203 22446 34055 52719
    0   10978 11138 11177 14343 22448 34053 52720 74252 115502
    0   11084 11139 11178 14344 22449 34052 52721 74247 111245
  41163   0     0     0   20725 22450 34057 52722 74248 115504
    0     0     0   52328 52326 52325 52329 52327   0   113588
    0     0   35627 35623 35622 36860 35625 35624
]], AuctionFrameBrowse, "RIGHT", in2_butt, "LEFT", -2, 0)


local fish_butt = panel_factory("Fish", [[
	109137 111589 111595 111601    0      0      0   109123 109226
	109142 111658 111665 111672 110292    0   111439 109223 111603
	109138 111650 111669 111676 110274 112630 111446 116268
	109139 111651 111668 111675 110289 112631 111444 116276
	109140 111652 111667 111674 110290 112629 111442 118711
	109141 111656 111666 111673 110291 112628 111445 118704 116981
	109143 111659 111664 111671 110293 112627 111441 116271 109218
  109144 111662 111663 111670 110294 112626 116266 109222 116979
]], AuctionFrameBrowse, "RIGHT", ench_butt, "LEFT", -2, 0)


local butt_wod = panel_factory("WoD", [[
	113261 113262 113263 113264    0   114931 109124 109126    0   109118 109119    0   110609 111557
	114810 114811 114813 114809 114812 114816 114815 114814 114836 114837 114838 114821 114817 114818 114819 113216
]], AuctionFrameBrowse, "RIGHT", fish_butt, "LEFT", -2, 0)
