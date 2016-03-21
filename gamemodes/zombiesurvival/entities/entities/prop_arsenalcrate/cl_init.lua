include("shared.lua")

function ENT:Initialize()
	self:SetRenderBounds(Vector(-72, -72, -72), Vector(72, 72, 128))
end



function ENT:SetObjectHealth(health)
	self:SetDTFloat(0, health)
end

local colFlash = Color(30, 255, 30)
function ENT:Draw()
	

	if not MySelf:IsValid() then return end

	

	    self:DrawModel()

	    if not IsValid(MySelf) or MySelf:Team() ~= TEAM_HUMAN then
	        return
	    end

		if MySelf.MobileSupplyTimerActive == false then
	    	--self.LineColor = Color(0, math.abs(200 * math.sin(CurTime() * 3)), 0, 100)
	    elseif self.LineColor ~= Color(210, 0, 0, 100) then
	    	--self.LineColor = Color(210, 0, 0, 100)
	    end

	    --Draw some stuff
	    local pos = self:GetPos() + Vector(0,0,45)

	    --Check for distance with local player
	    if pos:Distance(MySelf:GetPos()) > 400 then
	        return
	    end
	          
	    local angle = (MySelf:GetPos() - pos):Angle()
	    angle.p = 0
	    angle.y = angle.y + 90
	    angle.r = angle.r + 90

	    cam.Start3D2D(pos,angle,0.26)

		local owner = self:GetObjectOwner()
		local validOwner = (IsValid(owner) and owner:Alive() and owner:Team() == TEAM_HUMAN)
	
		if validOwner then
			draw.SimpleTextOutlined( owner:Name() .."'s Weapons and Supplies", "ZSHUDFontSmall", 0, 0, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER,1, Color(0,0,0,255))
		else
			draw.SimpleTextOutlined( "Weapons and Supplies", "ZSHUDFontSmall", -20, 0, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER,1, Color(0,0,0,255))
		end
	
	    cam.End3D2D()

		self:DrawModel()
end

