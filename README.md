# Vapor

Vapor is a command-line utility that allows you to view and connect to Source game servers (Team Fortress 2, Counter-Strike: Source, etc.) as well as keep tabs on your Steam friends. Instead of launching Steam, followed by TF2, to see if it's worth joining your favorite server, you can just run `vapor server list` to see how many players are online and what the current map is. Then you can connect with `vapor server connect [server alias]`.

![Screenshot](http://i.imgur.com/3nvdU8k.png)

## Installation

First, ensure that you have Ruby 1.9.x installed. (Vapor was written on Ruby 1.9.3.) You also need to have RubyGems. With those prerequisites aside, installation should be a simple matter of:

    gem install steam-vapor

## Usage

**Servers**

* `vapor server add nickname 127.0.0.1` — Save a server to Vapor's server list. The default port used is 27015, though you can specify another by inputting it after the IP/domain (with a space as a separator). The custom nickname is how Vapor keeps track of the server.
* `vaport server rm nickname` — Remove the server corresponding to "nickname."
* `vapor server connect nickname` — Launch Steam and connect to the server corresponding to "nickname."
* `vapor server list` — View a listing of every server you have saved, complete with player counts and the current map.
* `vaport server info nickname` — Display the same information as `vapor server list`, but with a listing of players and their scores.

**Users**

* `vapor user mynameis you` — (Replace "you" with your Steam username or numeric ID.) This tells Vapor who you are so the friends list will work.
* `vapor user friends` — Displays a listing of your Steam friends, with their current status.
* `vapor user profile username` — Displays a brief overview of the profile matching "username."

Note: For the most accurate command listing, use the `vapor` command's built-in help function.
