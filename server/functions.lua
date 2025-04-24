function GetJob(source)
  if ESX then
      return ESX.GetPlayerFromId(source).getJob().name
  elseif QBCore then
      local Player = QBCore.Functions.GetPlayer(source)

      return Player.PlayerData.job.name
  elseif Ox then
      local player = Ox.getPlayer(source)

      return player.getGroup() -- Haven't used OX Core too much before, seeing from documentation that police and sheriff were stored as a group so that's what I'll assume is the job.
  end
end

function GetPlayer(source)
  if ESX then
      return ESX.GetPlayerFromId(source)
  elseif QBCore then
      return QBCore.Functions.GetPlayer(source)
  elseif Ox then
      return Ox.getPlayer(source)
  end
end

function GetPlayers()
  if ESX then
      return ESX.GetExtendedPlayers()
  elseif QBCore then
      return QBCore.Functions.GetPlayers()
  elseif Ox then
      return Ox.GetPlayers()
  end
end