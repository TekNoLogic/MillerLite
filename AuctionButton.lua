
local myname, ns = ...


local anchor
local factory = LibStub("tekKonfig-Button").new_small
local frames = {}
local function OnClick(self)
	local shown = frames[self]:IsShown()
	for butt,frame in pairs(frames) do frame:Hide() end
	if not shown then frames[self]:Show() end
end


function ns.NewButton(buttname, frame)
	local butt
	if anchor then
		butt = factory(AuctionFrameBrowse, "RIGHT", anchor, "LEFT", -2, 0)
	else
		butt = factory(AuctionFrameBrowse, "TOPRIGHT", 40, -15)
	end

	butt:SetText(buttname)
	butt:SetSize(butt:GetTextWidth() + 8, 18)
	butt:SetScript("OnClick", OnClick)

	frames[butt] = frame
	anchor = butt

	return butt
end
