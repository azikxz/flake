{
  lib,
  ...
}:

with lib;
# WARN: require Claude Pro/Max

mkIf false {
  hm.programs.claude-code = {
    enable = true;

    memory.text = '''';

    mcpServers = {
      filesystem = {
        args = [
          "-y"
          "@modelcontextprotocol/server-filesystem"
          "/tmp"
        ];
        command = "npx";
        type = "stdio";
      };
    };

    settings = {
      env = {
        CLAUDE_CODE_ENABLE_TELEMETRY = 0;
      };
    };
  };
}
