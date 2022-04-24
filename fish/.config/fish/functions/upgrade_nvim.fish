function upgrade_nvim
    brew reinstall neovim
    npm install -g neovim
    pip2 install --upgrade pynvim
    pip3 install --upgrade pynvim
end
