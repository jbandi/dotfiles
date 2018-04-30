#!/usr/bin/env /Users/jbandi/.nvm/versions/node/v8.11.1/bin/node

const { lstatSync, readdirSync } = require('fs');
const { join, basename } = require('path');
const git = require('simple-git/promise');

const isDirectory = source => lstatSync(source).isDirectory();
const getDirectories = source =>
  readdirSync(source)
    .map(name => join(source, name))
    .filter(isDirectory);

const entryList = [];
addEntry = entry => entryList.push(entry);

const paths = [
  join(process.env.HOME, '/Dev/MyBitBucket/'),
  join(process.env.HOME, '/Dev/MyGithub/'),
  join(process.env.HOME, '/.dotfiles')
];

run();


function logRepoStatus(path, statusSummary) {
  // console.log(statusSummary);
  addEntry('--' + path);
  addEntry('--' + "Copy path | bash='echo' param1='" + path + " | pbcopy '");
  addEntry('--' + "Open location | bash='open' param1='" + path + "' ");
  addEntry('--' + "Open in SourceTree | bash='/Applications/SourceTree.app/Contents/Resources/stree' param1='" + path + "' terminal='false'" );
  addEntry('--' + "Open in Fork | bash='/Applications/Fork.app/Contents/Resources/fork_cli' param1='-C' param2='" + path + "' terminal='false'" );
  addEntry('-----');
  statusSummary.ahead > 0 && addEntry('--ahead: ' + statusSummary.ahead);
  statusSummary.behind > 0 && addEntry('--behind' + statusSummary.behind);

  for (let file of statusSummary.files) {
    const modifier = file.index.trim() + file.working_dir.trim();
    addEntry('--' + modifier + ' ' + file.path);
  }
}

async function logDirectory(d) {
  // console.log(d);

  try {
    const repo = git(d);
    const isRepo = await repo.checkIsRepo();
    if (isRepo) {
      let statusSummary = await git(d).status();
      //console.log(statusSummary);

      let repositoryEntry = basename(d);

      if (statusSummary.files.length > 0) {
        repositoryEntry += " | color='red'";
      }

      addEntry(repositoryEntry);
      logRepoStatus(d, statusSummary);
    }
  } catch (e) {
    addEntry('Error!', e);
  }
}

async function traverseDirectories(paths, action, level = 0) {
  for (let path of paths) {
    if (level === 0) {
      addEntry('---');
      addEntry(path);
      addEntry('---');
    }

    const repo = git(path);
    const isRepo = await repo.checkIsRepo();
    if (isRepo) {
      await action(path);
    } else {
      const dirs = getDirectories(path);
      const nextLevel = level + 1;
      await traverseDirectories(dirs, action, nextLevel);
    }
  }
}

async function run(){
  await traverseDirectories(paths, logDirectory);

  const symbol = entryList.length > 0 ? '❗' : '✅';
  const color = entryList.length > 0 ? 'red' : 'green';
  console.log(`${symbol}Git | color='${color}'`);
  console.log('---');

  for (const entry of entryList) {
    console.log(entry)
  }

}



