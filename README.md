# Projects_7-9_Hangman_Game
The 100 Days of Swift

Game guess the word from scratch

This is the first challenge that involves you creating a game. You’ll still be using UIKit, though, so it’s a good chance to practice your app skills too.

The challenge is this: make a hangman game using UIKit. As a reminder, this means choosing a random word from a list of possibilities, but presenting it to the user as a series of underscores. So, if your word was “RHYTHM” the user would see “??????”.

The user can then guess letters one at a time: if they guess a letter that it’s in the word, e.g. H, it gets revealed to make “?H??H?”; if they guess an incorrect letter, they inch closer to death. If they seven incorrect answers they lose, but if they manage to spell the full word before that they win.

That’s the game: can you make it? Don’t underestimate this one: it’s called a challenge for a reason – it’s supposed to stretch you!

Day 41
https://www.hackingwithswift.com/100


TODO: All works fine for single player, logic should not be changed
1) First screen should be 
3) Add multiplayer for 2 persons on 1 phone:
    a) In string line were in single player shows "Single player" we should see "Player 1" or "Player 2". It depends on whose turn is now
    b) Score should count individually for each player 
    c) If first player guessed correct letter in the question word he have one more try, but if not than it is time for second player 
    d) If at level 1 first player had first move, than at level 2 second player will move first, at level 3 first, at level 4 second and so on...
    
