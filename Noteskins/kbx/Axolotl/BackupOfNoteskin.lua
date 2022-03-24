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
	Key1		= "White"; --A
	Key2		= "Blue"; --W
	Key3		= "White"; --S
	Key4		= "Blue"; --E
	Key5		= "White"; --D
	Key6		= "Blue"; --R
	Key7		= "White"; --F
	Key8		= "Yellow"; --Space
	Key9		= "White"; --J
	Key10		= "Blue"; --U
	Key11		= "White"; --K
	Key12		= "Blue"; --I
	Key13		= "White"; --L
	Key14		= "Blue"; --O
	Key15		= "White"; --;
};

-- things to blank out
Noteskin.Hide = {
	-- ["element"] = true/false;
	["Hold TopCap active"] = true;
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
