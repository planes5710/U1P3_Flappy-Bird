

import ddf.minim.*;

Minim minim;
AudioPlayer smash;
AudioPlayer pass;

PImage bird;
PImage sky;


float birdX = 100;
float birdY = 400;

float ySpeed = 0;
float gravity = 0.4;

int screen = 0;
int score = 0;

float[] Xs = new float[1000];
float[] Hs = new float[1000];
boolean[] Is = new boolean[1000];


void setup()
{
  size(800, 800);
  minim = new Minim(this);
  smash = minim.loadFile("smash.mp3");
  pass = minim.loadFile("pass.mp3");

  bird = loadImage("bird1.png");
  sky = loadImage("background.jpg");

  bird.resize(60, 50);
  sky.resize(width, height);

  for (int i=0; i < 1000; i++)
  {
    Xs[i] =600 + i*270;
    Hs[i] =(int)random(100, 600);
    Is[i]= false;
  }
}

void draw()
{
  if (screen == 0)
  {
    IntroPage();
  }
  if (screen == 1)
  {
    Game();
  }
  if (screen == 2)
  {
    GameOver();
  }
}
void IntroPage()
{
  background(sky);
  textSize(37);
  text("Flappy Bird", 300, 200);
  text("PRESS SPACE TO PLAY", 210, 400);
  if (keyPressed)
  {
    if (key == ' ')
    {
      screen = 1;
    }
  }
}

void Game()
{
  background(sky);


  image(bird, birdX, birdY);


  birdY += ySpeed;

  if (ySpeed < 3.5)
  {
    ySpeed += gravity;
  }

  if (keyPressed)
  {
    if (key == ' ')
    {
      ySpeed = -5;
    }
  }



  for (int i=0; i < 100; i++)
  {
    fill(88, 178, 61);
    rect(Xs[i], 0, 20, Hs[i]);
    Xs[i] = Xs[i] - 2.5;

    rect(Xs[i], Hs[i] + 200, 20, height);

    if (birdX < Xs[i] + 20 &&
      birdX + 50 > Xs[i] &&
      birdY < 0 + Hs[i] &&
      birdY + 50 > 0)
    {
      smash.play();
      screen = 2;
    }

    if (birdX + 5 < Xs[i] + 20 &&
      birdX + 50 > Xs[i] &&
      birdY < height &&
      birdY + 50 > Hs[i]+ 200)
    {
      smash.play();
      screen = 2;
    }

    if (birdY > height)
    { 
      smash.play();
      screen = 2;
    }

    textSize(25);
    text("Score: " + score, 75, 75);



    if (Xs[i]<110)
    {
      if (Is[i]==false)
      {
        Is[i]= true;
        score = score + 1;

        if (pass.position() >= pass.length()-2)
        {
          pass.rewind();
          pass.play();
        } else
        {
          pass.play();
        }
      }
    }
  }

fill(255);
  textSize(25);
  text("Score: " + score, 75, 75);
}

void GameOver()
{
  fill(255);
  textSize(50);
  text("Game Over", 250, 250);
  text("Press Space to Restart", 140, 450);

  if (keyPressed)
  {
    if (key == ' ')
    {
      screen = 1;
      score = 0;

      smash.rewind();
      smash.pause();

      for (int i=0; i < 1000; i++)
      {
        Xs[i] =600 + i*270;
        Hs[i] =(int)random(100, 600);
        Is[i]= false;
      }
    }
  }
}
