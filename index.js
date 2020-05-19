'use strict';

const { spawnSync } = require('child_process');

function run_cmd(cmd, args) {
  const run = spawnSync(cmd, args);

  console.log(`stderr: ${run.stderr.toString()}`);
  console.log(`stdout: ${run.stdout.toString()}`);
}

function sudo_install(program) {
  let programs = program;
  if (!Array.isArray(program)) {
    programs = [program];
  }

  run_cmd('sudo', ['apt-get', 'install', '-y', ...programs]);
}

function install_docker() {
  run_cmd('sudo', [
      'apt-get',
      'remove',
      'docker',
      'docker-engine',
      'docker.io',
      'containerd',
      'runc',
    ]);

  run_cmd('')
    // sudo apt remove docker docker-engine docker.io containerd runc \
    //     && curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - \
    //     && sudo apt-key fingerprint 0EBFCD88 \
    //     && sudo add-apt-repository \
    //         "deb [arch=amd64] https://download.docker.com/linux/debian \
    //         $(lsb_release -cs) \
    //         stable" \
    //     && sudo apt update \
    //     && sudo apt install docker-ce docker-ce-cli containerd.io \
    //     && sudo docker run hello-world
}

sudo_install([
  // programs
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
  'libpq-dev',  // for postgres, particularly in python
]);

install_docker();
