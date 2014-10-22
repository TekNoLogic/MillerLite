
local myname, ns = ...
local UNK = "Interface\\Icons\\INV_Misc_QuestionMark"
ns.BUTTON_SIZE = 32


local function GS(cash)
	if not cash then return end
	if cash > 999999 then return "|cffffd700".. floor(cash/10000) end

	cash = cash/100
	local s = floor(cash%100)
	local g = floor(cash/100)
	if g > 0 then return string.format("|cffffd700%d.|cffc7c7cf%02d", g, s)
	else return string.format("|cffc7c7cf%d", s) end
end


local function G(cash)
	if not cash then return end
	return "|cffffd700".. floor(cash/10000)
end


local function HideTooltip() GameTooltip:Hide() end
local function ShowTooltip(self)
	if self.id then
		GameTooltip:SetOwner(self, "ANCHOR_NONE")
		GameTooltip:SetPoint("TOPLEFT", self, "TOPRIGHT")
		GameTooltip:SetHyperlink("item:"..self.id)
	end
end


local function OnEvent(self)
	if not self.id then return end
	local count = GetItemCount(self.id)
	self.count:SetText(count > 0 and count or "")
	if self.text then self.text:SetText(GS(GetAuctionBuyout and GetAuctionBuyout(self.id))) end
end


local function OnHide(self) self:UnregisterEvent("AUCTION_ITEM_LIST_UPDATE") end
local function OnShow(self)
	self:RegisterEvent("AUCTION_ITEM_LIST_UPDATE")
	OnEvent(self)
end


function ns.ButtonFactory(parent, id, ...)
	local f = CreateFrame("CheckButton", nil, parent, "SecureActionButtonTemplate")
	local texture = GetItemIcon(id)
	local name, link = GetItemInfo(id)
	f.id = id

	f:SetHeight(ns.BUTTON_SIZE)
	f:SetWidth(ns.BUTTON_SIZE)
	if select("#", ...) > 0 then f:SetPoint(...) end
	f:SetScript("OnEnter", ShowTooltip)
	f:SetScript("OnLeave", HideTooltip)
	f:SetScript("OnShow", OnShow)
	f:SetScript("OnHide", OnHide)
	f:SetScript("OnEvent", OnEvent)

	local icon = f:CreateTexture(nil, "ARTWORK")
	icon:SetAllPoints(f)
	icon:SetTexture(texture)
	f.icon = icon

	f.text = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	f.text:SetPoint("TOP", icon, "BOTTOM")

	local count = f:CreateFontString(nil, "ARTWORK", "NumberFontNormalSmall")
	count:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", -2, 2)
	f.count = count

	if id then
		f:SetAttribute("type", "macro")
		local macrotext = "/run "..
		                  "ExactMatchCheckButton:SetChecked(true); "..
		                  "BrowseName:SetText((GetItemInfo("..id.."))); "..
		                  "AuctionFrameBrowse_Search()"
		f:SetAttribute("macrotext", macrotext)
	end

	OnShow(f)
	return f
end
