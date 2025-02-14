{pkgs, ...}:
{
  home.packages = with pkgs; [
    helix
    glibc
    # llvmPackages_18.clang-unwrapped
    vscode-langservers-extracted
    typescript-language-server
    vhdl-ls
    verible
    svls
    zls
    nil
    # python311Packages.python-lsp-server
    nodePackages.bash-language-server
    # typst-lsp
    tinymist
    typstyle
    llvmPackages_latest.lldb
    llvmPackages_latest.libllvm
    llvmPackages_latest.libcxx
    llvmPackages_latest.clang
    clang-tools
    stdmanpages
    man-pages
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
          name = "typescript";
          file-types = ["tsx"];
          language-servers = ["typescript-language-server"];
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
