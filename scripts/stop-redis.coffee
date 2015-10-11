#!/usr/bin/env coffee



config =		require 'config'
path =			require 'path'
child =			require 'child_process'
fs =			require 'fs'



if not config.has 'redis.pidfile'
	throw new Error 'Missing `redis.pidfile` config.'
pidfile = path.join __dirname, '..', config.get 'redis.pidfile'



try
	pid = 0 + fs.readFileSync pidfile
catch
	console.error 'Redis server isn\'t running.'
	process.exit 1

server = child.execSync "kill #{pid}"

fs.unlinkSync pidfile

console.log "Redis server (#{pid}) stopped."
process.exit 0
