
local myname, ns = ...


local BACKDROP = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	edgeSize = 16,
	insets = {left = 4, right = 4, top = 4, bottom = 4},
	tile = true,
	tileSize = 16,
}


function ns.NewPanel(buttname, itemids)
	local f = CreateFrame("Frame", nil, AuctionFrameBrowse)
	f:SetPoint("TOP", 0, -21)
	f:SetPoint("BOTTOM", 0, 18)
	f:SetPoint("LEFT", AuctionFrameBrowse, "RIGHT", 65, 0)
	f:Hide()

	f:SetFrameLevel(AuctionFrameBrowse:GetFrameLevel()-1)

	f:SetBackdrop(BACKDROP)
	f:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b)
	f:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)


	local frame = CreateFrame("Frame", nil, f)
	frame:SetPoint("TOPLEFT", 10, -5)
	frame:SetPoint("BOTTOMRIGHT")

	local lastrow
	local width = 0
	for ids in itemids:gmatch("[^\n]+") do
		local row = ns.NewPanelRow(ids, frame)

		if lastrow then
			row:SetPoint("TOPLEFT", lastrow, "BOTTOMLEFT")
		else
			row:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -5)
		end

		width = math.max(width, row:GetWidth())
		lastrow = row
	end

	f:SetWidth(width)

	ns.NewButton(buttname, f)
end
