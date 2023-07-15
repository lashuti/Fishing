# FishyFishing
#### Video Demo: https://youtu.be/G62BgIlKQ9E
#### Description:
My final project for CS50x is a tiny game called FishyFishing which, you guessed it, is about fishing.
You are at a lake with two fishing spots and control a player which can go to those fishing spots. 

Don't look at the visual aspect too much. Didn't spend a lot of time on it :D

The game has three "phases". The first one is when you're not fishing and walking around the lake.

The second one is fishing phase, which starts when you've arrived at a fishing spot and pressed "E" on your keyboard.
During fishing phase, you will see ten fish which are same in color and speed and eleventh fish which has different color and is faster - that's our target!
You control a hook, which you can move around and you have to collide that hook with the target fish. When you do, the third, Catching phase starts.

During the final, Catching phase, two bars appear, the bar on the right side shows your progress of catching the fish. It is half-full and starts depleting immediately
The bar on the left is the catching bar, where you will see a fish icon and a rectangle. The fish moves up and down randomly, often changing direction.
The rectangle is under your control. by pressing W and S or UpArrow and DownArrow you can control the rectangle and your objective is to make sure that the fish is inside the rectangle.
When it is, the progress bar starts rising, when it isn't it starts depleting. And you've guessed it, when the progress bar reaches the bottom, it means that the fish escaped.
But when it reaches the top, it means you've caught the fish and the Caught Fish counter goes up! 

Either way, after the catching phase, whether the fish escaped or you caught it, you return to the lake as a player and have the freedom to either fish at the same spot, or go to the other one.

Now lets talk a bit about code. I tried to make the code loosely-coupled, without many magic numbers or undescriptive variables.
Tried not to change global variables in some random files which would make it harder to debug or understand code in the future, instead
thats why I introduced states, which, when changed, whatever needs to happen is written inside main.

In the main file, we load all the other scripts, images, initialize game objects, draw backgrounds etc..

Player class is responsible for moving and starting the catching phase when near fishing spot.

The Fish class is relatively simple as well, only responsible for swimming around and rending on the screen.

Hook class however, is responsible for it's own movement, as well as detecting collision with the target fish.

Catching and filling (progress) bars are connected to each other, catching bar is responsible for rectangle which we control,
the round fishy's random movement and detecting whether or not we are touching the round fishy with out rectangle.

The filling/progress bar checks if it's catching phase and catching bar's rectangle is touching the fish, depending on that it updates
the progress bar every frame, either growing or shrinking it.

Progress bar is also responsible for checking whether we caught the fish or not. When the bar reaches either the top or bottom, catching phase ends
and we are back on the main screen. Only difference is, if the bar reaches the top, we get a point too.

Thanks for reading.
This was CS50x wooooooooooooooooooooo!
David Malan you're the best 😘
