local PANEL = {}


function PANEL:Init()

	self.m_Text1 = vgui.Create("DLabel", self)
	self.m_Text2 = vgui.Create("DLabel", self)
	self.m_Text3 = vgui.Create("DLabel", self)
	self:SetTextFont("ZSHUDFontTiny")

	self.m_Text1.Paint = self.Text1Paint
	self.m_Text2.Paint = self.Text2Paint
	self.m_Text3.Paint = self.Text3Paint


	self:InvalidateLayout()
end

function PANEL:SetTextFont(font)
	self.m_Text1.Font = font
	self.m_Text1:SetFont(font)
	self.m_Text2.Font = font
	self.m_Text2:SetFont(font)
	self.m_Text3.Font = font
	self.m_Text3:SetFont(font)

	self:InvalidateLayout()
end

function PANEL:PerformLayout()
	local hs = self:GetTall() * 0.5

	self.m_Text1:SetWide(self:GetWide())
	self.m_Text1:SizeToContentsY()
	--self.m_Text1:AlignTop(30)
	self.m_Text1:AlignBottom()
	
	self.m_Text2:SetWide(self:GetWide())
	self.m_Text2:SizeToContentsY()
	self.m_Text2:CenterVertical()
	
	self.m_Text3:SetWide(self:GetWide())
	self.m_Text3:SizeToContentsY()
	self.m_Text3:AlignBottom()

end
 
function PANEL:Text1Paint()
	local text
	local override = MySelf:IsValid() and GetGlobalString("hudoverride"..MySelf:Team(), "")

	if override and #override > 0 then
		text = override
	else
		local wave = GAMEMODE:GetWave()
		if GAMEMODE:IsEscapeSequence() then
			text = translate.Get(MySelf:IsValid() and MySelf:Team() == TEAM_UNDEAD and "prop_obj_exit_z" or "prop_obj_exit_h")
		elseif wave <= 0 then
			text = translate.Get("prepare_yourself")
		elseif GAMEMODE.ZombieEscape then
			text = translate.Get("zombie_escape")
		else
			local maxwaves = GAMEMODE:GetNumberOfWaves()
			if maxwaves ~= -1 then
				text = translate.Format("wave_x_of_y", wave, maxwaves)
				if not GAMEMODE:GetWaveActive() then
					text = translate.Get("intermission")
				end
			elseif not GAMEMODE:GetWaveActive() then
				text = translate.Get("intermission")
			end
		end
	end
	
	local myteam = MySelf:Team()
	
if myteam == TEAM_UNDEAD then
	if text then
		draw.SimpleText(text, "ZSHUDFontSmallZombie", 130, 0, COLOR_GRAY)
	end
end

if myteam == TEAM_HUMAN then
	if text then
		draw.SimpleText(text, self.Font, 130, 0, COLOR_GRAY)
	end
end	

	return true
end

function PANEL:Text2Paint()

local myteam = MySelf:Team()

if myteam == TEAM_UNDEAD then
	if GAMEMODE:GetWave() <= 0 then
		local col
		local timeleft = math.max(0, GAMEMODE:GetWaveStart() - CurTime())
		if timeleft < 10 then
			local glow = math.sin(RealTime() * 8) * 200 + 255
			col = Color(255, glow, glow)
		else
			col = COLOR_GRAY
		end
		
		draw.SimpleText("Invasion In " .. util.ToMinutesSeconds(timeleft) .. "", "ZSHUDFontSmallZombie", 130, 0, col)
	elseif GAMEMODE:GetWaveActive() then
		local waveend = GAMEMODE:GetWaveEnd()
		if waveend ~= -1 then
			local timeleft = math.max(0, waveend - CurTime())
			draw.SimpleText(translate.Format("wave_ends_in_x", util.ToMinutesSeconds(timeleft)), "ZSHUDFontSmallZombie", 130, 0, 10 < timeleft and COLOR_GRAY or Color(255, 0, 0, math.abs(math.sin(RealTime() * 8)) * 180 + 40))
		end	
	else
		local wavestart = GAMEMODE:GetWaveStart()
		if wavestart ~= -1 then
			local timeleft = math.max(0, wavestart - CurTime())
			draw.SimpleText(translate.Format("next_wave_in_x", util.ToMinutesSeconds(timeleft)), "ZSHUDFontSmallZombie", 130, 0, 10 < timeleft and COLOR_GRAY or Color(255, 0, 0, math.abs(math.sin(RealTime() * 8)) * 180 + 40))
		end
	end

	return true


end

if myteam == TEAM_HUMAN then
	if GAMEMODE:GetWave() <= 0 then
		local col
		local timeleft = math.max(0, GAMEMODE:GetWaveStart() - CurTime())
		if timeleft < 10 then
			local glow = math.sin(RealTime() * 8) * 200 + 255
			col = Color(255, glow, glow)
		else
			col = COLOR_GRAY
		end
		
		draw.SimpleText("Invasion In " .. util.ToMinutesSeconds(timeleft) .. "", self.Font, 130, 0, col)
	elseif GAMEMODE:GetWaveActive() then
		local waveend = GAMEMODE:GetWaveEnd()
		if waveend ~= -1 then
			local timeleft = math.max(0, waveend - CurTime())
			draw.SimpleText(translate.Format("wave_ends_in_x", util.ToMinutesSeconds(timeleft)), self.Font, 130, 0, 10 < timeleft and COLOR_GRAY or Color(255, 0, 0, math.abs(math.sin(RealTime() * 8)) * 180 + 40))
		end	
	else
		local wavestart = GAMEMODE:GetWaveStart()
		if wavestart ~= -1 then
			local timeleft = math.max(0, wavestart - CurTime())
			draw.SimpleText(translate.Format("next_wave_in_x", util.ToMinutesSeconds(timeleft)), self.Font, 130, 0, 10 < timeleft and COLOR_GRAY or Color(255, 0, 0, math.abs(math.sin(RealTime() * 8)) * 180 + 40))
		end
	end

	return true


end

	
end

function PANEL:Text3Paint()
	--[[if MySelf:IsValid() then
		if MySelf:Team() == TEAM_UNDEAD then
			local toredeem = GAMEMODE:GetRedeemBrains()
			if toredeem > 0 then
				draw.SimpleText(translate.Format("brains_eaten_x", MySelf:Frags().." / "..toredeem), self.Font, 130, 0, COLOR_DARKRED)
			else
				draw.SimpleText(translate.Format("brains_eaten_x", MySelf:Frags()), self.Font, 130, 0, COLOR_DARKRED)
			end
		end
	end]]--

	return true
end


function PANEL:Paint()
	return true
end

vgui.Register("DGameState", PANEL, "DPanel")
