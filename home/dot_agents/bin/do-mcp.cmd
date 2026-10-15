@echo off
rem DigitalOcean MCP server (stdio). The token comes from doctl's current auth
rem context at launch, so it is never stored in an MCP client's config.
rem Override the service list with DO_MCP_SERVICES. Unix twin: do-mcp.
setlocal
set "DIGITALOCEAN_API_TOKEN="
for /f "delims=" %%t in ('doctl auth token 2^>nul') do set "DIGITALOCEAN_API_TOKEN=%%t"
if not defined DIGITALOCEAN_API_TOKEN (
  echo do-mcp: doctl is not logged in on this host; run: doctl auth init 1>&2
  exit /b 1
)
if not defined DO_MCP_SERVICES set "DO_MCP_SERVICES=droplets,networking,accounts,volumes,docs"
rem Run npx outside the home tree: npm enforces devEngines from any package.json
rem above the cwd, and a stray ~/package.json pinning bun makes npx exit.
cd /d "%SystemDrive%\"
npx -y @digitalocean/mcp@1 --services %DO_MCP_SERVICES%
