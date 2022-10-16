# RMIT-ProjectBrief
## Week 7 Assignment

This app will educate a user who has no experience with traffic lights about the meaning of each of their colours.

### Explanation:

- Two `UIView`s are shaped so to represent a traffic light which will appear as an animation upon launch;
- Three circular `UIButton`s represent the traffic lights and light up with the correct colour when the user taps;
- Two `UILabel`s will hold information as to what is happening in the view, either an explanation or an error message;
- A background `UIView` that will either have a neutral colour or the colour of the light pressed by the user.

### How to use: 

- The app starts off with a view of a traffic light with all lights "turned off" and an explanation ("tutorial") to the right as to how they work;
- The user is expected to press the lights in the correct order, starting from the green light, as explained in the "tutorial";
- If the user presses the same light twice, that light will "turn off" and the view will reset back to the "tutorial" view, therefore sequence will restart from green light;
- If the user presses the wrong light, the labels will display an error message explaining why the light pressed is wrong;
- If the user presses the correct light, the background view will have the same colour as the light the user pressed, the button will also change the background colour into the light that they represent and the labels will display an explanation of what those colours mean.
