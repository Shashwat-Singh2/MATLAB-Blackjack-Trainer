%rules of blackjack: https://bicyclecards.com/how-to-play/blackjack

%This project is a blackjack simulator

% V5 - This version integrates a loop for the player to continously play
%Date - 21/03/2025
% Improvements/bug testing in this version-realised that dealer stands on a
% soft value before 21 had to fix this bug
clc
clear

%while loop to replay the code
play = "yes";
while (play == "yes") || (play == "y") ||(play == "Yes") || (play == "Y")

    %initialising variables and arrays
    dealer_hand = string([]);
    player_hand = string([]);
    dealer_sum = [0:0];
    player_sum = [0:0];
    dealer_hidden_sum = [0:0];
    hit_count = 0;
    outcome = 0;
    standhit = "0";
    bust = 0;
    finalPsum = 0;
    finalDsum = 0;
    
    %for 2 times for each card
    for i = 1:2
        %picking random card to deal from 1-13 for the amount of numbers + face
        %cards
        deal_d = randi(13, 1);
        
        %loop for dealers cards
        if (deal_d >= 2) && (deal_d <= 10)
            dealer_hand = [dealer_hand, deal_d];
            dealer_sum = [dealer_sum + deal_d];
        elseif deal_d == 11
            dealer_hand = [dealer_hand, "J"];
            dealer_sum = [dealer_sum + 10];
        elseif deal_d == 12
            dealer_hand = [dealer_hand, "Q"];
            dealer_sum = [dealer_sum + 10];
        elseif deal_d == 13
            dealer_hand = [dealer_hand, "K"];
            dealer_sum = [dealer_sum + 10];
        elseif deal_d == 1
            dealer_hand = [dealer_hand, "A"];
            %adding a hard value(where ace is considered 11) and a soft value
            %(where ace is considered 1)
            dealer_sum = [dealer_sum(1) + 1, dealer_sum(1) + 11];
        end
        
        deal_p = randi(13, 1);
        %deal_p = 1;
         %loop for players cards
        if (deal_p >= 2) && (deal_p <= 10)
            player_hand = [player_hand, deal_p];
            player_sum = player_sum + deal_p;
        elseif deal_p == 11
            player_hand = [player_hand, "J"];
            player_sum = [player_sum + 10];
        elseif deal_p == 12
            player_hand = [player_hand, "Q"];
            player_sum = [player_sum + 10];
        elseif deal_p == 13
            player_hand = [player_hand, "K"];
            player_sum = [player_sum + 10];
        elseif deal_p == 1
            player_hand = [player_hand, "A"];
            player_sum = [player_sum(1) + 1, player_sum(1) + 11];
        end  
    end
    
    %Loop to calculate the dealer sum when the card is hidden
    if (deal_d >= 2) && (deal_d <= 10)
        dealer_hidden_sum = dealer_hidden_sum + deal_d;
    elseif (deal_d >= 11) && (deal_d <= 13)
        dealer_hidden_sum = dealer_hidden_sum + 10;
    elseif deal_d == 1
        dealer_hidden_sum = [dealer_hidden_sum + 1, dealer_hidden_sum + 11];
    end 
       
    
    %output to dealer and player hands
    fprintf("Dealer Hand: ?, %s \n", dealer_hand(2));
    fprintf("Player Hand: %s, %s \n \n",player_hand(1), player_hand(2));
    
    %loop to check if the dealer or player hand includes an ace
    if length(dealer_hidden_sum) == 2
        %loop checking if the ace is hidden or not
        if dealer_hand(1) == "A"
            if dealer_hand(2) == "A"
                fprintf("Dealer Sum: 1 or 11 \n");
            else
                fprintf("Dealer Sum: %s \n", dealer_hand(2));
            end
        else
            fprintf("Dealer Sum: 1 or 11 \n");
        end
    else
        %do not need this code as of now as it would spoil the dealers hand
        %only one of the dealers cards hands are shown in blackjack
        fprintf("Dealer Sum: %d \n",dealer_hidden_sum(1));
    end
    
    
    if length(player_sum) == 2
        if (hit_count == 0) && (player_sum(2) == 21)
            player_sum = 21;
            outcome = 1;
            finalPsum = 21;
        else
            fprintf("Player Sum: %d or %d \n", player_sum(1), player_sum(2));
            finalPsum = player_sum(2);
        end
    else
        fprintf("Player Sum: %d \n", player_sum(1));
        finalPsum = player_sum;
    end
    
    %stand or hit mechanics
    if outcome ~= 1 %if its not a blackjack
        stand_hit = input("Stand or hit (S or H): ", "s");
        
        while stand_hit == "H" || stand_hit == "h" || stand_hit == "Hit" || stand_hit == "hit"
            deal_p = randi(13, 1);
            %deal_p = 1;
            if (deal_p >= 2) && (deal_p <= 10)
                player_hand = [player_hand, deal_p];
                player_sum = player_sum + deal_p;
            elseif deal_p == 11
                player_hand = [player_hand, "J"];
                player_sum = [player_sum + 10];
            elseif deal_p == 12
                player_hand = [player_hand, "Q"];
                player_sum = [player_sum + 10];
            elseif deal_p == 13
                player_hand = [player_hand, "K"];
                player_sum = [player_sum + 10];
            elseif deal_p == 1
                player_hand = [player_hand, "A"];
                player_sum = [player_sum(1) + 1, player_sum(1) + 11];
            end
            hit_count = hit_count + 1;
        
            %outputting all the cards after hitting
            fprintf("Player Cards: ");
            for i = 1:(hit_count + 2)
                fprintf("%s, ", player_hand(i));      
            end
            fprintf("\n");
            
            %outputting the newplayersum after hitting
            if length(player_sum) == 2
                if player_sum(2) > 21
                    fprintf("Player Sum: %d \n", player_sum(1));
                    finalPsum = player_sum(1);
                else
                    fprintf("Player Sum: %d or %d \n", player_sum(1), player_sum(2));
                    finalPsum = player_sum(2);
                end
            else
                fprintf("Player Sum: %d \n", player_sum);
                finalPsum = player_sum;
            end
            
            %outputting if its bust or 21 after checking if an Ace has been served
            if length(player_sum) >= 2
                if (player_sum(1) > 21) && (player_sum(2) > 21)
                    fprintf("\nBust! \n");
                    bust = 1;
                    break;
                elseif (player_sum(1) == 21) || (player_sum(2) == 21)
                    break;
                end
            else
                if player_sum > 21
                    fprintf("\nBust! \n");
                    bust = 1;
                    break;
                elseif player_sum == 21
                    break;
                end
            end
        
            stand_hit = input("Stand or hit (S or H): ", "s");
        end
    else
        fprintf("\nBLACKJACK!! \n");
    end
    
    %dealer can either deal until 17 or just show cards depending on if player busted
    deald_count = 0;
    if bust == 0
        dealersumindex = length(dealer_sum);
        if (length(dealer_sum) == 2) &&(dealer_sum(2) >= 17) && (dealer_sum(1) < 17)
            dealersumindex = 1;
        end
        while dealer_sum(dealersumindex) < 17
            deald_count = deald_count + 1;
            deal_d = randi(13, 1);
            if (deal_d >= 2) && (deal_d <= 10)
                dealer_hand = [dealer_hand, deal_d];
                dealer_sum = [dealer_sum + deal_d];
            elseif deal_d == 11
                dealer_hand = [dealer_hand, "J"];
                dealer_sum = [dealer_sum + 10];
            elseif deal_d == 12
                dealer_hand = [dealer_hand, "Q"];
                dealer_sum = [dealer_sum + 10];
            elseif deal_d == 13
                dealer_hand = [dealer_hand, "K"];
                dealer_sum = [dealer_sum + 10];
            elseif deal_d == 1
                dealer_hand = [dealer_hand, "A"];
                dealer_sum = [dealer_sum(1) + 1, dealer_sum(1) + 11];
            end
            if (length(dealer_sum) == 2) &&(dealer_sum(2) >= 17) && (dealer_sum(1) < 17)
                dealersumindex = 1;
            end
        end
        %dealer output 
        fprintf("\nDealer Cards: ");
        for i = 1:(deald_count + 2)
            fprintf("%s, ", dealer_hand(i));  
        end
        fprintf("\n");
        
        if length(dealer_sum) == 2
            if dealer_sum(2) > 21
                fprintf("Dealer Sum: %d \n", dealer_sum(1));
                finalDsum = dealer_sum(1);
            else
                fprintf("Dealer Sum: %d \n", dealer_sum(2))
                finalDsum = dealer_sum(2);
            end
        else
            fprintf("Dealer Sum: %d \n", dealer_sum);
            finalDsum = dealer_sum;
        end
    else
        %dealer output if player busted
        fprintf("\nDealer Cards: ");
        for i = 1:2
            fprintf("%s, ", dealer_hand(i));  
        end
        fprintf("\n");
    
         if length(dealer_sum) == 2
            if dealer_sum(2) > 21
                fprintf("Dealer Sum: %d \n", dealer_sum(1));
                finalDsum = dealer_sum(1);
            else
                fprintf("Dealer Sum: %d \n", dealer_sum(2))
                finalDsum = dealer_sum(2);
            end
        else
            fprintf("Dealer Sum: %d \n", dealer_sum);
            finalDsum = dealer_sum;
        end
    end
    
    %code to check and output if dealer or player won
    if bust == 1
        fprintf("\n dealer wins...");
    else
        if finalDsum == finalPsum
            if deald_count == hit_count
                fprintf("\nSplit pot");
            elseif deald_count < hit_count
                fprintf("\nClose however dealer wins...");
            elseif deald_count > hit_count
                fprintf("\nplayer win")
            end
        elseif finalDsum > finalPsum
            if finalDsum > 21
                fprintf("\nDealer busts, player wins");
            elseif finalDsum <= 21
                fprintf("\nDealer wins...")
            end
        elseif finalDsum < finalPsum
            fprintf("\nplayer win");
        end
    end
    
    play = input("\n\nPlay Again? ", "s");
    fprintf("\n");
end


fprintf("\n");
