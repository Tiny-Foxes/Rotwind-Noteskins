-- from scratch, with various references.
local Noteskin = ... or {};

-- element redirs
Noteskin.ElementRedirs = {
	-- ["element"] = "redir_element";
	-- Instead of separate hold heads, use the tap note graphics.
	["Roll Head Inactive"] = "Tap Note";
	["Roll Head Active"] = "Tap Note";
};

-- button redirs
-- o2jam uses this order:
-- [white][blue][white][yellow][white][blue][white]
Noteskin.ButtonRedirs = {
	Key1		= "Red";   --
	Key2		= "Grey";  --
	Key3		= "Blue";   --A
	Key4		= "White";  --
	Key5		= "Green";  --S
	Key6		= "Grey";  --
	Key7		= "Blue";   --D
	Key8		= "White";  --
	Key9		= "Red";  --F
	Key10		= "Yellow";--Space
	Key11		= "Red";  --J
	Key12		= "White";  --
	Key13		= "Blue";   --K
	Key14		= "Grey";  --
	Key15		= "Green";  --L
	Key16		= "White";  --
	Key17		= "Blue";   --;
	Key18		= "Grey";  --
	Key19		= "Red";   --
};

-- things to blank out
Noteskin.Hide = {
	-- ["element"] = true/false;
	["Hold TopCap active"] = true;
	["tap fake"] = true;
};

-- rotations
Noteskin.BaseRotX = {
	Left	= 0;
	UpLeft	= 0;
	Up		= 0;
	Down	= 0;
	UpRight	= 0;
	Right	= 0;
};
Noteskin.BaseRotY = {
	Left	= 0;
	UpLeft	= 0;
	Up		= 0;
	Down	= 0;
	UpRight	= 0;
	Right	= 0;
};

local function NoteskinLoader()
	local Button = Var "Button"
	local Element = Var "Element"

	if Noteskin.Hide[Element] then
		-- Return a blank element. If SpriteOnly is set, we need to return a
		-- sprite; otherwise just return a dummy actor.
		local t;
		if Var "SpriteOnly" then
			t = LoadActor( "_blank" );
		else
			t = Def.Actor {};
		end
		return t .. {
			function(self)
				self:visible(false)
			end;
		};
	end;

	-- load element and button, using redirs
	local LoadElement = Noteskin.ElementRedirs[Element]
	if not LoadElement then
		LoadElement = Element;
	end;

	local LoadButton = Noteskin.ButtonRedirs[Button]
	if not LoadButton then
		LoadButton = Button;
	end;

	-- get path to thing
	local sPath = NOTESKIN:GetPath( LoadButton, LoadElement );

	-- make actor
	local t = LoadActor( sPath );

	-- apply rotation
	t.BaseRotationX=Noteskin.BaseRotX[sButton]
	t.BaseRotationY=Noteskin.BaseRotY[sButton]

	return t;
end

Noteskin.Load = NoteskinLoader;
Noteskin.CommonLoad = NoteskinLoader;
return Noteskin;
