# Proposals
This is a implementation in elixir for the bcred test that you can find here:
https://github.com/bcredi/teste-backends

## How to run this project?
The first thing you need to do is to clone this repository which you can do by copying this command:
`git clone git@github.com:thiagoramos23/example-bcred-teste.git`

You can also fork the project which is something I really think you should consider to do if you want to make some changes in the project and push to github.

After that you will need to do the following:
- mix deps.get
- mix deps.compile
- mix test

The first and second commands will get the dependencies needed to run the project and compile everything to the .beam.
The third command will run the tests and if everything is green you should be good to go.

This project has the implementation for the BCred test for backends.
A simple resume is that it will receive events as one giant string with one or more proposals and it's dependencies which include proponents and warranties.
The goal of this project is to return the UUID of the proposals that are valid aftert consuming the string that was sent.

## TODO:
- [ ] Implement the GenServer / GenStage ( with Flow? ) to make it concurrent
- [ ] Make it receive files instead of a gigantic String.


## Youtube

This project has a series of videos that I am doing in my youtube channel. If you understand Brazilian Portuguese you are more than welcome to watch the videos.
In them I try to explain everything that I am doing so you can follow and code together, each one of them has about 50 minutes duration. Hope you enjoy.

Here is the link: https://youtu.be/qVUUv-BzZj4
