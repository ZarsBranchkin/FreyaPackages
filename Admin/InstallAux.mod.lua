return function(package, p2)
  -- Support upgrade
  if p2 then package = p2 end;
  local root = package.Package.Parent;
  -- Until I sort out extra recursion,
  -- This will do
  if p2 then
    game.StarterPlayer.StarterPlayerScripts.FreyaAdminClient:Destroy();
    game.ServerScriptService.FreyaAdminServer:Destroy();
  end
  root.FreyaAdminClient.Parent = game.StarterPlayer.StarterPlayerScripts;
  root.FreyaAdminServer.Parent = game.ServerScriptService;
end
