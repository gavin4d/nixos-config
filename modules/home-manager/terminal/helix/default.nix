{pkgs, ...}:
{
  home.packages = with pkgs; [
    helix
    vscode-langservers-extracted
  ];
  
  programs.helix = {
    enable = true;
    languages = {
      language-server.cpp-lsp = { 
        command = "clangd"; 
        args = [
          "--compile-commands-dir=compile_commands_directory"
        ];
      };
      language-server.verilog-lsp= { 
        command = "svls"; 
      };
      language-server.tinymist = {
        config = {
          exportPdf = "onDocumentHasTitle";
          formatterMode = "typstyle";
          outputPath = "$root/$dir/$name";
        };
      };
      language-server.css-lsp = {
        command = "vscode-css-language-server";
      };

      language = [
        {
          name = "cpp";
          indent = { 
            tab-width = 4; 
            unit = " "; 
          };
        }
        {
          name = "verilog";
        }
      ];
    };
    settings = {
      theme = "base16_transparent";
      editor = {
        bufferline = "always";
        file-picker = {
          hidden = false;
          git-ignore = false;
        };
        indent-guides.render = true;
        auto-pairs = true;
        line-number = "relative";
        insert-final-newline = false;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        statusline.center = ["version-control" "register"];
      };
    };
  };
}
