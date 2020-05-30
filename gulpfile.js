const { parallel } = require('gulp');
const { spawnSync } = require('child_process');
const fsPromises = require('fs').promises;
const path = require('path');

const VSCODE_INSIDERS_USER_DIR = path.join(process.env.HOME, '.config', 'Code - Insiders', 'User');

const installVSCodeSettings = () => {
  const targetPath = path.join(VSCODE_INSIDERS_USER_DIR, 'settings.json');
  const srcPath = path.join(__dirname, './files/vscode-settings.json');
  return fsPromises.symlink(srcPath, targetPath);
};

const installVSCodeKeyboardMappings = () => {
  const targetPath = path.join(VSCODE_INSIDERS_USER_DIR, 'keybindings.json');
  const srcPath = path.join(__dirname, './files/vscode-keybindings.json');
  return fsPromises.symlink(srcPath, targetPath);
};

const installGitConfig = () => {
  const targetPath = path.join(process.env.HOME, '.gitconfig');
  const srcPath = path.join(__dirname, './files/.gitconfig');
  return fsPromises.symlink(srcPath, targetPath);
};

const installTmuxConfig = () => {
  const targetPath = path.join(process.env.HOME, '.tmux.conf');
  const srcPath = path.join(__dirname, './files/.tmux.conf');
  return fsPromises.symlink(srcPath, targetPath);
};

const installLinuxEssentials = (cb) => {
  const toInstall = [
    'apt-transport-https',
    'build-essential',
    'ca-certificates',
    'curl',
    'git',
    'gnupg2',
    'python3-dev',
    'python3-pip',
    'cmake',
    'software-properties-common',
    'tmux',
    'tree',
    'xsel',
    'baobab',
    'ncdu',
    'ffmpeg',
    'file',
    'silversearcher-ag',
    'libpq-dev', // for postgres, particularly in python
  ];

  spawnSync('sudo', ['apt-get', 'install', '-y', ...toInstall]);
  cb();
};

module.exports = {
  vscode: parallel(
    installVSCodeSettings,
    installVSCodeKeyboardMappings,
  ),
  installVSCodeSettings,
  installVSCodeKeyboardMappings,
  shell: parallel(
    installGitConfig,
    installTmuxConfig,
  ),
  installGitConfig,
  installTmuxConfig,
  installLinuxEssentials,
};
