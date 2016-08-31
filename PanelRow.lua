
local myname, ns = ...
local HGAP = 5


function ns.NewPanelRow(ids, frame, lastrow)
	local row = CreateFrame("Frame", nil, frame)

	local columns = 0
	local gap, lastbutton = 0
	for id in ids:gmatch("%d+") do
		columns = columns + 1
		gap = gap + (lastbutton and HGAP or 0)
		id = tonumber(id)
		if id == 0 then
			gap = gap + 32
			if lastbutton then gap = gap + HGAP end
		else
			local button = ns.ButtonFactory(frame, id)
			if lastbutton then
				button:SetPoint("TOPLEFT", lastbutton, "TOPRIGHT", gap, 0)
			else
				button:SetPoint("TOPLEFT", row, "TOPLEFT", gap, 0)
			end
			gap = 0
			lastbutton = button
		end
	end

	local buttsize = lastbutton:GetWidth()
	local width = (buttsize + HGAP) * columns + 12
	row:SetSize(width, buttsize + 18)

	return row
end
