int gameWidth = 30;
int gameHeight = 16;
int[][] gameBoard = new int[gameWidth][gameHeight];
float[][] percentageBoard = new float[gameWidth][gameHeight];
float mineDensity = 0.20625;
int totalMines;
//zorgt ervoor dat je niet kan dood gaan op de eerste beurt//.
boolean firstPlay;
boolean gameWin;
int lcx, lcy;

void setup()
{
    size(600,360);
    ellipseMode(CENTER);
    rectMode(CORNER);
    textSize(14);
    firstPlay = true;
    totalMines = 0;
    lcx = -1;
    lcy = -1;
    gameWin = false;
    
    //Zet het bord op en zet de mijnen neer
    for (int i = 0; i < gameWidth; i++)
    {
        for (int j = 0; j < gameHeight; j++)
        {
            if (random(0,4) < mineDensity)
            {
                gameBoard[i][j] = 9;
                totalMines++;
            }
            else
            {
                gameBoard[i][j] = -5;
            }
        }
    }
}

void draw()
{
    background(60);
    
    
    
    //tekened het bord
    stroke(0);
    for (int i = 0; i < gameWidth; i++)
    {
        for (int j = 0; j < gameHeight; j++)
        {
            // Als er geen mijn staat plaats nummer
            if (gameBoard[i][j] >= 0 && gameBoard[i][j] <= 8)
            {
                
                fill(120);
                rect(i*20,40+(j*20),20,20);
                
                //sellecteerd een kleur voor het nummer
                switch (gameBoard[i][j])
                {
                    case 0: fill(250); break;
                    case 1: fill(0,0,190); break;
                    case 2: fill(0,190,190); break;
                    case 3: fill(190,0,0); break;
                    case 4: fill(190,0,190); break;
                    case 5: fill(190,190,0); break;
                    case 6: fill(0,190,0); break;
                    case 7: fill(150,110,90); break;
                    case 8: fill(150); break;
                    default: fill(120); break;
                }
                
                // laat het nummer zien
                // als er geen mine is laat het vakje leeg
                if (gameBoard[i][j] != 0)
                {
                    text(gameBoard[i][j],6+(i*20),55+(j*20));
                    
                   
                    {
                      
                    }
                }
            }
            // zet een rode cirkel neer
            else if (gameBoard[i][j] == 10 || gameBoard[i][j] == 11)
            {
                fill(190,0,0);
                ellipse(10+(i*20),50+(j*20),20,20);
            }
            //zorgt ervoor dat de vakjes die niet gedrukt zijn om donkerder te zijn
            else
            {
                fill(60);
                rect(i*20,40+(j*20),20,20);
            }
        }
    }
    
    // If you've lost the game
    if (lcx != -1)
    {
        // This shows all of the mines.
        for (int i = 0; i < gameWidth; i++)
        {
            for (int j = 0; j < gameHeight; j++)
            {
                if (gameBoard[i][j] == 9)
                {
                    fill(190,0,0);
                    ellipse(10+(i*20),50+(j*20),20,20);
                }
            }
        }
        
        // Displays the game losing move in purple and also the "Try again" text at the top
        fill(190,0,190);
        text("Press Enter to try again!",200,25);
        ellipse(10+(lcx*20),50+(lcy*20),20,20);
    }
    
    // Test to see if you've won the game.
    if (totalMines == 0)
    {
        // If you have any false flags, you haven't won yet.
        int falseFlags = 0;
        for (int i = 0; i < gameWidth; i++)
        {
            for (int j = 0; j < gameHeight; j++)
            {
                if (gameBoard[i][j] == 11)
                {
                    falseFlags++;
                }
            }
        }
        
        // If none of the flags are falsely placed and no mines are left, you win.
        if (falseFlags == 0)
        {
            fill(190,0,190);
            text("YOU WIN! Press Enter to play again!",200,25);
            gameWin = true;
        }
    }
}

void keyPressed()
{
    // 'ENTER' restart het spel
    if (keyCode == ENTER && (lcx != -1 || gameWin))
    {
        setup();
    }
}

