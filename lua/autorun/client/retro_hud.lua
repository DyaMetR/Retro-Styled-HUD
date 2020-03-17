--[[-----------------

	RETRO STYLE HUD
	by DyaMetR
	and Raz0r

	Version 1.2.0
	15/06/19

]]-------------------

surface.CreateFont( "osrhud1", {
font = "Windows",
size = 33,
weight = 1000,
blursize = 0,
scanlines = 0,
antialias = true
})

surface.CreateFont( "osrhud2", {
font = "Windows",
size = 33,
weight = 1000,
blursize = 0,
scanlines = 0,
antialias = true
})

local Enabled = CreateClientConVar("rsh_enabled", 1, true, true)
local Numbers = CreateClientConVar("rsh_numbers", 1, true, true)

local hptick = CurTime() + 0.35
local hpalpha = 255

function OSRHUD()
    local me = LocalPlayer()
    local hp = me:Health()
    local ap = me:Armor()

	if Enabled:GetInt() == 1 then

    if hp > 20 then
        if hpalpha < 255 then
            hpalpha = 255
        end
    else
        if hptick < CurTime() then
            if hpalpha > 0 then
                hpalpha = 0
            else
                hpalpha = 255
            end
            hptick = CurTime() + 0.35
        end
    end

    surface.SetDrawColor(Color(255,255,255,255))
    surface.SetMaterial(Material("retro_hud/no_heart.png"))
    surface.DrawTexturedRect(20, ScrH() - 100, 101*2, 22)

    surface.SetDrawColor(Color(255,255,255,hpalpha))
    surface.SetMaterial(Material("retro_hud/heart.png"))
    render.SetScissorRect(20,ScrH() - 100,20+(101*2)*hp/100,ScrH() - 80,true)
    surface.DrawTexturedRect(20, ScrH() - 100, 101*2, 22)
    render.SetScissorRect(20,ScrH() - 100,20+(101*2)*hp/100,ScrH() - 80,false)

	if Numbers:GetInt() == 1 then

    draw.SimpleText(math.max(hp, 0), "osrhud2", 226, ScrH() - 105, Color(0,0,0,255))
    draw.SimpleText(math.max(hp, 0), "osrhud2", 225, ScrH() - 106, Color(255,0,0,hpalpha))

	end

    if ap > 0 then
        surface.SetDrawColor(Color(255,255,255,255))
        surface.SetMaterial(Material("retro_hud/no_armor.png"))
        surface.DrawTexturedRect(20, ScrH() - 78, 101*2, 22)

        surface.SetDrawColor(Color(255,255,255,255))
        surface.SetMaterial(Material("retro_hud/armor.png"))
        render.SetScissorRect(20,ScrH() - 78,20+(101*2)*ap/100,ScrH() - 52,true)
        surface.DrawTexturedRect(20, ScrH() - 78, 101*2, 22)
        render.SetScissorRect(20,ScrH() - 78,20+(101*2)*ap/100,ScrH() - 52,false)

		if Numbers:GetInt() == 1 then

        draw.SimpleText(ap, "osrhud1", 225, ScrH() - 82, Color(0,0,0,255))
        draw.SimpleText(ap, "osrhud1", 224, ScrH() - 83, Color(0,148,255,255))

		end
    end

    local wep = me:GetActiveWeapon()
    if wep != NULL then
    local clip = wep:Clip1()
    local sec = me:GetAmmoCount(wep:GetSecondaryAmmoType())
    local extra = me:GetAmmoCount(wep:GetPrimaryAmmoType())
    local max = 0

        if me:GetActiveWeapon():GetClass() == "weapon_pistol" then
            max = 18
        elseif me:GetActiveWeapon():GetClass() == "weapon_smg1" then
            max = 45
        elseif me:GetActiveWeapon():GetClass() == "weapon_357" then
            max = 6
        elseif me:GetActiveWeapon():GetClass() == "weapon_ar2" then
            max = 30
        elseif me:GetActiveWeapon():GetClass() == "weapon_shotgun" then
            max = 6
        elseif me:GetActiveWeapon():GetClass() == "weapon_crossbow" then
            max = 1
        else
            if me:GetActiveWeapon().Primary != nil then
                max = me:GetActiveWeapon().Primary.ClipSize
            else
                max = 0
            end
        end

        if wep:GetPrimaryAmmoType() > 0 and clip > -1 then
            if clip <= 50 then
                if max <= 50 then
                    surface.SetDrawColor(Color(255,255,255,255))
                    surface.SetMaterial(Material("retro_hud/no_bullet.png"))
                    for i = 1,max do
                        surface.DrawTexturedRect(ScrW() - 43 - i*7, ScrH() - 101, 7, 26)
                    end
                else
                    surface.SetDrawColor(Color(255,255,255,255))
                    surface.SetMaterial(Material("retro_hud/no_bullet.png"))
                    for i = 1,50 do
                        surface.DrawTexturedRect(ScrW() - 43 - i*7, ScrH() - 101, 7, 26)
                    end
                end

                surface.SetDrawColor(Color(255,255,255,255))
                surface.SetMaterial(Material("retro_hud/bullet.png"))
                for i = 1,clip do
                    surface.DrawTexturedRect((ScrW() - 42) - i*7, ScrH() - 100, 5, 24)
                end

                if sec <= 50 then
					surface.SetDrawColor(Color(255,120,0,255))
					surface.SetMaterial(Material("retro_hud/no_bullet.png"))
					for i = 1,sec do
						surface.DrawTexturedRect((ScrW() - 43) - i*7, ScrH() - 74, 7, 26)
					end

					surface.SetDrawColor(Color(255,120,0,255))
					surface.SetMaterial(Material("retro_hud/bullet.png"))
					for i = 1,sec do
						surface.DrawTexturedRect((ScrW() - 42) - i*7, ScrH() - 73, 5, 24)
					end
				else
					surface.SetDrawColor(Color(255,120,0,255))
					surface.SetMaterial(Material("retro_hud/no_bullet.png"))
					for i = 1,50 do
						surface.DrawTexturedRect((ScrW() - 43) - i*7, ScrH() - 74, 7, 26)
					end

					surface.SetDrawColor(Color(255,120,0,255))
					surface.SetMaterial(Material("retro_hud/bullet.png"))
					for i = 1,50 do
						surface.DrawTexturedRect((ScrW() - 42) - i*7, ScrH() - 73, 5, 24)
					end
          draw.SimpleText("+"..sec - 50, "osrhud1", ScrW() - 44, ScrH() - 47, Color(0,0,0), 2)
					draw.SimpleText("+"..sec - 50, "osrhud1", ScrW() - 45, ScrH() - 48, Color(255,120,0), 2)
				end
                draw.SimpleText(extra, "osrhud1", ScrW() - 43, ScrH() - 129, Color(0,0,0), 2)
                draw.SimpleText(extra, "osrhud1", ScrW() - 44, ScrH() - 130, Color(255,255,0), 2)
            else
                surface.SetDrawColor(Color(255,255,255,255))
                surface.SetMaterial(Material("retro_hud/no_bullet.png"))
                for i = 1,50 do
                    surface.DrawTexturedRect(ScrW() - 43 - i*7, ScrH() - 101, 7, 26)
                end

                surface.SetDrawColor(Color(255,255,255,255))
                surface.SetMaterial(Material("retro_hud/bullet.png"))
                for i = 1,50 do
                    surface.DrawTexturedRect((ScrW() - 42) - i*7, ScrH() - 100, 5, 24)
                end

				if sec <= 50 then
					surface.SetDrawColor(Color(255,255,255,255))
					surface.SetMaterial(Material("retro_hud/no_bullet.png"))
					for i = 1,sec do
						surface.DrawTexturedRect((ScrW() - 43) - i*7, ScrH() - 74, 7, 26)
					end

					surface.SetDrawColor(Color(255,120,0,255))
					surface.SetMaterial(Material("retro_hud/bullet.png"))
					for i = 1,sec do
						surface.DrawTexturedRect((ScrW() - 42) - i*7, ScrH() - 73, 5, 24)
					end
				else
					surface.SetDrawColor(Color(255,120,0,255))
					surface.SetMaterial(Material("retro_hud/no_bullet.png"))
					for i = 1,50 do
						surface.DrawTexturedRect((ScrW() - 43) - i*7, ScrH() - 74, 7, 26)
					end

					surface.SetDrawColor(Color(255,120,0,255))
					surface.SetMaterial(Material("retro_hud/bullet.png"))
					for i = 1,50 do
						surface.DrawTexturedRect((ScrW() - 42) - i*7, ScrH() - 73, 5, 24)
					end
          draw.SimpleText("+"..sec - 50, "osrhud1", ScrW() - 44, ScrH() - 47, Color(0,0,0), 2)
					draw.SimpleText("+"..sec - 50, "osrhud1", ScrW() - 45, ScrH() - 48, Color(255,120,0), 2)
				end

              draw.SimpleText(extra.."+"..clip - 50, "osrhud1", ScrW() - 44, ScrH() - 130, Color(0,0,0), 2)
              draw.SimpleText(extra.."+"..clip - 50, "osrhud1", ScrW() - 45, ScrH() - 131, Color(255,255,0), 2)

            end
        end

        if wep:GetPrimaryAmmoType() > 0 and clip < 0 then
            if extra <= 50 then
                surface.SetDrawColor(Color(255,255,255,255))
                surface.SetMaterial(Material("retro_hud/no_bullet.png"))
                for i = 1,extra do
                    surface.DrawTexturedRect(ScrW() - 43 - i*7, ScrH() - 101, 7, 26)
                end

                surface.SetDrawColor(Color(255,255,255,255))
                surface.SetMaterial(Material("retro_hud/bullet.png"))
                for i = 1,extra do
                    surface.DrawTexturedRect((ScrW() - 42) - i*7, ScrH() - 100, 5, 24)
                end
            else
                surface.SetDrawColor(Color(255,255,255,255))
                surface.SetMaterial(Material("retro_hud/no_bullet.png"))
                for i = 1,50 do
                    surface.DrawTexturedRect(ScrW() - 43 - i*7, ScrH() - 101, 7, 26)
                end

                surface.SetDrawColor(Color(255,255,255,255))
                surface.SetMaterial(Material("retro_hud/bullet.png"))
                for i = 1,50 do
                    surface.DrawTexturedRect((ScrW() - 42) - i*7, ScrH() - 100, 5, 24)
                end

                draw.SimpleText("+"..(extra - 50), "osrhud1", ScrW() - 43, ScrH() - 129, Color(0,0,0), 2)
                draw.SimpleText("+"..(extra - 50), "osrhud1", ScrW() - 44, ScrH() - 130, Color(255,255,0), 2)
            end
        end
    end

	end

end
hook.Add("HUDPaint", "OSRHUD", OSRHUD)

local tohide = { -- This is a table where the keys are the HUD items to hide
["CHudHealth"] = true,
["CHudBattery"] = true,
["CHudAmmo"] = true,
["CHudSecondaryAmmo"] = true
}
local function HUDShouldDraw(name) -- This is a local function because all functions should be local unless another file needs to run it
  if Enabled:GetInt() <= 0 then return; end
if (tohide[name]) then     -- If the HUD name is a key in the table
	return false;      -- Return false.
end
end
hook.Add("HUDShouldDraw", "OSR HUD hider", HUDShouldDraw)

local function TheMenu( Panel )
	Panel:ClearControls()
	//Do menu things here
	Panel:AddControl( "Checkbox", {
		Label = "Toggle HUD",
		Command = "rsh_enabled",
		}
	)

	Panel:AddControl( "Checkbox", {
		Label = "Toggle HUD Numbers",
		Command = "rsh_numbers",
		}
	)
end

local function createthemenu()
	spawnmenu.AddToolMenuOption( "Options", "DyaMetR", "osrh", "Retro Style HUD", "", "", TheMenu )
end
hook.Add( "PopulateToolMenu", "osrh_menu", createthemenu )
