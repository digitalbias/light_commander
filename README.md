# Nerves Device

The idea behind this project is to create a Raspberry PI device that controls a strand of WS2182B LEDs and allow it to be configured via a web interface. It is a basic poncho project. You can read more about [Poncho Projects] and see the [example] used for this project as well.

There is a new branch for each state of the project. Just to show the progression of how this app was created. They are numbered in order that I did them. It starts with the `0_getting_started` branch and builds up from there.

## Building

The make file should have everything needed. If there is a problem with the compilation, than usually you can figure that out by going into the directory that is giving you problems and building in there with a simple `mix compile`.

### Prerequisites

* nerves_bootstrap

There is a makefile contained in the root directory. It should help get things started off fairly easily. This does assume you have already installed nerves_bootstrap. Before running the first build, you will need to copy the .env.sample file and configure it for your environment.

## Playing with the app

You can ssh into the console on the device, and since it copied your public key you should be good to go.

In the console my favorite thing to use is RingLogger.next(). That helps me see what has happened and see any debug messages I may have put in there to test what is going on. Always a helpful thing.

To exit out of the console type `~.` It's the special escape exit sequence for ssh.

[Poncho Projects]: http://embedded-elixir.com/post/2017-05-19-poncho-projects/
[example]: https://github.com/nerves-project/nerves_examples/tree/master/hello_phoenix