--        ___    ___ _______   ________   ________  ________       _______      ___    ___ _______        ___    ___         _______  ________  ________  ________     
--        |\  \  /  /|\  ___ \ |\   ___  \|\   __  \|\   ____\     |\  ___ \    |\  \  /  /|\  ___ \      |\  \  |\  \       /  ___  \|\   __  \|\   ____\|\  ___  \    
--        \ \  \/  / | \   __/|\ \  \\ \  \ \  \|\  \ \  \___|_    \ \   __/|   \ \  \/  / | \   __/|   __\_\  \_\_\  \_____/__/|_/  /\ \  \|\  \ \  \___|\ \____   \   
--         \ \    / / \ \  \_|/_\ \  \\ \  \ \  \\\  \ \_____  \    \ \  \_|/__  \ \    / / \ \  \_|/__|\____    ___    ____\__|//  / /\ \   __  \ \_____  \|____|\  \  
--          /     \/   \ \  \_|\ \ \  \\ \  \ \  \\\  \|____|\  \  __\ \  \_|\ \  /     \/   \ \  \_|\ \|___| \  \__|\  \___|   /  /_/__\ \  \|\  \|____|\  \  __\_\  \ 
--         /  /\   \    \ \_______\ \__\\ \__\ \_______\____\_\  \|\__\ \_______\/  /\   \    \ \_______\  __\_\  \_\_\  \_____|\________\ \_______\____\_\  \|\_______\
--        /__/ /\ __\    \|_______|\|__| \|__|\|_______|\_________\|__|\|_______/__/ /\ __\    \|_______| |\____    ____   ____\\|_______|\|_______|\_________\|_______|
--        |__|/ \|__|                                  \|_________|             |__|/ \|__|               \|___| \  \__|\  \___|                   \|_________|         
--                                                                                                              \ \__\ \ \__\                                           
--                                                                                                               \|__|  \|__|                                           

function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
      local iter, id = initFunc()
      if not id or id == 0 then
        disposeFunc(iter)
        return
      end
      
      local enum = {handle = iter, destructor = disposeFunc}
      setmetatable(enum, entityEnumerator)
      
      local next = true
      repeat
        coroutine.yield(id)
        next, id = moveFunc(iter)
      until not next
      
      enum.destructor, enum.handle = nil, nil
      disposeFunc(iter)
    end)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end;