void mousePressed()
{
    
    
    {
        
        int mx = floor(mouseX / 20);
        int my = floor((mouseY-40) / 20);
        
        // zorgt ervoor dat jee een speelbare start hebt
        if (firstPlay && mouseButton == LEFT)
        {
            createSafeZone(mx,my);
            openSpace(mx,my);
            firstPlay = false;
        }
       //Zorgt ervoor dat je na de eerste zet af kan gaan
        else if (mouseButton == LEFT)
        {
            if (gameBoard[mx][my] == 9 || gameBoard[mx][my] == 10)
            {
                gameLoss(mx,my);
            }
            else
            {
                openSpace(mx,my);
            }
        }
       
        else if(!firstPlay && mouseButton == RIGHT)
        {
            // als je een mine markeerd word het correct gedaan
            if (gameBoard[mx][my] == 9)
            {
                gameBoard[mx][my] = 10;
                totalMines--;
            }
            // als je een mine incorrect markeerd word het aangegeven als incorrect
            else if (gameBoard[mx][my] == -1)
            {
                gameBoard[mx][my] = 11;
                totalMines--;
            }
            // als je de markeering op een mine weghaald word de mine weer terug geplaatst
            else if (gameBoard[mx][my] == 10)
            {
                gameBoard[mx][my] = 9;
                totalMines++;
            }
            // als je de markeering weg haalt maak het het vakje weer beschikbaar om open te maken
            else if (gameBoard[mx][my] == 11)
            {
                gameBoard[mx][my] = -1;
                totalMines++;
            }
        }
    }
}


void createSafeZone(int x, int y)
{
    
    for (int i = 0; i < 3; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            // zorgt ervoor dat de array werkt
            if ((x+i-1) < 0 || (y+j-1) < 0 || (x+i-1) >= 30 || (y+j-1) >= 16)
            {
                continue;
            }
            else
            {
               
                {
                    totalMines--;
                }
                
                gameBoard[x+i-1][y+j-1] = -1;
            }
        }
    }
}


void openSpace(int x, int y)
{
    //als je op een mine drukt
    if (gameBoard[x][y] == 9)
    {
        gameLoss(x,y);
    }
    
   
    
    
    if (countNearbyMines(x,y) == 0)
    {
       
        for (int i = 0; i < 3; i++)
        {
            for (int j = 0; j < 3; j++)
            {
                // checked of alles wel op het bord staat.
                if ((x+i-1) < 0 || (y+j-1) < 0 || (x+i-1) >= 30 || (y+j-1) >= 16)
                {
                    continue;
                }
                //opent de vlakken om waar geen mine staat
                else if (gameBoard[x+i-1][y+j-1] == -1 && countNearbyMines(x+i-1,y+j-1) == 0)
                {
                    gameBoard[x+i-1][y+j-1] = countNearbyMines(x+i-1,y+j-1);
                    openSpace(x+i-1,y+j-1);
                }
                // kijkt of er een mine naast zit
                else
                {
                    gameBoard[x+i-1][y+j-1] = countNearbyMines(x+i-1,y+j-1);
                }
            }
        }
    }
}

// geeft het nummer van mines aan
int countNearbyMines(int x, int y)
{
    int mineCount = 0;
    for (int i = 0; i < 3; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            if ((x+i-1) < 0 || (y+j-1) < 0 || (x+i-1) >= 30 || (y+j-1) >= 16)
            {
                continue;
            }
            else
            {
                if (gameBoard[x+i-1][y+j-1] == 9 || gameBoard[x+i-1][y+j-1] == 10)
                {
                    mineCount++;
                }
            }
        }
    }
    return mineCount;
}


int countNearbyFlags(int x, int y)
{
    int flagCount = 0;
    for (int i = 0; i < 3; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            if ((x+i-1) < 0 || (y+j-1) < 0 || (x+i-1) >= 30 || (y+j-1) >= 16)
            {
                continue;
            }
            else
            {
                if (gameBoard[x+i-1][y+j-1] == 10 || gameBoard[x+i-1][y+j-1] == 11)
                {
                    flagCount++;
                }
            }
        }
    }
    return flagCount;
}


//maakt de mine waar je op hebt gedrukt een andere kleur dan de andere mines
void gameLoss(int x, int y)
{
    lcx = x;
    lcy = y;
}
