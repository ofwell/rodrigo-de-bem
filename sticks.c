#include <stdio.h>

int i, j, linesNumber = 0, currentSticks[20], totalSticks = 0, count = 0, rmv = 0, line = 0, player = 1, option;

// Draws the pyramid
void pyramidGenerator(){

    for(i=0;i<linesNumber;i++){
        
        // This if else keeps the pyramid correctly built when the displaying line number is bigger than 9 (uses 2 or more digits).
        if(i+1 > 9) printf("%d ->", i+1);
        else printf("%d -> ", i+1);
        

        for(j=0;j <= (19 - i);j++) printf(" ");
            while(count != currentSticks[i]){
                printf("|");
                count++;
            }

        printf("\n");
        count = 0;
    }

}

// Function to select number of sticks to remove
void pyramidRemove(){

    printf("Sticks to remove: ");
    scanf("%d", &rmv);
    fflush(stdin);

    while(rmv <= 0 || rmv > currentSticks[line-1] || rmv == totalSticks){
        printf("\nERROR: !! Invalid number of sticks !! \n\n");
        printf("Sticks to remove: ");
        scanf("%d", &rmv);
        fflush(stdin);
    }

    currentSticks[line-1] = currentSticks[line-1] - rmv;
    totalSticks = totalSticks - rmv;
}

// Choose line to remove from
void lineSelect(){

    line = 0;

    if(player == 1)
        printf("\n== PLAYER 1 ==\n");
    else
        printf("\n== PLAYER 2 ==\n");

    printf("Line number: ");
    scanf("%d", &line);
    fflush(stdin);

    while(line <= 0 || line > linesNumber){
        printf("\nERROR: !! This line is nonexistent !! Pick another \n");
        printf("Line number: ");
        scanf("%d", &line);
        fflush(stdin);
    }

    if(currentSticks[line-1] < 1){
        printf("\nERROR: !! No sticks in this line !! Pick another \n");
        lineSelect();
    }

}

// Initialize the numbers on the pyramid
void pyramidInitializer(){

    for(i=0;i<linesNumber;i++) // Defines the quantity of sticks in each line
        currentSticks[i] = ( (i+1) * 2 ) - 1;

    for(i=0;i<linesNumber;i++) // Count all the sticks when initialized
        totalSticks = totalSticks + currentSticks[i];
}

int main(){
    
    printf("The sticks pyramid game is simple. \n - Two players. \n - In your turn, remove as many sticks as you want from one line. \n - The goal is to make your opponent be left with the last stick. \n > Good luck and have fun! \n ");
    
    while(linesNumber < 1 || linesNumber > 20){
        printf("Number of lines on the pyramid (1 to 20): ");
        scanf("%d", &linesNumber);
    }

    system("clear");

    pyramidInitializer();

    pyramidGenerator();

    while(totalSticks > 1){

        option  = 0;

        while(option != 1 && option != 2 && option != 3){
            printf("\n== OPTION MENU (Player %d) ==\n", player);
            printf("1 -> Play\n");
            printf("2 -> Check total of sticks\n");
            printf("3 -> Check total of sticks in a specific line\n");
            printf("Option selected: ");
            scanf("%d", &option);
        }

        if(option == 1){

            lineSelect();
            pyramidRemove();

            if(player == 1)
                player = 2;
            else
                player = 1;

            system("clear");
            pyramidGenerator();
        }

        if(option == 2){
            system("clear");
            pyramidGenerator();
            printf("\n>>>>> Total sticks in game: %d <<<<<\n", totalSticks);

        }

        if(option == 3){
            printf("\nChoose a line (1 to %d): ", linesNumber);
            line = 0;
            scanf("%d", &line);
            while (line <=0 || line > linesNumber){
                printf("ERROR: !! Invalid line!!\n");
                printf("Choose a line (1 to %d): ", linesNumber);
                scanf("%d", &line);
            }
            system("clear");
            pyramidGenerator();
            printf("\n>>>>> Total sticks in line %d: %d <<<<< \n", line, currentSticks[line-1]);

        }

    }

    if(player == 1) printf("\n\nCONGRATULATIONS TO PLAYER 2! THANKS FOR PLAYING!\n\n");
        else printf("\n\nCONGRATULATIONS TO PLAYER 1! THANKS FOR PLAYING!\n\n");

    return 0;
}
