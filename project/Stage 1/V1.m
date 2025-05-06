%rules of blackjack: https://bicyclecards.com/how-to-play/blackjack

%This project is a blackjack simulator

% V1-This version of the code aims to identify the cards and deal them for
% the dealer and the user.
% Date - 19/03/2025
% Improvements/bug testing in this version- adding ace to total as 1 or 11, not
% printing hidden dealer cards

clc
clear

%initialising dealer and player hands and totals;
dealer_hand = [];
player_hand = [];
dealer_sum = 0;
player_sum = 0;


for i = [1:2]
    %picking random card to deal from 1-13 for the amount of numbers + face
    %cards
    deal = randi(13, 1);
    dealer_hand = [dealer_hand, deal];
    dealer_sum = dealer_sum + deal;
    deal = randi(13, 1);
    player_hand = [player_hand, deal];
    player_sum = player_sum + deal;
end
    
%output
fprintf("Dealers Hand: ?, %d \n", dealer_hand(2));
fprintf("Players Hand: %d, %d \n",player_hand(1), player_hand(2));
fprintf("Dealer Total: %d \n Player Total: %d \n", dealer_sum, player_sum);



