%rules of blackjack: https://bicyclecards.com/how-to-play/blackjack

%This project is a blackjack simulator

% V2 - This version itegrates the black jack stand and hit mechanics
%Date - 17/04/2025
% Improvements/bug testing in this version- fixing bug of two aces that break the game
clc
clear

%initialising dealer and player hands and totals;
dealer_hand = string([]);
player_hand = string([]);
dealer_sum = [0:0];
player_sum = [0:0];
dealer_hidden_sum = 0;

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
        dealer_sum = [dealer_sum + 1, dealer_sum + 11];
    end
    
    deal_p = randi(13, 1);
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
        player_sum = [player_sum + 1, player_sum + 11];
    end  
end

%Loop to calculated dealer sum when the card is hidden
if (deal_d >= 2) && (deal_d <= 10)
    dealer_hidden_sum = dealer_hidden_sum + deal_d;
elseif (deal_d >= 11) && (deal_d <= 13)
    dealer_hidden_sum = dealer_hidden_sum + 10;
end 
   

%output to dealer and player hands
fprintf("Dealer Hand: ?, %s \n", dealer_hand(2));
fprintf("Player Hand: %s, %s \n \n",player_hand(1), player_hand(2));

%loop to check if the dealer or player hand includes an ace
if length(dealer_sum) == 2
    %loop checking if the ace is hidden or not
    if dealer_hand(1) == "A"
        fprintf("Dealer Sum: %s \n", dealer_hand(2));
    else
        fprintf("Dealer Sum: 1 or 11 \n");
    end
else
    %do not need this code as of now as it would spoil the dealers hand
    %only one of the dealers cards hands are shown in blackjack
    fprintf("Dealer Sum: %d \n",dealer_hidden_sum);
end
if length(player_sum) == 2
    fprintf("Player Sum: %d or %d \n", player_sum(1), player_sum(2));
else
    fprintf("Player Sum: %d \n", player_sum(1));
end

%stand or hit mechanics
stand_hit = input("Stand or hit (S or H): ", "s");
hit_count = 0;
while stand_hit == "H" || stand_hit == "h"
    if stand_hit == "H" || stand_hit == "h" || stand_hit == "Hit" || stand_hit == "hit"
        deal_p = randi(13, 1);
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
            player_sum = [player_sum + 1, player_sum + 11];
        end
        hit_count = hit_count + 1;
        %outputting all the cards after hitting
        fprintf("Player Sum: ")
        for i = 1:(hit_count + 2)
            fprintf("%s, ", player_hand(i))      
        end
        fprintf("\n")

        %outputting the newplayersum after hitting
        if length(player_sum) == 2
            fprintf("Player Sum: %d or %d \n", player_sum(1), player_sum(2));
        else
            fprintf("Player Sum: %d \n", player_sum(1));
        end
    end
    stand_hit = input("Stand or hit (S or H): ", "s");
end

%output for playersum
if length(player_sum) == 2
    fprintf("Player Sum: %d or %d \n", player_sum(1), player_sum(2));
else
    fprintf("Player Sum: %d \n", player_sum(1));
end

